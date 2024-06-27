<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<body style="background-color: #F0FFF0;">
    <meta charset="UTF-8">
    <title>사이트명</title>
  	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/goods/Images.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" >
  	<link rel="stylesheet" href="css/main/main.css" /> 
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
	    
	    
	   body {
            font-family: Arial, sans-serif;
        }
        form {
        	display: flex;
            flex-direction: column;
            align-items: center;
            height: 30vh;
            margin-bottom: 50px;
            background-image:url('images/main/background.webp'); 
        }
        .search-bar {
        	flex-shrink: 0;
        	display: flex;
            border: 2px solid #dcedc8;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin: 20px auto;
            padding: 20px;
            width: 800px;
            background-color: #fff;
   			border-radius: 10px; /* 필요시 모서리 둥글게 */
        }
        .search-keyword, .search-filters {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .search-keyword input[type="text"], .search-filters input[type="date"], 
        .search-filters select, .search-filters input[type="text"] {
            flex: 1;
            padding: 10px;
            margin: 5px;
            box-sizing: border-box;
            border-radius: 10px;
            border: 2px solid #dcedc8;
        }
        .search-filters input[type="submit"] {
            padding: 10px;
            margin: 5px;
            border-radius: 10px;
        }
	    
	    
  	</style>
</head>
<body>
 	<%@ include file="../main/header.jsp" %>
	<form action="/projects/searchHotel" method="POST" >
	    <div class="search-bar">
	        <div class="search-keyword">
	          	<label for="hotel">호텔명</label>
                <input type="text" id="hname" name="hname" placeholder="검색어 입력창" >
	        </div>
	        <div class="search-filters">
	            <input type="date" id="checkIn" name="checkIn" required>
	            <input type="date" id="checkOut" name="checkOut" required>
	            <select id=location name="location" required>
	                <option>지역명</option>
	                <option value="seoul_gangnam">서울시 강남구</option>
	                <option value="seoul_jongno">서울시 종로구</option>
	                <option value="seoul_mapo">서울시 마포구</option>
	                <option value="seoul_seocho">서울시 서초구</option>
	                <option value="seoul_songpa">서울시 송파구</option>
	            </select>
	            <input type="text" id="person" name="person" placeholder="인원 수" required>
	            <input type="submit" value="검색">
	        </div>
	    </div>
    </form>
    
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <div class="swiper">
		  <!-- Additional required wrapper -->
		  <div class="swiper-wrapper">
		    <!-- Slides -->
		  	<div class="swiper-slide"><img src="<%= request.getContextPath() %>/images/hotel/main1.PNG" ></div>
		    <div class="swiper-slide"><img src="<%= request.getContextPath() %>/images/hotel/main2.PNG" ></div>
		    <div class="swiper-slide"><img src="<%= request.getContextPath() %>/images/hotel/main3.PNG" ></div>
		  </div>
		  <!-- 페이징 필요시 추가 -->
		  <div class="swiper-pagination"></div>
	</div>	
    <script src="<%= request.getContextPath() %>/js/goods/Images.js"></script>
    <script>
	    new Swiper('.swiper', {
			autoplay: {
			    // 자동재생 여부
			    delay: 3000, // 시작시간 설정
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
                var selectedDate = new Date(checkInInput.valueAsDate.getTime() + offset);
                          
                var minDate = selectedDate.toISOString().substring(0, 10);

                checkOutInput.disabled = false;
                checkOutInput.min = minDate;
            }
        });
    });
    </script>
</body>
</html>