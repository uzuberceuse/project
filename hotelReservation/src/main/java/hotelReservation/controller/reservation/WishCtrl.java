package hotelReservation.controller.reservation;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import hotelReservation.controller.GoodsCtrl;
import hotelReservation.dto.CustomerInfo;
import hotelReservation.dto.reservation.CheckReserve;
import hotelReservation.dto.reservation.MyWishList;
import hotelReservation.dto.reservation.Reserve;
import hotelReservation.dto.reservation.WishReserve;
import hotelReservation.svc.reservation.ReserveSvc;
import hotelReservation.svc.reservation.WishSvc;

@Controller
public class WishCtrl {
	
	@Autowired
	private WishSvc wishSvc;
	@Autowired
	private HttpSession session;
	@Autowired
	private ReserveSvc reserveSvc;
	@Autowired
	private GoodsCtrl goodsctrl;
	
	// hDetails 찜하기 or 찜취소
	@RequestMapping(value="/hDibs", method=RequestMethod.POST)
	public String hDibs(@RequestParam("dibs") String dibs, Model model) {
		
		String cid= (String)session.getAttribute("cid");
		String tcode= dibs.substring(0, 10);
		String hid = tcode.substring(0, 7);
		String check = dibs.substring(10);
		String confirm = "P";
		
		if(check.equals("Y")) {
			String success = wishSvc.cancelDibs(cid, tcode);
			if(success.equals("Y")) {
				model.addAttribute("dibs", "N");
				confirm="C";
			}	
		}
		else {
			String ok = wishSvc.myWishNo(cid);
			
			if(ok.equals("Y")) {
				String success = wishSvc.addDibs(cid, tcode);
				if(success.equals("Y")) {
					confirm="D";
					model.addAttribute("dibs", "Y");
				} 
			} else {
			   confirm="NP";
			}
		}
		model.addAttribute("confirm", confirm);
		return goodsctrl.hDetails(hid, model);
	}
	
	
	// gDetails 찜하기 or 찜취소
		@RequestMapping(value="/gDibs", method=RequestMethod.POST)
		public String gDibs(@RequestParam("dibs") String dibs, Model model) {
			
			String cid= (String)session.getAttribute("cid");
			String tcode= dibs.substring(0, 10);
			String check = dibs.substring(10);
			String confirm = "N";
	
			if(check.equals("Y")) {
				String success = wishSvc.cancelDibs(cid, tcode);
			
				if(success.equals("Y")) {
					model.addAttribute("dibs", "N");
					String wishNo = wishSvc.gWishNo(tcode);
					model.addAttribute("wishNo", wishNo);
					confirm="C";
				}	
			}
			else {
				String ok = wishSvc.myWishNo(cid);
				if(ok.equals("Y")) {
					String success = wishSvc.addDibs(cid, tcode);
					if(success.equals("Y")) {
						confirm="D";
						model.addAttribute("dibs", "Y");
						String wishNo = wishSvc.gWishNo(tcode);
						model.addAttribute("wishNo", wishNo);
					} 
				} else {confirm="NP";}
			}
			
			model.addAttribute("confirm", confirm);
			return goodsctrl.gDetails(tcode, model);
		}
	
	//회원 찜한 목록(ctrl-> view)
	@RequestMapping(value="/myWishPage")
	public String myWishPage(ModelMap model) {
		
		String cid = (String)session.getAttribute("cid");
		List<MyWishList> myWishList = wishSvc.myWishList(cid);
		model.addAttribute("wishList", myWishList);
		
		return "reservation/myWishList";
	}
	
	
	// 찜 목록 취소하기
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(ModelMap model, @RequestParam("tcode") String tcode) {
		
		String cid= (String)session.getAttribute("cid");
		wishSvc.cancelDibs(cid, tcode);
	
		return "forward:/myWishPage";
	}
	
	
	// 찜 목록 예약하기
	// 호텔명 객실타입, 가격 정보 넘기기
	@RequestMapping(value="/myWishList", method=RequestMethod.POST)
	public String myWishList(ModelMap model, @RequestParam("radio") String tcode) {
		
		WishReserve info = wishSvc.reserve(tcode);
	    model.addAttribute("info", info);
	    model.addAttribute("tcode", tcode);
		return "reservation/wishReservation";
	}
	
	// 예약 가능 확인
	//잔여 객실 수 확인
	@RequestMapping(value="/wishCheck", method=RequestMethod.POST)
	public String wishCheck(ModelMap model, CheckReserve cr) {
		
		Reserve reserve = wishSvc.check(cr);
		String cid= (String)session.getAttribute("cid");
	
		if(reserve!=null) {
			CustomerInfo cInfo = reserveSvc.customerInfo(cid);
			model.addAttribute("cInfo", cInfo);
			reserve.setLastname(cInfo.getLastname());
			reserve.setFirstname(cInfo.getFirstname());
			reserve.setEmail(cInfo.getCmail());
			reserve.setCid(cid);
			reserve.setTcode(cr.getTcode());
			
			session.setAttribute("reserve", reserve);
			return "reservation/mReserveInfo";
		} 
		else {
			model.addAttribute("check", "N");
			return "reservation/wishReservation";
		}
	}
	
	
}
