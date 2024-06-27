<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>객실정보</title>
    <link rel="stylesheet" href="css/goods/gDetails.css" /> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" >
    <script type="text/javascript" src="js/goods/gDetails.js"></script>
    <style type="text/css">
	  		.swiper {
			width:640px;
			height:380px;
			border: 2px solid #dcedc8;
			border-radius:7px;
			box-shadow:0 0 20px #ccc inset;
		}
		.swiper-slide {
			text-align:center;
			display:flex; /* 내용을 중앙정렬 하기위해 flex 사용 */
			align-items:center; /* 위아래 기준 중앙정렬 */
			justify-content:center; /* 좌우 기준 중앙정렬 */
		}
		.swiper-slide img {
			box-shadow:0 0 5px #555;
		}
		.swiper-pagination {
	        position: absolute;
	        left: 50%;
	        transform: translateX(-50%);
	        bottom: 20px;
	    }
  	</style>
</head>
<body>
 	<%@ include file="../main/header.jsp" %>
	<div class="header">
	    <button onclick="history.back();">이전</button>
	    <h1>객실정보</h1>
	</div>	
	<div class="content">
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<div class="swiper">
		  <!-- Additional required wrapper -->
		  <div class="swiper-wrapper">
		    <!-- Slides -->
		  	<div class="swiper-slide"><img src="<%= request.getContextPath() %>/images/hotel/milton/single1.PNG" ></div>
		    <div class="swiper-slide"><img src="<%= request.getContextPath() %>/images/hotel/milton/single2.PNG" ></div>
		  </div>
		  <!-- 네비게이션 지정 -->
	      <div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
		  <div class="swiper-button-prev"></div><!-- 이전 버튼 -->
		  <!-- 페이징 필요시 추가 -->
		  <div class="swiper-pagination"></div>
	</div>	
        <script>
		    new Swiper('.swiper', {
				autoplay: {
				    // 자동재생 여부
				    delay: 5000, // 시작시간 설정
				 },
				effect: "fade", 
				loop: true,
				// 페이저 버튼 사용자 설정
				pagination: {
				  // 페이지 번호 요소 선택자
				  el: '.swiper-pagination',
				  dynamicBullets: true,
				  clickable: true,
				},
				navigation : {
					nextEl : '.swiper-button-next', // 다음 버튼 클래스명
					prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
				},
			});
    	</script>
	    <div class="room-details">
	    	<form action="/projects/reserveButton" method="POST">
		        <div class="room-details-left">
		            <h2><span id="room-name">${room.tname}</span></h2>
		            <span id="room-capacity">${room.max}인실</span>
		        </div>
		        <div class="room-details-right">
		            <b class="large_text">가격: <fmt:formatNumber value="${room.tprice}" pattern="#,###" />KWR</b>
		            <div class="buttons">
		                <button id="reserveBtn" name="reserveBtn">예약</button>
		            </div>
		        </div>
			</form>	
		   	<form action="/projects/gDibs"  method="POST">        
		   		<% if(request.getAttribute("confirm")!=null) {%>
		   		<c:choose>
	            	<c:when test="${confirm eq 'C'}">
	     				<script type="text/javascript">
							alert('찜이 취소되었습니다.');
						</script>
	       			</c:when>		 
	       			<c:when test="${confirm eq 'D'}">
	     				<script type="text/javascript">
							alert('찜 목록에 가서 확인해보세요.');
						</script>
	       			</c:when>
	       			<c:when test="${confirm eq 'NP'}">
	     				<script type="text/javascript">
							alert('찜 목록이 다 찼습니다. 목록을 비워주세요.');
						</script>
	       			</c:when>
		    	</c:choose> 
		    	<%} %>
		        <%	if(session.getAttribute("cid") != null){%>
		        	<c:choose>
		            	<c:when test="${dibs eq 'Y'}">
							<span><button class="dibs-button" name="dibs" value="${room.tcode}Y">
							<img src="images/dibs/redheart.png">${wishNo}</button></span>
						</c:when>
						<c:when test="${dibs eq 'N'}">
							<span><button class="dibs-button" name="dibs" value="${room.tcode}N">
							<img src="images/dibs/whiteheart.png">${wishNo}</button></span>
						</c:when>
					</c:choose>	
				<%} %>
		    </form>      
		</div>
	</div>	
<div class="room-tabs">
    <div class="tab">
        <button class="tablinks" onclick="openTab(event, 'details')"><b>상세 정보</b></button>
          <button class="tablinks" onclick="openTab(event, 'reviews')" ><b>리뷰</b></button>
    </div>
    <div id="details" class="tabcontent">
        <div class="room-description">
            <h3>기본 정보</h3>
            ${details.exp}
        </div>
        <div class="room-description">
            <h3>서비스</h3>
            <pre>
베드구성: ${details.bedtype} ${details.bedno}개
객실전망: ${details.tview} View
흡연여부: ${details.smoke}
객실크기: ${details.tsize}㎡
욕실종류: ${details.bathtype}
조식여부: ${details.breakfast}
            </pre>
        </div>
    </div>
    <div id="reviews" class="tabcontent">
    <%@ include file="../review/gReview.jsp" %>
    </div>
</div>
