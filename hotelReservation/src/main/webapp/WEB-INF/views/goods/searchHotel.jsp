<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>객실 조회</title>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
      <link rel="stylesheet" href="css/goods/searchHotel.css">
    <script>
	    document.addEventListener('DOMContentLoaded', function() {
	        const form = document.querySelector('form[action="/projects/searchHotel"]');
	        const aTags = document.querySelectorAll('a.prevent-click');
	
	        aTags.forEach(aTag => {
	            aTag.addEventListener('click', function(event) {
	                if (!form.checkValidity()) {
	                    event.preventDefault();
	                    alert('검색어를 입력해주세요.');
	                    location.reload();
	                }
	            });
	        });
	    });
    </script>
</head>
<body>
	<%@ include file="../main/header.jsp" %>
	<form action="/projects/searchHotel" method="POST" >
	    <div class="search-bar">	  
	   		<div class="search-keyword">
	          	<label for="hotel">호텔명</label>
                <input type="text" id="hname" name="hname" value="${param.hname}"  placeholder="검색어를 입력해주세요." >
	        </div>       
	        <div class="search-filters">
	            <input type="date" id="checkIn" name="checkIn" value="${param.checkIn}" required>
	            <input type="date" id="checkOut" name="checkOut" value="${param.checkOut}" required>
	            <select id="location" name="location" required>
	                <option value="all">==선택==</option>
	                <option value="seoul_gangnam" <c:if test="${param.location == 'seoul_gangnam'}">selected</c:if>>서울시 강남구</option>
	                <option value="seoul_jongno" <c:if test="${param.location == 'seoul_jongno'}">selected</c:if>>서울시 종로구</option>
	                <option value="seoul_mapo" <c:if test="${param.location == 'seoul_mapo'}">selected</c:if>>서울시 마포구</option>
	                <option value="seoul_seocho" <c:if test="${param.location == 'seoul_seocho'}">selected</c:if>>서울시 서초구</option>
	                <option value="seoul_songpa" <c:if test="${param.location == 'seoul_songpa'}">selected</c:if>>서울시 송파구</option>
	            </select>
	            <input type="text" id="person" name="person" value="${param.person}" placeholder="인원 수" required>
	            <input type="submit" value="검색">
	        </div>
	    </div>
    </form>
    <div class="hotel-list">
        <c:forEach var="hotel" items="${searchResult}">
	    	<div class="hotel-item">
	        	<%-- <img src="${hotel.tpicture}" alt="대표사진"> --%>
	            <div class="hotel-info">
	            	<h3><a class="prevent-click" href="/projects/hDetails?hid=${hotel.hid}">${hotel.hname}</a></h3>
	                <p>${hotel.grade}성급</p>
	            </div>
	            <div class="hotel-price">
	            	<b class="large_text"><fmt:formatNumber value="${hotel.tprice}" pattern="#,###" />KWR~</b>
	            </div>
	    	</div>
        </c:forEach>
    </div>

    <div class="pagination">
        <button>1</button>
    </div>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        var checkInInput = document.getElementById('checkIn');
        var checkOutInput = document.getElementById('checkOut');
        
        var offset = 1000 * 60 * 60 * 9;
        var today = new Date(Date.now() + offset);
        
       // 현재 이후 날짜만 선택
        checkInInput.min = today.toISOString().substring(0, 10);

        checkInInput.addEventListener('change', function() {
            if (checkInInput.value) {
                var selectedDate = new Date(checkInInput.valueAsDate.getTime() + offset +1);
                          
                var minDate = selectedDate.toISOString().substring(0, 10);

                checkOutInput.disabled = false;
                checkOutInput.min = minDate;
            }
        });
    });
    </script>
</body>
</html>