<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%
   //jsp 영역

   request.setCharacterEncoding("utf-8");

   String comment = (String) session.getAttribute("comment");
   String content = request.getParameter("content");

   //커넥터 파링 찾는 부분
   Class.forName("com.mysql.jdbc.Driver");

   //데이터베이스 연결
   Connection connect= DriverManager.getConnection("jdbc:mysql://localhost/week6","haeju","0930");
   
   // 가져온 데이터를 사용하여 UPDATE 문 작성
   String updateSql = "UPDATE comment SET comment=? WHERE comment=?";
   PreparedStatement updateQuery = connect.prepareStatement(updateSql);
   
   updateQuery.setString(1, content); // title을 첫 번째 파라미터로 설정
   updateQuery.setString(2, comment); // content를 두 번째 파라미터로 설정
   
   // UPDATE 문 실행
   int rowsUpdated = updateQuery.executeUpdate();
   
   if (rowsUpdated > 0) {
      response.sendRedirect("post.jsp");
      session.setAttribute("updateMessage", "데이터가 업데이트되었습니다.");
   } else {
      response.sendRedirect("editComment.jsp");
       out.println("데이터를 업데이트하지 못했습니다.");
   }
%>

<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Document</title>
</head>
<body>
   <script>

  </script>
</body>
