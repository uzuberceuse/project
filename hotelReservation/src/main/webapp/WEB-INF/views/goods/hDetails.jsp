<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사이트명</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/goods/Images.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" >
	<link rel="stylesheet" href="css/goods/hDetails.css">
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
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <%@ include file="../main/header.jsp" %>
    <div class="swiper">
		  <!-- Additional required wrapper -->
		  <div class="swiper-wrapper">
		    <!-- Slides -->
		  	<div class="swiper-slide"><img src="<%= request.getContextPath() %>/images/hotel/milton/main1.PNG" ></div>
		    <div class="swiper-slide"><img src="<%= request.getContextPath() %>/images/hotel/milton/main2.PNG" ></div>
		    <div class="swiper-slide"><img src="<%= request.getContextPath() %>/images/hotel/milton/main3.PNG" ></div>
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

    <div class="hotel-info">
        <div class="hotel-details">
            <h1>${hotel.hname}</h1>
            <p>${hotel.location} | ${hotel.grade}성급 | ${hotel.hphone}</p>
        </div>
    </div>

    <div class="room-list">
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
	    <c:forEach var="room" items="${rooms}">
	        <div class="room-item">
	        <%-- <img src="${room.photo}" alt="객실 사진"> --%>
	        	<div class="room-details">
	            	<h3><a href="/projects/gDetails?tcode=${room.tcode}">${room.tname}</a></h3>
	                <p>인원: ${room.max}인</p>
	                <p>재고수량: ${room.amounts}개 남음</p>
	            </div>
	            <div class="room-price">
		        	<b class="large_text">가격: <fmt:formatNumber value="${room.tprice}" pattern="#,###" />KWR</b>
		        </div>                    
			    <div class="dibs">
				    <form action="/projects/hDibs" method="POST">
			        <%--세션아이디값이 있을 때만 찜할 수 있는 버튼 띄움 --%>     
				    <%	if(session.getAttribute("cid") != null){%>
				         <c:forEach var="dibs" items="${dibs}">
				           	<c:if test="${room.tcode eq dibs.key}">
				               	<c:choose>
				                	<c:when test="${dibs.value eq 'Y'}">
				                		<span><button class="dibs-button" name="dibs" value="${dibs.key}Y">
										<img src="<%= request.getContextPath() %>/images/dibs/redheart.png"></button></span>
									</c:when>
									<c:when test="${dibs.value eq 'N'}">
										<span><button class="dibs-button" name="dibs" value="${dibs.key}N">
										<img src="<%= request.getContextPath() %>/images/dibs/whiteheart.png"></button></span>
									</c:when>	
								</c:choose>
							</c:if>	
						</c:forEach>
					<%} %>
			        </form>
			    </div>
			</div>
		</c:forEach>
	</div>
</body>
</html>
