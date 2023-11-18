<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%
   //jsp 영역

   request.setCharacterEncoding("utf-8");

   String idx = (String) session.getAttribute("user_idx");
   String title = request.getParameter("title");
   String content = request.getParameter("content");

   //커넥터 파링 찾는 부분
   Class.forName("com.mysql.jdbc.Driver");

   //데이터베이스 연결
   Connection connect= DriverManager.getConnection("jdbc:mysql://localhost/week6","haeju","0930");
   
   // 가져온 데이터를 사용하여 UPDATE 문 작성
   String updateSql = "UPDATE post SET title=?, content=? WHERE idx=?";
   PreparedStatement updateQuery = connect.prepareStatement(updateSql);
   
   updateQuery.setString(1, title); // title을 첫 번째 파라미터로 설정
   updateQuery.setString(2, content); // content를 두 번째 파라미터로 설정
   updateQuery.setString(3, idx);
   
   // UPDATE 문 실행
   int rowsUpdated = updateQuery.executeUpdate();
   
   if (rowsUpdated > 0) {
      response.sendRedirect("post.jsp");
      session.setAttribute("updateMessage", "데이터가 업데이트되었습니다.");
   } else {
      response.sendRedirect("popup.jsp");
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
      var idx='<%= idx %>';
      console.log("잘봐" + idx);
      var title='<%= title %>';
      console.log("잘봐" + title);
      var content='<%= content %>';
      console.log("잘봐" + content);
  </script>
</body>
