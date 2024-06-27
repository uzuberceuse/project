<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Insert title here</title>

    <link rel="stylesheet" href="css/logIn/logInForm.css" /> 
 
</head>
<body>
 	 <%@ include file="../main/header.jsp" %>
	<div class="payLogIn-wrapper">
    <div class="payLogIn-html">
        <input id="tab-1" type="radio" name="tab" class="customer" checked>
        <label for="tab-1" class="tab">고객</label>
 
        <div class="payLogIn-form">
            <div class="cLogIn-htm">
            
                <form method="POST" action="/projects/payLogIn" id="payLogIn-form">
                	<c:choose>
                   		<c:when test="${result eq 'no_id'}">
     				   	<script type="text/javascript">
						alert('존재하지 않는 아이디입니다.');
						</script>
       					 </c:when>
       					 
       					      		<c:when test="${result eq 'wrong_pw'}">
     				   	<script type="text/javascript">
						alert('비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
						</script>
       					 </c:when>
       					 
        			</c:choose>
                    <div class="group">
                        <label for="user" class="label">아이디</label>
                        <input type="text" name="cid" class="input">
                    </div>
                    <div class="group">
                        <label for="pass" class="label">비밀번호</label>
                        <input type="password" name="cpw" class="input">
                    </div>
                    <div class="group">
                        <input type="submit" class="button" value="로그인">
                    </div>
                    <div class="hr"></div>
                    <div class="foot-lnk">
                        <a href="/projects/cSignUp">회원가입</a>
                    </div>
                </form>
            </div>
          
        </div>
    </div>
</div>
</body>
</html>

