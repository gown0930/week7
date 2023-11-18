<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%
String idx = (String) session.getAttribute("idx");
String id = (String) session.getAttribute("id");
String pw = (String) session.getAttribute("pw");
String name = (String) session.getAttribute("name");
String birth = (String) session.getAttribute("birth");
String gender = (String) session.getAttribute("gender");
String phone_num = (String) session.getAttribute("phone_num");

session.setAttribute("idx", idx);
%>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" type="text/css" href="../css/editInform.css">
   <title>내 정보 수정</title>
</head>
<body>
   <div id="title">내 정보 수정</div>
   <form action="editInform_action.jsp">
      <label for="id">ID:</label>
      <input type="text" name="id" id="id" class="signup" value="<%= id %>">

      <label for="pw">비밀번호:</label>
      <input type="text" name="pw" id="pw" class="signup" value="<%= pw %>">

      <label for="name">이름:</label>
      <input type="text" name="name" id="name" class="signup" value="<%= name %>">

      <label for="birth">생년월일:</label>
      <input type="text" name="birth" id="birth" class="signup" value="<%= birth %>">

      <label for="gender">성별:</label>
      <input type="text" name="gender" id="gender" class="signup" value="<%= gender %>">

      <label for="phone_num">전화번호:</label>
      <input type="text" name="phone_num" id="phone_num" class="signup" value="<%= phone_num %>">
      <input type="submit" id="answar" name="edit" value="수정">
   </form>
</body>