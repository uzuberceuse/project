<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HEADER</title>

    <link rel="stylesheet" href="css/main/header.css" /> 
</head>
<body>
    <div class="navbar">
        <div class="nav-left">
            <a href="/projects/homePage">
                <img src="images/mainicon/home.png">&nbsp;홈으로</a>
            <a href="/projects/searchHotelPage">
                <img src="images/mainicon/hotel.png">&nbsp;호텔</a>
        </div>
        <div class="nav-right">
            <c:choose>
                <c:when test="${not empty sessionScope.id}">
                    <a href="/projects/myPage">
                        <img src="images/mainicon/my.png">&nbsp;마이페이지</a>
                    <a href="<c:url value='/logOut' />" class="logout-link">
                        <img src="images/mainicon/logout.png">&nbsp;로그아웃</a>
                </c:when>
                <c:otherwise>
                    <a href="/projects/logIn">로그인</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
