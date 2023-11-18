<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<!-- 데이터베이스 탐색 라이브러리 -->
<%@ page import="java.sql.DriverManager"%>
<!-- 데이터베이스 연결 라이브러리 -->
<%@ page import="java.sql.Connection"%>
<!-- SQL 전송 라이브러리 -->
<%@ page import="java.sql.PreparedStatement"%>
<!-- 데어터 받아오기 라이브러리 -->
<%@ page import="java.sql.ResultSet"%>
<!-- 리스트 라이브러리 -->
<%@ page import="java.util.ArrayList"%>
<%
   // JSP 영역
   request.setCharacterEncoding("utf-8");
   String idValue = request.getParameter("id");
   String pwValue = request.getParameter("password");

   // 커넥터 파링 찾는 부분
   Class.forName("com.mysql.jdbc.Driver");
   // 데이터베이스 연결
   Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week6", "haeju", "0930");
   // SQL 만들기
   String sql = "SELECT * FROM user WHERE id=?";
   PreparedStatement query = connect.prepareStatement(sql);
   query.setString(1, idValue);

   // SQL 전송
   ResultSet result = query.executeQuery();

   // 데이터 정제
   String id = null;
   String pw = null;
   String idx = null;

   if (result.next()) {
       idx = result.getString("idx");
       id = result.getString("id"); 
       pw = result.getString("password"); 
   }
   if(id==null){
      session.setAttribute("errorMessage", "아이디가 존재하지 않습니다.");
      response.sendRedirect("login.jsp");
   }
   else{
      if (pwValue.equals(pw)) {
         session.setAttribute("loginMessage", "로그인 성공");
         session.setAttribute("idx", idx);
         response.sendRedirect("post.jsp");
     }
      else{
         session.setAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
         response.sendRedirect("login.jsp");
      }
   }
%>

<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>로그인</title>
</head>
<body>
   <script>
      var id = '<%= id %>';
      var pw = '<%= pw %>';
      var pw2 = '<%= idx %>';
      console.log(id);
      console.log(pw);
      console.log(pw2);
      var id1 = '<%= idValue %>';
      var pw1 = '<%= pwValue %>';
      console.log(id1);
      console.log(pw1);
   </script>
</body>