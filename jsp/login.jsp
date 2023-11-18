<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%
String successMessage = (String) session.getAttribute("successMessage");
if (successMessage != null) {
    out.println("<script>var successMessage = '" + successMessage + "';</script>");
    session.removeAttribute("successMessage"); 
 } else {
    out.println("<script>var successMessage = '';</script>");
 }

 String errorMessage = (String) session.getAttribute("errorMessage");
 String loginMessage = (String) session.getAttribute("loginMessage");
 
 if (loginMessage != null) {
    out.println("<script>var loginMessage = '" + loginMessage + "';</script>");
    session.removeAttribute("loginMessage");
 } else {
    out.println("<script>var loginMessage = '';</script>"); // errorMessage가 null일 경우 빈 문자열로 초기화
 }
 
 if (errorMessage != null) {
    out.println("<script>var errorMessage = '" + errorMessage + "';</script>");
    session.removeAttribute("errorMessage"); 
 } else {
    out.println("<script>var errorMessage = '';</script>"); // errorMessage가 null일 경우 빈 문자열로 초기화
 }
%> 
   <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>로그인</title>
        <link rel="stylesheet" type="text/css" href="../css/login.css">
    </head>
    <body>
        <div id="loginbox">
            <div id="successMessage"></div>
            <img src="../image/행복페페.png" id="logo" class="out">
            <div id="title">로그인</div>
            <form action="login_action.jsp">
                <input type="text" class="login" id="id" name="id" placeholder="아이디">
                <input type="password" class="login" id="password" name="password" placeholder="비밀번호">
                <input type="submit" value="로그인" id="login" class="out">
            </form>
            <div id="errorMessage"></div>
            <div id="bottombox">
                <a href="signup.jsp" class="bottom">회원가입</a>
                <a href="find_id.jsp" class="bottom">아이디 찾기</a>
                <a href="find_password.jsp" class="bottom">비밀번호 찾기</a>
            </div>
        </div>
        <script>
            if (typeof successMessage !== 'undefined'&& successMessage !== '') {
                //  var  successDiv = document.getElementById("successMessage");
                //  successDiv.textContent = successMessage;
                 alert("회원가입 성공")
            }
            if (loginMessage !== '') {
                //  var  successDiv = document.getElementById("successMessage");
                //  successDiv.textContent = successMessage;
                 alert(loginMessage);
            }
            if (typeof errorMessage !== 'undefined') {
                var  errorDiv = document.getElementById("errorMessage");
                errorDiv.textContent = errorMessage;
            }
        </script>
    </body>



