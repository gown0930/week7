<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Document</title>
</head>
<body>
   <form action="signup.jsp">
      <input name="id_value" type="text">
      <input name="pw_value" type="text">
      <input type="submit" value="회원가입">
   </form>
   <form action="accountList.jsp">
      <input type="submit" value="계정 목록 출력">
   </form>
   <a href="jsp/login.jsp">
      <input type="button" value="로그인">
  </a>
  <a href="jsp/myInform.jsp">
   <input type="button" value="내 정보 보기">
</a>
</body>
