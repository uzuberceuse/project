<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>객실 등록</title>
    <link rel="stylesheet" href="css/review/rRegister.css" /> 
</head>
<body>
    <%@ include file="../main/side.jsp" %>
    <div class="form-container">
        <h2>리뷰 작성</h2>
        <form action="/projects/rRegister" method="post" >
            <fieldset>
                <div class="form-grid">
                	
                    <div>
                        <label for="tname">상품명:</label>
                        <input type="text" id="tname" name="tname" value="${data.tname}" readonly required>
                    </div>
					<div>
                        <label for="usedate">이용날짜:</label>
                        <input type="text" id="usedate" name="usedate" value="${data.usedate}" readonly required>
                    </div>
                    <input type="hidden" id="rid" name="rid" value="${data.rid}">
                    <input type="hidden" id="cid" name="cid" value="${data.cid}">
                	<input type="hidden" id="tcode" name="tcode" value="${data.tcode}">
                	<input type="date" id="rdate" name="rdate" >
                    <div>
                       <label for="ratingValue">평점:</label>
	                   <div class ="star_rating">
						  <span class="star on" data-value="1"> </span>
						  <span class="star" data-value="2"> </span>
						  <span class="star" data-value="3"> </span>
						  <span class="star" data-value="4"> </span>
						  <span class="star" data-value="5"> </span>
						</div>
                    </div>
                     <input type="hidden" id="rating" name="rating">
                    <div class="full-width">
                        <label for="rcomment">후기:</label>
                      	<textarea class="star_box" placeholder="리뷰 내용을 작성해주세요."
                      		 id="rcomment" name="rcomment"></textarea>
                    </div>
                </div>
            </fieldset>
                 
            <div class="form-buttons">
                <input type="button" value="취소" onclick="history.back();">
                <input type="submit" value="등록">
            </div>
        </form>
    </div>
    <script>
	    document.addEventListener('DOMContentLoaded', function() {
	        const rdateInput = document.getElementById('rdate');
	        const currentDate = new Date();
	
	        // 현재 날짜를 YYYY-MM-DD 형식으로 포맷팅
	        const formattedDate = currentDate.toISOString().slice(0,10);
	
	        // input 요소의 값 설정
	        rdateInput.value = formattedDate;
	        console.log('Formatted Date:', formattedDate); // 확인용 로그
	    });
	    $(document).ready(function() {
	        $('.star_rating > .star').click(function() {
	            $(this).siblings().removeClass('on');
	            $(this).addClass('on').prevAll('.star').addClass('on');
	            
	            // 클릭된 별점의 값을 가져와 정수로 변환
	            const ratingValue = parseInt($(this).data('value'));
	            console.log('Selected Rating:', ratingValue);
	            
	            // 별점 값을 hidden input field에 설정
	            $('#rating').val(ratingValue);
	        });
	    });
	</script>
</body>
</html>
