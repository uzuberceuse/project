<%@ page language="java" contentType="text/html; charset=UTF-8"
    isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>객실 등록</title>
     <link rel="stylesheet" href="css/goods/gDetailsRegister.css" /> 
</head>
<body>
 	<%@ include file="../main/header.jsp" %>
    <div class="form-container">
        <h2>객실 등록</h2>
        <form action="/projects/gDetailsRegister" method="post">
            <fieldset>
                <legend>객실정보</legend>
                <div class="form-grid">
                    <div class="full-width">
                        <label for="exp">소개:</label>
                        <textarea cols="50" rows="10" placeholder='객실 정보를 입력하세요.'
                        id="exp" name="exp" required></textarea>
                    </div>
                    <div>
                        <label for="bedtype">침대종류:</label>
                        <select id="bedtype" name="bedtype" required>
                            <option value="">선택하세요</option>
                            <option value="King_Twin">King_Twin</option>
                            <option value="King">King</option>
                            <option value="Queen">Queen</option>
                            <option value="Double">Double</option>
                            <option value="Single">Single</option>
                        </select>
                    </div>
                    <div>
                        <label for="bedno">침대수:</label>
                        <select id="bedno" name="bedno" required>
                            <option value="">선택하세요</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                    </div>
                    <div>
                        <label for="tview">전망:</label>
                       	<select id="tview" name="tview" required>
                            <option value="">선택하세요</option>
                            <option value="Cty">city</option>
                            <option value="Street">street</option>
                            <option value="Garden">garden</option>
                            <option value="Ocean">ocean</option>
                            <option value="River">river</option>                           
                            <option value="Mountain">mountain</option>
                            <option value="Park">park</option>
                        </select>
                    </div>
                    <div>
                        <label for="smoke">흡연여부:</label>
                        <input type="radio" id="smoke" name="smoke" value="Y">Y
                        <input type="radio" id="smoke" name="smoke" value="N" checked>N
                    </div>
                    <div>
                        <label for="tsize">객실크기:</label>
                        <input type="text" id="tsize" name="tsize" required>
                    </div>
                    <div>
                        <label for="bathtype">욕실종류:</label>
                        <select id="bathtype" name="bathtype" required>
                            <option value="">선택하세요</option>
                            <option value="Shower">Shower</option>
                            <option value="Shower_Bathtub">Shower &amp; Bathtub</option>
                            <option value="Bathtub">Bathtub</option>
                        </select>
                    </div>
                    <div>
                        <label for="breakfast">조식여부:</label>
                        <input type="radio" id="breakfast" name="breakfast" value="Y">Y
                        <input type="radio" id="breakfast" name="breakfast" value="N" checked>N
                    </div>
                </div>
            </fieldset>
            
            <div class="form-buttons">
                <input type="button" value="취소" onclick="history.back();">
                <input type="submit" value="등록">
            </div>
        </form>
    </div>
</body>
</html>
