<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객 예약 정보</title>
       <link rel="stylesheet" href="css/reservation/cReservation.css" /> 
</head>
<body>
  	   <%@ include file="../main/side.jsp" %>
    <form action="/projects/cReservation" method="POST" >
    <h1>고객 예약 정보</h1>
        <fieldset>
            <legend>검색 방법</legend>
        <div class="search-option">
                <input type="radio" name="search" value="1" required>
                <label for="customerId">고객 아이디</label>
                <input type="text" id="cid" name="cid" >
            </div>
            <div class="search-option">
                <input type="radio" name="search" value="2">
                <label for="reservationId">예약 아이디</label>
                <input type="text" id="rid" name="rid">
            </div>
            <div class="search-option">
                <input type="radio" name="search" value="3">
                <label for="reservationMonth">예약 날짜(YYYY-MM) </label>
                 <input type="month" id="mdate" name="mdate">
            </div>
            <div class="search-option">
                <input type="radio" name="search" value="4">
                <label for="reservationDate">예약 날짜(YYYY-MM-DD) </label>
                <input type="date" id="rdate" name="rdate">
            </div>
            <div class="search-button">
                 <input type="submit" value="검색">
            </div>
        </fieldset>
        <br>
  
    <table>
        <thead>
            <tr>
                <th>예약번호</th>
                <th>예약날짜</th>
                <th>FIRSTNAME</th>
                <th>LASTNAME</th>
                <th>EMAIL</th>
                <th>국적</th>
                <th>REQUEST</th>
                <th>CHECKIN</th>
                <th>CHECKOUT</th>
                <th>PERSON</th>
                <th>취소</th>
                <th>고객아이디</th>
                <th>상품코드</th>
            </tr>
        </thead>
        <tbody>
            <tr>
               	<c:forEach var="bookList" items="${bookList}">
						<tr>
				           	<td>${bookList.rid}</td>
             			    <td>${bookList.rdate.substring(0, 10)}</td>
             			   	<td>${bookList.firstname}</td>
              		   		<td>${bookList.lastname}</td>
               			    <td>${bookList.email}</td>
                		   	<td>${bookList.country}</td>
                			<td>${bookList.request}</td>
                			<td>${bookList.checkIn}</td>
                	   		<td>${bookList.checkOut}</td>
                			<td>${bookList.person}</td>
                			<td>${bookList.cancel}</td>
                		   	<td>${bookList.cid}</td>
                			<td>${bookList.tcode}</td>
						</tr>
				</c:forEach>
        </tbody>
    </table>
    </form>
</body>
</html>