<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Insert title here</title>

      <link rel="stylesheet" href="css/inquiry/watchInquiry.css" /> 
<script type="text/javascript">
$(document).ready(function(){
	$("#btnUpdate").click(function(){
		document.watch.action = "${path}/projects/updateInquiry";
		document.watch.submit();
		alert("문의 수정 완료");
	});
	$("#btnDelete").click(function(){
		document.watch.action = "${path}/projects/deleteInquiry";
		document.watch.submit();
		alert("문의 삭제 완료");
	});
});
</script>
</head>
<body>
  <%@ include file="../main/side.jsp" %>
	<form name="watch" method="POST" class="board-form">
	<label for="ino">문의번호</label>
    <input name="ino" value="${inquiryInfo.ino}" type="text" readonly="readonly">
    <label for="title">제목</label>
    <input name="title" value="${inquiryInfo.title}" type="text">
    <label for="id">작성자</label>
    <input name="id" value="${inquiryInfo.id}" readonly="readonly" type="text">
    <label for="idtype">구분</label>
    <input name="idtype" value="${inquiryInfo.idtype}" readonly="readonly" type="text">
    <label for="contents">문의내용</label>
    <textarea name="contents" rows="2" cols="10">${inquiryInfo.contents}</textarea>
    <label for="answer">관리자 답변</label>
    <textarea name="answer" rows="2" cols="10" readonly="readonly">${inquiryInfo.answer}</textarea>
    <input type="button" value="수정" id="btnUpdate">
    <input type="button" value="삭제" id="btnDelete">
    <input type="button" value="확인" onclick="location.href='/projects/requestInquiry'">
</form>
</body>
</html>