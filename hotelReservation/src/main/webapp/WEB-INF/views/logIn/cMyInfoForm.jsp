<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	   <link rel="stylesheet" href="css/logIn/cMyInfoForm.css" /> 
    <meta charset="UTF-8">
    <title>나의 정보</title>
    <script type="text/javascript">
		$(document).ready(function(){
			$("#btnUpdate").click(function(){
				document.form1.action = "${path}/projects/updateCmyInfoCtrl";
				document.form1.submit();
				alert("회원정보 수정 완료");
			});
		});
	</script>

</head>
<body>
  <%@ include file="../main/side.jsp" %>
	<form name="form1" method="POST">
    <table class="info-table">
        <thead>
            <tr>
                <th colspan="2"><h1>나의 정보</h1></th>
            </tr>
        </thead>
        <tbody>
        	<tr>
                <td>아이디</td>
				<td><input name="cid" value="${cMyInfo.cid}" readonly="readonly"></td>
            </tr>
            <tr>
                <td>이름</td>
				<td><input name="cname" value="${cMyInfo.cname}" readonly="readonly"></td>
            </tr>
            <tr>
                <td>영문 이름</td>
				<td><input name="firstname" value="${cMyInfo.firstname}" readonly="readonly"></td>
            </tr>
            <tr>
                <td>영문 성</td>
				<td><input name="lastname" value="${cMyInfo.lastname}" readonly="readonly"></td>
            </tr>
            <tr>
                <td class="required">이메일 <span style="color: red;">*</span></td>
            	<td><input name="cmail" id="cmail" value="${cMyInfo.cmail}"></td>
            </tr>
            <tr>
                <td class="required">전화번호 <span style="color: red;">*</span></td>
			<td><input name="cphone" id="cphone" value="${cMyInfo.cphone}"></td>
            </tr>
        </tbody>
    </table>
    <div class="button">
    			<input type="button" value="수정" id="btnUpdate">
				<input type="button" value="확인" onclick="location.href='/projects/success'">
				<input type="button" value="회원 탈퇴" onclick="location.href='/projects/customerWithdraw'">
	</div>
	</form>
</body>
</html>
