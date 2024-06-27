 package hotelReservation.controller.reservation;

import java.text.ParseException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import hotelReservation.dto.CustomerLogIn;
import hotelReservation.dto.HotelInfo;
import hotelReservation.dto.reservation.PayInfo;
import hotelReservation.dto.reservation.Reserve;
import hotelReservation.svc.reservation.PaySvc;
import hotelReservation.util.DateCal;

@Controller
public class PayCtrl {
	
	@Autowired
	private PaySvc paySvc;
	@Autowired
	private HttpSession session;
	

	//로그인 안한 회원 로그인(payLogin view-> ctrl)
	@RequestMapping(value="/payLogIn", method=RequestMethod.POST)
	public String payLogIn(@ModelAttribute CustomerLogIn cl, ModelMap model) throws ParseException {
	
		Reserve reserve = (Reserve)session.getAttribute("reserve");
		String result = paySvc.payLogIn(cl, reserve);
		
		if(result.equals("no_id")) {
			model.addAttribute("result", result);
			return "reservation/payLogIn";
		} 
		else if(result.equals("wrong_pw")) {
			session.setAttribute("cid", cl.getCid());
			model.addAttribute("result", result);
			return "reservation/payLogIn";
		}			
		else {
			session.setAttribute("cid", cl.getCid());
			DateCal date = new DateCal(); 
			int days = date.dateCal(reserve.getCheckOut(), reserve.getCheckIn());
			int tprice = (Integer.parseInt(result))*days;	
			model.addAttribute("tprice", tprice);
			return "reservation/payInfo";
		}
	}


	// 결제 정보 작성값 가져오기(view->ctrl)
	@RequestMapping(value="/payInfo", method=RequestMethod.POST)
	public String payInfo(@ModelAttribute PayInfo payInfo, ModelMap model) {
		
		// 세션으로 예약정보 객체가져오기
		Reserve reserve = (Reserve)session.getAttribute("reserve");
		String result = paySvc.payInfo(payInfo, reserve);
		
		if(result.equals("rInputFail")) {
			return "reservation/payInfo";
		} else if(result.equals("pInputFail")) {
			return "reservation/payInfo";
		} else {
			// 예약완료 정보 가져오기
			HotelInfo hInfo = paySvc.completeInfo(result);
			model.addAttribute("hname", hInfo.getHname());
			model.addAttribute("location", hInfo.getLocation());
			model.addAttribute("rid", reserve.getRid());
			model.addAttribute("rdate", reserve.getRdate());
			model.addAttribute("tprice", payInfo.getTprice());

			//세션 예약 정보 객체 소멸
			session.removeAttribute("reserve");

			return "reservation/reserveConfirm";
		} 
	}
	
}
