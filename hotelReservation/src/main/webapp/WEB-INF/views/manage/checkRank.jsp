<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <link rel="stylesheet" href="css/manage/checkRank.css" /> 
</head>
<body>
<%@ include file="../manage/adminMain.jsp" %>
	<table>
		<thead>
		<tr>
			<th>id</th>
			<th>이름</th>
			<th>예약건수</th>
			<th>등급</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="cList" items="${countList}">
			<tr>
				<td>${cList.cid}</td>
				<td>${cList.cname}</td>
				<td>${cList.cnt}</td>
				<td>${cList.rname}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<input type="button" value="업데이트" onclick="location.href='/projects/updateRank'">
	<input type="button" value="확인" onclick="location.href='/projects/admin'">
</body>
</html>