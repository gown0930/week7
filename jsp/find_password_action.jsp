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
   String nameValue = request.getParameter("name");
   String idValue = request.getParameter("id");

   // 커넥터 파링 찾는 부분
   Class.forName("com.mysql.jdbc.Driver");
   // 데이터베이스 연결
   Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week6", "haeju", "0930");
   // SQL 만들기
   String sql = "SELECT * FROM user WHERE name=? AND id=?";
   PreparedStatement query = connect.prepareStatement(sql);
   query.setString(1, nameValue);
   query.setString(2, idValue);

   // SQL 전송
   ResultSet result = query.executeQuery();

   // 데이터 정제
   String name = null;
   String id = null;
   String password = null;

   if (result.next()) {
       name = result.getString("name");
       id = result.getString("id");
       password = result.getString("password");
   }

   // 리다이렉션 조건 확인
   if (name == null || id == null) {
      session.setAttribute("errorMessage", "이름과 아이디를 모두 입력해주세요.");
      response.sendRedirect("find_password.jsp");
  } else {
      session.setAttribute("loginMessage", "비밀번호: " + password);
      response.sendRedirect("login.jsp");
  }
%>


<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>아이디 찾기</title>
</head>
<body>

</body>