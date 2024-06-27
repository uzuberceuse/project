<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
     <link rel="stylesheet" href="css/review/hReviewList.css" /> 
    <script>
        function setAnswerValue() {
            var checkbox = document.getElementById("answer");
            var hiddenInput = document.getElementById("hiddenAnswer");
            
            if (checkbox.checked) {
                hiddenInput.value = "Y";
            } else {
                hiddenInput.value = "N";
            }
        }
    </script>
</head>
<body>
       <%@ include file="../main/side.jsp" %>
        <div class="main-content">
		    <h1>호텔 리뷰 조회</h1>
		    <form action="/projects/reviewsearch" method="post" onsubmit="setAnswerValue()">
		    	<input type="hidden" id="hid" name="hid" value="${searchReview.hid}">
			     <div class="search-bar">
			        <div class="search-keyword">
			          	<label for="tcode">객실번호:</label>
		                <input type="text" id="tcode" name="tcode" placeholder="검색어 입력창" >
			        </div>
			        <div>
			        	 <input type="hidden" id="hiddenAnswer" name="answer" value="N">
               			 <input type="checkbox" id="answer" name="answerCheckbox" value="Y">미답변
			        </div>
			        <input type="submit" value="검색">
			    </div>
		    </form>
		    <table>
		        <thead>
		            <tr>
		                <th>객실번호</th>
		                <th>고객아이디</th>
		                <th>작성일</th>
		                <th>리뷰평점</th>
		                <th>예약번호</th>
		                <th>답변작성</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="List" items="${List}">
						<tr>
							<td>${List.tcode}</td>
		               		<td>${List.cid}</td>
		               	 	<td>${List.rdate.substring(0, 10)}</td>
					 		<td>${List.rating}</td>
					 		<td>${List.rid}</td>
					 		<td><c:if test="${List.answer eq null}">
					 				<button id='target_btn_1' onclick="location.href='/projects/hAnswerPage?rid=${List.rid}'">답변작성</button>
					 			</c:if>
					 			<c:if test="${List.answer ne null}">
					 				<button id='target_btn_2' disabled>작성완료</button>
					 			</c:if>
					 		</td>
						</tr>
					</c:forEach>
		        </tbody>
		    </table>
	     </div>
</body>
</html>