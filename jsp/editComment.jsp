<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%
request.setCharacterEncoding("UTF-8");
//String asdf= request.getParameter("comment2");
String commentContent = request.getParameter("comment");
session.setAttribute("comment", commentContent);
%>

<head>
    <meta charset="UTF-8">
    <title>댓글 수정</title>
</head>
<body>
    <h1>댓글 수정</h1>

    <form method="post" action="editComment_action.jsp">
        <label for="content">내용:</label>
        <textarea id="content" name="content"><%= commentContent %></textarea>

        <input type="submit" value="수정">
    </form>
    <script>
  </script>
</body>
