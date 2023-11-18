<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%

request.setCharacterEncoding("UTF-8");
// 변수 선언
Connection connection = null;
PreparedStatement preparedStatement = null;
String comment = null;
String post_idx=null;
String user_idx=null;

post_idx = request.getParameter("user_idx");
comment = request.getParameter("commentContent");
user_idx = request.getParameter("additionalValue");

ArrayList<String> commentList = new ArrayList<String>(); // commentList 변수 선언 및 초기화

// 데이터베이스 연결
Class.forName("com.mysql.jdbc.Driver");
connection = DriverManager.getConnection("jdbc:mysql://localhost/week6", "haeju", "0930");

// SQL 쿼리 작성
String sql = "INSERT INTO comment (comment, post_idx, user_idx) VALUES (?, ?, ?)";
preparedStatement = connection.prepareStatement(sql);

// 파라미터 설정
preparedStatement.setString(1, comment);
preparedStatement.setString(2, post_idx);
preparedStatement.setString(3, user_idx);

// SQL 쿼리 실행
int rowsUpdated = preparedStatement.executeUpdate();

if (rowsUpdated > 0) {
    // 댓글이 성공적으로 추가된 경우
    response.sendRedirect("post.jsp");
    out.println("댓글이 성공적으로 추가되었습니다.");

    // 댓글 목록을 가져와서 commentList에 추가
    String selectCommentSql = "SELECT comment FROM comment WHERE post_idx = ?";
    preparedStatement = connection.prepareStatement(selectCommentSql);
    preparedStatement.setString(1, post_idx);
    ResultSet commentsResult = preparedStatement.executeQuery();

    while (commentsResult.next()){
        String commentText = commentsResult.getString("comment");
        commentList.add("\""+commentText+"\"");
    } 

    request.setAttribute("commentList", commentList);
} else {
    // 댓글 추가에 실패한 경우
    out.println("댓글 추가에 실패했습니다.");
}

%>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>
<script>
var idx='<%= user_idx %>';
console.log("잘봐" + idx);
var idx1='<%= post_idx %>';
console.log("잘봐" + idx1);
var content='<%= comment %>';
console.log("잘봐" + content);

var commentList = <%=commentList%>
console.log(commentList)
</script>
</body>
