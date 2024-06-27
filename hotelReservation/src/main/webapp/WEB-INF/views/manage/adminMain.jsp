<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
 src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- 부트스트랩 3.4.1버전을 적용하기 위한 링크태그와 스크립트 태그 -->
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<!-- favicon.co를 없애는 링크태그 -->
<script
 src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- jquery를 사용하기 위해 적용해둔 스크립트 코드 -->
<link href="/resources/css/main.css" rel="stylesheet">
<link rel="stylesheet" href="css/manage/adminMain.css" >
</head>
<body>
  <%@ include file="../main/side.jsp" %>
	<div id="gnb">
		<div  class="text-right" >
				<c:if test="${ename != null}"> <!-- /* 로그인이 되어있으면 userid+환영합니다 / 마이페이지 / 로그아웃 버튼을 띄운다 */ -->
					<span class="glyphicon glyphicon-heart-empty" style="color: white;" aria-hidden="true"></span>
					<span id="login_log" style="border-bottom: 1px solid white;">${ename} 님, 환영합니다.</span>
					<span class="glyphicon glyphicon-heart-empty" style="color: white;" aria-hidden="true"></span>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="location.href='/projects/myInfoCtrl'">마이페이지</button>
					<button onclick="location.href='/projects/logOut'">로그아웃</button>
				</c:if>
				
		</div>
	</div>
<nav id="nav1">
    <ul>
      <li><a href="/projects/rankList">회원 등급 관리</a></li>
      <li><a href="/projects/empList">사원 정보 관리</a></li>
      <li><a href="/projects/withdrawList">탈퇴 회원 관리</a></li>
      <li><a href="/projects/hotelList">업체 정보 관리</a></li>
      <li><a href="/projects/typeList">객실 정보 관리</a></li>
      <li><a href="/projects/reviewManagePage">댓글 신고 관리</a></li>
    </ul>
  </nav>
  
</body>
</html>