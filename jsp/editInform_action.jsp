<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%
   //jsp 영역

   request.setCharacterEncoding("utf-8");

   String idx = (String) session.getAttribute("idx");

   String idValue = request.getParameter("id");
   String passwordValue = request.getParameter("pw");
   String nameValue = request.getParameter("name");
   String birthValue = request.getParameter("birth");
   String genderValue = request.getParameter("gender");
   String phone_numValue = request.getParameter("phone_num");
   


   //커넥터 파링 찾는 부분
   Class.forName("com.mysql.jdbc.Driver");

   //데이터베이스 연결
   Connection connect= DriverManager.getConnection("jdbc:mysql://localhost/week6","haeju","0930");
   
   // 가져온 데이터를 사용하여 UPDATE 문 작성
   String updateSql = "UPDATE user SET id=?, password=?, name=?, birth=?, gender=?, phone_num=? WHERE idx=?";
   PreparedStatement updateQuery = connect.prepareStatement(updateSql);
   
   updateQuery.setString(1, idValue);
   updateQuery.setString(2, passwordValue);
   updateQuery.setString(3, nameValue);
   updateQuery.setString(4, birthValue);
   updateQuery.setString(5, genderValue);
   updateQuery.setString(6, phone_numValue);
   updateQuery.setString(7, idx);

   session.setAttribute("idx", idx);
   session.setAttribute("id", idValue);
   session.setAttribute("pw", passwordValue);
   session.setAttribute("name", nameValue);
   session.setAttribute("birth", birthValue);
   session.setAttribute("gender", genderValue);
   session.setAttribute("phone_num", phone_numValue);
   
   // UPDATE 문 실행
   int rowsUpdated = updateQuery.executeUpdate();
   
   if (rowsUpdated > 0) {
      session.setAttribute("updateMessage", "데이터가 업데이트되었습니다.");
       response.sendRedirect("myhome.jsp");
   } else {
       out.println("데이터를 업데이트하지 못했습니다.");
       out.println(idx);
       response.sendRedirect("editInform.jsp");
   }
%>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Document</title>
</head>
<body>
</body>ㅈ