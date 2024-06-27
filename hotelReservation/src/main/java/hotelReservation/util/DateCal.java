package hotelReservation.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateCal {

	 String date1; //날짜1
	 String date2; //날짜2
	       
	 public int dateCal(String date1, String date2) throws ParseException  {
	    	   
	     Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
	     Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
	        
	     long diffSec = (format1.getTime() - format2.getTime()) / 1000; //초 차이
	     long diffDays = diffSec / (24*60*60); //일자수 차이
	     
	     int days = (int) diffDays;
	     return days;
	 }
	
}
