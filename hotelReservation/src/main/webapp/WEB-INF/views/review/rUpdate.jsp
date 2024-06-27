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
    <title>리뷰 등록</title>
	    <link rel="stylesheet" href="css/reservation/rUpdate.css" /> 
</head>
<body>
    <div class="form-container">
        <h2>리뷰 수정</h2>
        <form action="/projects/rUpdate" method="post" >
            <fieldset>
                <div class="form-grid">
                	<input type="hidden" id="rid" name="rid" value="${review.rid}">
                   <p>작성자: ${review.cname}</p>
				   <p>작성일: ${review.rdate}</p>
                	<input type="date" id="rdate" name="rdate" >
                    <div>
                       <label for="ratingValue">평점:</label>
	                   <div class="star_rating">
                            <span class="star ${review.rating >= 1 ? 'on' : ''}" data-value="1"> </span>
                            <span class="star ${review.rating >= 2 ? 'on' : ''}" data-value="2"> </span>
                            <span class="star ${review.rating >= 3 ? 'on' : ''}" data-value="3"> </span>
                            <span class="star ${review.rating >= 4 ? 'on' : ''}" data-value="4"> </span>
                            <span class="star ${review.rating >= 5 ? 'on' : ''}" data-value="5"> </span>
                        </div>
                    </div>
                    <input type="hidden" id="rating" name="rating" value="${review.rating}">
                    <div class="full-width">
                        <label for="rcomment">후기:</label>
                      	<textarea class="star_box" placeholder="리뷰 내용을 작성해주세요."
                      		 id="rcomment" name="rcomment" >${review.rcomment}</textarea>
                    </div>
                </div>
            </fieldset>
                 
            <div class="form-buttons">
                <input type="button" value="취소" onclick="history.back();">
                <input type="submit" id="btn_submit" name="btn_submit" onclick="self.close(); alert('수정되었습니다')" value="등록">
            </div>
        </form>
    </div>
   <script>
        $(document).ready(function() {
            // Initialization: Set the initial rating value
            const initialRating = parseInt($('#rating').val());
            $('.star_rating > .star').each(function() {
                if ($(this).data('value') <= initialRating) {
                    $(this).addClass('on');
                }
            });

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

        function validateForm() {
            const rating = $('#rating').val();
            if (!rating) {
                alert('별점을 선택해주세요.');
                return false;
            }
            alert('수정되었습니다');
            return true;
        }
    </script>
</body>
</html>
