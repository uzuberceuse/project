<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>mReservation Form</title>
    <link rel="stylesheet" href="css/reservation/mReserveInfo.css" /> 

</head>
<body>
 	 <%@ include file="../main/header.jsp" %>
	<form action="/projects/mReserveInfo" method="POST">
   		<c:if test="${check eq 'N'}">
        	<script type="text/javascript">
			alert('이메일이 일치하지 않습니다. 정보를 다시 입력해주세요.');
			</script>
        </c:if>

        <label for="firstname">영문 이름 (First Name)<span style="color: red;">*</span></label><br>
        <input type="text" id="firstname" name="firstname" value="${cInfo.firstname}" readonly><br><br>
        
        <label for="lastname">영문 성 (Last Name)<span style="color: red;">*</span></label><br>
        <input type="text" id="lastname" name="lastname" value="${cInfo.lastname}" readonly><br><br>
        
        <label for="email">이메일<span style="color: red;">*</span></label><br>
        <input type="email" id="email" name="email" value="${cInfo.cmail}" readonly><br><br>
        
        <label for="confirm">이메일 재입력<span style="color: red;">*</span></label><br>
        <input type="email" id="confirm" name="confirm" required><br><br>
        
        <label for="country">거주 국가<span style="color: red;">*</span></label><br>
        <select id="country" name="country" required>
        	<option value="">국가 선택</option>
        	<option value="KOR">대한민국</option>
        	<option value="USA">미국</option>
        	<option value="JPN">일본</option>
        	<option value="CHN">중국</option>
        	<option value="GBR">영국</option>
        	<option value="ITA">이탈리아</option>
        	<option value="CAN">캐나다</option>
        	<option value="AUS">호주</option>
        	<option value="FRA">프랑스</option>
        	<option value="IND">인도</option>
        </select><br><br>
        
        <label for="request">요청 사항</label><br>
        <textarea id="request" name="request"></textarea><br><br>
        
        <input type="checkbox" id="privacy" name="privacy" required>
        <label for="privacy">개인 정보 동의</label><br><br>
        
        <button type="submit">결제하기</button>
	</form>
</body>
</html>