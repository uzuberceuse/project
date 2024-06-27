package hotelReservation.controller.reservation;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import hotelReservation.dto.CustomerInfo;
import hotelReservation.dto.reservation.CstReserve;
import hotelReservation.dto.reservation.MyReserve;
import hotelReservation.dto.reservation.Reserve;
import hotelReservation.dto.reservation.ReserveInfo;
import hotelReservation.svc.reservation.PaySvc;
import hotelReservation.svc.reservation.ReserveSvc;
import hotelReservation.util.DateCal;



@Controller
public class ReserveCtrl {
 
	@Autowired
	private ReserveSvc reserveSvc; 
	@Autowired
	private PaySvc paySvc;
	@Autowired
	private HttpSession session;
	

	// 로그인 예약자 정보 작성값 가져오기(view->ctrl)
	@RequestMapping(value="/mReserveInfo", method= RequestMethod.POST)
	public String mReserveInfo(ModelMap model,
			@ModelAttribute ReserveInfo reserveInfo) throws ParseException {
		
		String confirm = reserveInfo.getConfirm();
		Reserve reserve = (Reserve)session.getAttribute("reserve");

		if(confirm.equals(reserveInfo.getEmail())) {

			Reserve retReserve = reserveSvc.mReserveInfo(reserveInfo, reserve);
			session.setAttribute("reserve", retReserve);
		
			String tcode = retReserve.getTcode();
			
			DateCal date = new DateCal(); 
			int days = date.dateCal(retReserve.getCheckOut(), retReserve.getCheckIn());
			int tprice = (paySvc.priceInfo(tcode))*days;
			
			model.addAttribute("tprice", tprice);

			return "reservation/payInfo";
		} 
		else {
			String cid = (String) session.getAttribute("cid");
			CustomerInfo cInfo = reserveSvc.customerInfo(cid);
			model.addAttribute("cInfo", cInfo);
			model.addAttribute("check", "N");
			
			return "reservation/mReserveInfo";
		}
	}

	
	// 로그인 안한 예약자 정보 작성값 가져오기(view->ctrl)
	@RequestMapping(value="/nReserveInfo", method= RequestMethod.POST)
	public String nReserveInfo( ModelMap model,
			@ModelAttribute ReserveInfo reserveInfo) {
		
			String confirm = reserveInfo.getConfirm();
			Reserve reserve = (Reserve)session.getAttribute("reserve");
			
		if(confirm.equals(reserveInfo.getEmail())) {
			
			Reserve retReserve = reserveSvc.nReserveInfo(reserveInfo, reserve);
			session.setAttribute("reserve", retReserve);

			return "reservation/payLogIn";	
		}
		else {
			model.addAttribute("cInfo", reserveInfo);
			model.addAttribute("check", "N");
			
			return "reservation/nReserveInfo";
		}
	}
	
	
	// 호텔 고객 예약 페이지
	@RequestMapping(value="/hotelBook")
	public String hotelBook() {
		
		return "reservation/cReservation";
	}


	// 고객 내 예약 조회(ctrl->view)
	@RequestMapping(value="/myBook")
	public String myReservationPage(ModelMap model) {

		String cid = (String) session.getAttribute("cid");
		List<MyReserve> myReservation = reserveSvc.myReservation(cid);
		model.addAttribute("List", myReservation);
		
		return "reservation/myReservation";
	}
	
	
	// 고객 예약 취소 (view->ctrl)
	@RequestMapping(value="/myReservation", method= RequestMethod.POST)
	public String cancelReserve(@RequestParam("cancel") String rid, 
			ModelMap model) {
		
		model.addAttribute("check", "check");
		reserveSvc.cancelReserve(rid);
		
		String cid = (String) session.getAttribute("cid");
		List<MyReserve> myReservation = reserveSvc.myReservation(cid);
		model.addAttribute("List", myReservation);
		
		return "reservation/myReservation";
	}
	
	
	// 호텔 고객 예약 조회 (view->ctrl)
	@RequestMapping(value="/cReservation", method= RequestMethod.POST)
	public String cReservation(@ModelAttribute CstReserve cstReserve,
		 ModelMap model) {
		
		List<Reserve> bookList = reserveSvc.cReservation(cstReserve);
		model.addAttribute("bookList", bookList);
		return "reservation/cReservation";
	}
	
}