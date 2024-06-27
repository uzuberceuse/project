package hotelReservation.dto.reservation;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Stock {

	private String tcode;
	private String checkIn;
	private String checkOut;
	
	
	public Stock(String tcode, String checkIn, String checkOut) {
		this.tcode = tcode;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
	}
	
}
