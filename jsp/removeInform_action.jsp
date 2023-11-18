<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%
   // jsp 영역

   request.setCharacterEncoding("utf-8");

   String idx = (String) session.getAttribute("idx");
   String passwordValue = request.getParameter("pw");

   // JDBC 드라이버 로드
   Class.forName("com.mysql.jdbc.Driver");

   // 데이터베이스 연결
   Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week6", "haeju", "0930");
   
   // 데이터베이스에서 비밀번호 가져오기
   String passwordFromDB = "";  

   String selectPasswordSql = "SELECT password FROM user WHERE idx = ?";
   PreparedStatement selectPasswordQuery = connect.prepareStatement(selectPasswordSql);
   selectPasswordQuery.setString(1, idx);
   ResultSet passwordResult = selectPasswordQuery.executeQuery();

   if (passwordResult.next()) {
       passwordFromDB = passwordResult.getString("password");
   }

   // 입력된 비밀번호와 데이터베이스에서 가져온 비밀번호 비교
   if (passwordValue.equals(passwordFromDB)) {
       // 삭제 SQL 문
       String deleteSql = "DELETE FROM user WHERE idx = ?";
       PreparedStatement deleteQuery = connect.prepareStatement(deleteSql);
       deleteQuery.setString(1, idx);

       // SQL 문 실행하여 레코드 삭제
       int rowsDeleted = deleteQuery.executeUpdate();

       if (rowsDeleted > 0) {
           out.println("데이터가 삭제되었습니다.");
           response.sendRedirect("login.jsp");
       } else {
           out.println("데이터를 삭제하지 못했습니다.");
       }
   } else {
       out.println("비밀번호가 일치하지 않습니다. 데이터를 삭제하지 못했습니다.");
   }

%>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Document</title>
</head>
<body>
</body>