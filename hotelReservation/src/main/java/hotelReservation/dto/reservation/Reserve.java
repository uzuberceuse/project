package hotelReservation.dto.reservation;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Reserve {
	
	private String rid;
	private String rdate;
	private String firstname;
	private String lastname;
	private String email;
	private String country;
	private String request;
	private String checkIn;
	private String checkOut;
	private int person;
	private char cancel;
	private String pid;
	private String cid;
	private String tcode;
	
	public Reserve() {
		rid = null;
		rdate = null;
		checkIn = null;
		checkOut = null;
		person = 0;
		cancel = 'N';
		pid = null;
		cid = null;
		tcode = null;
	}
	public Reserve(String rid, String rdate, String firstname, String lastname, 
			String email, String country,String request,
			String checkIn, String checkOut, int person, char cancel, 
			String pid, String cid, String tcode) {
		this.rid = rid;
		this.rdate = rdate;
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.country = country;
		this.request = request;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.person = person;
		this.cancel = cancel;
		this.pid = pid;
		this.cid = cid;
		this.tcode = tcode;
	}
	
	
	@Override
	public String toString() {
		return "rid:"+ rid+ ", rdate:"+ rdate+", firstname:"+firstname+", lastname:"+lastname
				+ ", email:"+ email+", country:"+country+", request:" +request +
				", checkIn:" + checkIn+", checkOut:" +checkOut+", person:" +person
				+ ", cancel:" + cancel + ", pid:" + pid+", cid:"+ cid + ", tcode:" + tcode;
	}
	
}