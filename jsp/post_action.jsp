<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>

<%
request.setCharacterEncoding("utf-8");

String idx = (String) session.getAttribute("idx");
String title = request.getParameter("title");
String content = request.getParameter("content"); 

Connection connection = null;
PreparedStatement query = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    // 데이터베이스 연결
    connection = DriverManager.getConnection("jdbc:mysql://localhost/week6", "haeju", "0930");

    String sql = "INSERT INTO post (content, title, user_idx) VALUES (?, ?, ?)";
    query = connection.prepareStatement(sql);
    query.setString(1, content);
    query.setString(2, title);
    query.setString(3, idx);

    int rowsInserted = query.executeUpdate();

    if (rowsInserted > 0) {
        out.println("게시 성공");
        session.setAttribute("successMessage", "게시 성공");
        response.sendRedirect("post.jsp");
    } else {
        out.println("게시 실패");
    }
} catch (SQLException e) {
    out.println("게시 실패: " + e.getMessage());
} finally {
    try {
        if (query != null) {
            query.close();
        }
        if (connection != null) {
            connection.close();
        }
    } catch (SQLException e) {
        out.println("데이터베이스 연결 해제 중 오류 발생: " + e.getMessage());
    }
}
%>
