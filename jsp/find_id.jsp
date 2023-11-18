<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%

 String errorMessage = (String) session.getAttribute("errorMessage");

 
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
   <title>아이디 찾기</title>
   <link rel="stylesheet" type="text/css" href="../css/find_id.css">
</head>
<body>
   <div id="searchBox">
      <div id="title">id 찾기</div>
      <form action="find_id_action.jsp">
         <input type="text" class="signup" name="name" placeholder="이름">
         <input type="text" class="signup" name="phone_num" placeholder="전화번호">
         <div id="errorMessage"></div>
         <button id="answar">확인</button>
      </form>
   </div>
           <script>
            if (typeof errorMessage !== 'undefined') {
                var  errorDiv = document.getElementById("errorMessage");
                errorDiv.textContent = errorMessage;
            }
        </script>
</body>
