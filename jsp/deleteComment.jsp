<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%
request.setCharacterEncoding("UTF-8");
String commentContent = request.getParameter("comment");


Class.forName("com.mysql.jdbc.Driver");

   // 데이터베이스 연결
   Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week6", "haeju", "0930");
 
   String deleteSql = "DELETE FROM comment WHERE comment = ?";
   PreparedStatement deleteQuery = connect.prepareStatement(deleteSql);
   deleteQuery.setString(1, commentContent); 
   int rowsDeleted = deleteQuery.executeUpdate();

       if (rowsDeleted > 0) {
           out.println("데이터가 삭제되었습니다.");
           response.sendRedirect("post.jsp");
       } else {
           out.println("데이터를 삭제하지 못했습니다.");
       }
   %>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Document</title>
</head>
<body>
   
</body>
