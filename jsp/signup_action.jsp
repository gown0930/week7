<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
//데이터베이스 탐색 라이브러리
<%@ page import="java.sql.DriverManager"%>
//데이터베이스 연결 라이브러리
<%@ page import="java.sql.Connection"%>
//SQL 전송 라이브러리
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet" %>
<%
   //jsp 영역

   request.setCharacterEncoding("utf-8");

   String id = request.getParameter("id");
   String password = request.getParameter("password");
   String name = request.getParameter("name");
   String phone_num = request.getParameter("phone_num");

   //데이터베이스 연결 코드

   //커넥터 파링 찾는 부분
   Class.forName("com.mysql.jdbc.Driver");

   //데이터베이스 연결
   Connection connect= DriverManager.getConnection("jdbc:mysql://localhost/week6","haeju","0930");


   //sql 만들기

   String action = request.getParameter("checkDuplicate");
   if (action != null) {
       // 중복 확인 SQL을 정의
       String checkDuplicateSQL = "SELECT COUNT(*) FROM user WHERE id = ?";
       
       // 중복 확인을 수행
       PreparedStatement checkDuplicateQuery = connect.prepareStatement(checkDuplicateSQL);
       checkDuplicateQuery.setString(1, id);
       ResultSet result = checkDuplicateQuery.executeQuery();
       
       if (result.next()) {
         int count = result.getInt(1);
         if (id.length() <= 5) {
             session.setAttribute("duplicateMessage", "아이디는 6자 이상이어야 합니다.");
         } else if (count > 0) {
             session.setAttribute("duplicateMessage", "이미 사용 중인 아이디입니다.");
         } else {
             session.setAttribute("duplicateMessage", "사용 가능한 아이디입니다.");
         }
     }
   }

   String signupAction = request.getParameter("signup");
   int login=0;
   if (signupAction != null) {
       if (id.trim().isEmpty() || password.trim().isEmpty() || name.trim().isEmpty() || phone_num.trim().isEmpty()) {
           session.setAttribute("errorMessage", "필수 항목을 모두 채워주세요.");
           response.sendRedirect("signup.jsp");
       } else if (id.length() <= 5) {
           session.setAttribute("errorMessage", "아이디는 6자 이상이어야 합니다.");
           response.sendRedirect("signup.jsp");
       } else {
           // 데이터를 삽입
           String sql = "INSERT INTO user(id, password, name, phone_num) VALUES (?, ?, ?, ?)";
           PreparedStatement query = connect.prepareStatement(sql);
           query.setString(1, id);
           query.setString(2, password);
           query.setString(3, name);
           query.setString(4, phone_num);
           query.executeUpdate();
           out.println("회원가입 성공");
           session.setAttribute("successMessage", "회원가입 성공");
           //login=1;
           response.sendRedirect("login.jsp");
       }
   }
%>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Document</title>
</head>
<body>
</body>