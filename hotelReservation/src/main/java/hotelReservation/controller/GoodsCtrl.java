package hotelReservation.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import hotelReservation.dto.CustomerInfo;
import hotelReservation.dto.goods.Hdetails;
import hotelReservation.dto.goods.Room;
import hotelReservation.dto.goods.SearchHotel;
import hotelReservation.dto.goods.Tdetails;
import hotelReservation.dto.goods.Type;
import hotelReservation.dto.goods.UpdateHotelDetail;
import hotelReservation.dto.reservation.Reserve;
import hotelReservation.svc.GoodsSvc;
import hotelReservation.svc.ReviewSvc;
import hotelReservation.svc.reservation.ReserveSvc;
import hotelReservation.svc.reservation.WishSvc;
import lombok.Getter;
import lombok.Setter;

@Controller
@Getter
@Setter
public class GoodsCtrl {
	
	@Autowired
	private GoodsSvc goodsSvc;
	@Autowired
	private ReserveSvc reserveSvc;
	@Autowired
	private WishSvc wishSvc;
	@Autowired
	private ReviewSvc reviewSvc;
	@Autowired
	private HttpSession session;
	
	//객실 등록
	@RequestMapping(value="/gRegisterPage")
	public String goodsRegister( Model model,
			@ModelAttribute UpdateHotelDetail updateHotelDetail,
			@ModelAttribute Type type) {
		
		String hid = (String) session.getAttribute("hid");
		model.addAttribute("hotel", goodsSvc.selectHotel(hid));
		model.addAttribute("updateHotelDetail", updateHotelDetail);
		model.addAttribute("type", type);
		
		return "goods/gRegister";
	}
	
	@RequestMapping(value="/gRegister", method=RequestMethod.POST)
	public String insertGoods(Model model,
			@ModelAttribute UpdateHotelDetail updateHotelDetail,
			@ModelAttribute Type type) {
		
		if(session != null) {
			String hid = (String) session.getAttribute("hid");
			String tcode = goodsSvc.findMaxTcode(hid);
			model.addAttribute("updateHotelDetail", goodsSvc.updateHotel(hid, updateHotelDetail));	
			goodsSvc.updateHotel(hid, updateHotelDetail);
			int gCnt = goodsSvc.registerGoods(tcode, type, hid);
			model.addAttribute("type", gCnt);
		}
		
		return "goods/gDetailsRegister";
	}
	
	// 객실 세부정보 등록
	@RequestMapping(value="/gDetailsRegisterPage")
	public String gDetailsRegister(@ModelAttribute Tdetails tdetails, Model model) {
		
		model.addAttribute("tdetails", tdetails);
		
		return "goods/gDetailsRegister";
	}
	
	@RequestMapping(value="/gDetailsRegister", method=RequestMethod.POST)
	public String insertGoodsDetails( @ModelAttribute Tdetails tdetails,
			Model model ) {
		
		if(session != null) {
			String hid = (String) session.getAttribute("hid");
			String tcode = goodsSvc.findTcode(hid);
			tdetails.setTcode(tcode);
			model.addAttribute("tdetails", goodsSvc.registerGoodsDetails(tdetails));
		}
		
		return "main/main";
	}
	
	
	// 호텔리스트 출력
	@RequestMapping(value="/searchHotelPage")
	public String findHotel(Model model) {
		
		model.addAttribute("searchResult", goodsSvc.hotelList());
		return "goods/searchHotel";
	}
	
	
	// 검색 결과 출력
	@RequestMapping(value="/searchHotel", method=RequestMethod.POST)
	public String searchList(@ModelAttribute SearchHotel sh, Model model) {
			
		Reserve reserve = new Reserve();
		reserve.setCheckIn(sh.getCheckIn());
		reserve.setCheckOut(sh.getCheckOut());
		reserve.setPerson(sh.getPerson());
			
		session.setAttribute("reserve", reserve);
		String hname = sh.getHname();
			
		if(hname.equals(null)){
			model.addAttribute("searchResult", goodsSvc.searchList(sh));
		} else{
			model.addAttribute("searchResult", goodsSvc.searchHotel(sh));
		}
			
		return "goods/searchHotel";
	}


	
	// 예약 버튼 클릭
	@RequestMapping(value="/reserveButton", method=RequestMethod.POST)
	public String reserve(Model model) {
		
		String cid = (String)session.getAttribute("cid");
		
		if(cid!=null) {
			Reserve reserve = (Reserve) session.getAttribute("reserve");
			// 세션 예약 객체 정보에 고객 아이디 값 넣기 
			reserve.setCid(cid);
			
			// 고객아이디를 통해 고객 정보 가져오기
			CustomerInfo cInfo = reserveSvc.customerInfo(cid);
			model.addAttribute("cInfo", cInfo);
			reserve.setLastname(cInfo.getLastname());
			reserve.setFirstname(cInfo.getFirstname());
			reserve.setEmail(cInfo.getCmail());
			
			// 세션 객체 값 다시 전달
			session.setAttribute("reserve", reserve);
			
			return "reservation/mReserveInfo";
		} else {
			
			return "reservation/nReserveInfo";
		}
	}
	
	
	// 호텔 객실 정보 출력
	@RequestMapping(value="/hDetails")
	public String hDetails(@RequestParam("hid") String hid, Model model ) {
 
		Reserve reserve=(Reserve)session.getAttribute("reserve");
		int max  = reserve.getPerson();
        
		String checkIn = reserve.getCheckIn();
		String checkOut = reserve.getCheckOut();
		
		LocalDate dateIn = LocalDate.parse(checkIn);
		LocalDate dateOut = LocalDate.parse(checkOut);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd");
        checkIn = dateIn.format(formatter);        
        checkOut = dateOut.format(formatter);
        System.out.println(checkIn);
	
		Hdetails hdetails = new Hdetails(checkIn, checkOut, hid, max);
		
		model.addAttribute("hotel", goodsSvc.selectHotel(hid));
		
		List<Type> rooms = goodsSvc.hotelDetails(hdetails);
		model.addAttribute("rooms", rooms);
		
		//상품 찜 상태
		String cid= (String)session.getAttribute("cid");
		if(cid!=null) {
		Map<String, String> dibs = wishSvc.hWishList(cid, rooms);
		model.addAttribute("dibs", dibs);
		}

		return "goods/hDetails";
	}
	
	
	// 객실 세부정보 출력(ctrl->view)
	@RequestMapping(value="/gDetails")
	public String gDetails(@RequestParam("tcode") String tcode, Model model) {
	
		Reserve reserve=(Reserve)session.getAttribute("reserve");
		reserve.setTcode(tcode);
		model.addAttribute("tcode", tcode);
		
		//객체 값 들어가는지 확인
		session.setAttribute("reserve", reserve);
		model.addAttribute("room", goodsSvc.goodsType(tcode));
		model.addAttribute("details", goodsSvc.goodsDetails(tcode));
		model.addAttribute("reviewList", reviewSvc.reviewCus(tcode));
		
		//상품 찜 상태
		String cid= (String)session.getAttribute("cid");
		if(cid!=null) {
			String dibs = wishSvc.gWishList(cid, tcode);
			model.addAttribute("dibs", dibs);
			String wishNo = wishSvc.gWishNo(tcode);
			model.addAttribute("wishNo", wishNo);
		}
		return "goods/gDetails";
	}	
	
	// 호텔 - 객실리스트 조회
	@RequestMapping(value="/rooms")
	public String roomManage(Model model ) {
		
		if(session != null) {
			String hid = (String)session.getAttribute("hid");
			List<Room> rooms = goodsSvc.roomManage(hid);
	        model.addAttribute("rooms", rooms);
		}
		return "goods/roomManage";
	}
	
	
	// 호텔 - 객실삭제
	@RequestMapping(value="/roomsdelete")
	public String roomDelete(@RequestParam("tcode") String tcode, Model model ) {
	
		model.addAttribute(goodsSvc.deleteGoods(tcode));
				
		return "goods/roomManage";
	}
	
	// 호텔 - 객실수정
	@RequestMapping(value="/gUpdate")
	public String roomUpdatePage(@RequestParam("tcode") String tcode, Model model ) {
		model.addAttribute("type", goodsSvc.goodsType(tcode));
		model.addAttribute("tdetails", goodsSvc.goodsDetails(tcode));
		
		return "goods/gUpdate";
	}

	@RequestMapping(value="/roomsupdate", method=RequestMethod.POST)
	public String roomUpdate(Model model ,
			@ModelAttribute Type type,
			@ModelAttribute Tdetails tdetails, 
			@RequestParam("tcode") String tcode) {
		
		model.addAttribute(goodsSvc.updateGoods(type));
		model.addAttribute(goodsSvc.updateGoodsDetail(tdetails));
		
		 return "forward:/rooms";
	}
}
