<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%
request.setCharacterEncoding("UTF-8");
String title = null;
String content = null;

title = request.getParameter("title");
content = request.getParameter("content");
String user_idx = request.getParameter("user_idx");


// idx 값을 세션에 저장
session.setAttribute("user_idx", user_idx);
%>

<head>
    <meta charset="UTF-8">
    <title>게시물 수정</title>
</head>
<body>
    <h1>게시물 수정</h1>

    <form method="post" action="editPost_action.jsp">
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" value="<%= title %>">
        <label for="content">내용:</label>
        <textarea id="content" name="content"><%= content %></textarea>

        <input type="submit" value="수정">
    </form>
    <script>
      var idx='<%= user_idx %>';
      console.log("잘봐" + idx);
      var title='<%= title %>';
      console.log("잘봐" + title);
      var content='<%= content %>';
      console.log("잘봐" + content);
  </script>
</body>

