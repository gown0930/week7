<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%
String idx = (String) session.getAttribute("idx"); // 세션에서 idx 변수를 읽어옵니다
if (idx != null) {
    out.println("<script> var idx = '" + idx + "';</script>");
} else {
    out.println("<script>var idx = '';</script>");
}
%>
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
<%@ page import="java.util.List" %>
<%@ page session="true" %>

<%
   //jsp 영역

   //커넥터 파링 찾는 부분
   Class.forName("com.mysql.jdbc.Driver");
   //데이터베이스 연결
   Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week6", "haeju", "0930");
   //sql 만들기
   String sql = "SELECT * FROM user where idx=?";
   PreparedStatement query = connect.prepareStatement(sql);
   query.setString(1, idx);

   //Sql 전송
   ResultSet result = query.executeQuery();

   //데이터 정제
   String id = null;
   String pw = null;
   String name = null;
   String birth = null;
   String gender = null;
   String phone_num = null;

   if (result.next()) {
      id = result.getString("id"); 
      pw = result.getString("password");
      name = result.getString("name");
      birth = result.getString("birth");
      gender = result.getString("gender");
      phone_num = result.getString("phone_num");
   }
   session.setAttribute("idx", idx);
   session.setAttribute("id", id);
   session.setAttribute("pw", pw);
   session.setAttribute("name", name);
   session.setAttribute("birth", birth);
   session.setAttribute("gender", gender);
   session.setAttribute("phone_num", phone_num);



   String postSql = "SELECT * FROM post";
   PreparedStatement postQuery = connect.prepareStatement(postSql);
   ResultSet postResult = postQuery.executeQuery();
   
   List<List<String>> postarr = new ArrayList<>();
   ArrayList<String> idxList = new ArrayList<>();
      
   while (postResult.next()) {
       String post_idx = postResult.getString("idx");
       String title = postResult.getString("title");
       String content = postResult.getString("content");
       String created_at = postResult.getString("created_at");
       String user_idx = postResult.getString("user_idx");
   
       // 각 게시물의 정보를 리스트에 추가
       List<String> postInfo = new ArrayList<>();
       postInfo.add(post_idx);
       postInfo.add(title);
       postInfo.add(content);
       postInfo.add(created_at);
       postInfo.add(user_idx);


   
       // 이 게시물에 대한 댓글을 가져옵니다.
       String commentSql = "SELECT idx,comment FROM comment WHERE post_idx = ?";
       PreparedStatement commentQuery = connect.prepareStatement(commentSql);
       commentQuery.setString(1, post_idx);
       ResultSet commentResult = commentQuery.executeQuery();
         while (commentResult.next()) {
            String comment = commentResult.getString("comment");
            String comment_idx = commentResult.getString("idx");
            postInfo.add(comment);
            postInfo.add(comment_idx);
            idxList.add(comment_idx); // idxList에 comment_idx 추가
        }
   
       postarr.add(postInfo);
   }
   
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <link rel="stylesheet" type="text/css" href="../css/post.css">
</head>
<body>
    <div class="board">
        <h1>게시판</h1>
        <a href="myhome.jsp">
         <input type="button" value="내 정보 보기">
      </a>
        <div>
        </div>
        <form class="post-form" action="post_action.jsp">
            <h2>글 쓰기</h2>
            <div>
                <input type="text" id="title" name="title" placeholder="제목">
                <textarea id="content" placeholder="내용" name="content"></textarea>
                <input type="submit" value="게시" id="post">
            </div>
         </form>
         <div class="post-list">
            <h2>글 목록</h2>
            <form action="popup.jsp">
               <ul id="postList">
               </ul>
            </form>
        </div>
    </div>
    <script>
      console.log("번호: " + idx);
      console.log("id: <%= id %>");
      console.log("pw: <%= pw %>");
      console.log("name: <%= name %>");
      console.log("birth: <%= birth %>");
      console.log("gender: <%= gender %>");
      console.log("phone_num: <%= phone_num %>");
  
      if (typeof errorMessage !== 'undefined') {
          var errorDiv = document.getElementById("errorMessage");
          errorDiv.textContent = errorMessage;
      }
  
      var postList = [
          <%
          for (List<String> postInfo : postarr) {
          %>
              [
                  <%
                  for (String value : postInfo) {
                  %>
                      "<%= value %>",
                  <%
                  }
                  %>
              ],
          <%
          }
          %>
      ];
      var asdf = <%=idxList%>;
      console.log(postList);
      console.log(asdf);
  
      var ul = document.getElementById("postList");

      postList.forEach(function(postInfo) {
         var li = document.createElement("li");
         var form = document.createElement("form");
         var editButton = document.createElement("button");
         var deleteButton = document.createElement("button");
         var commentForm = document.createElement("form"); // 댓글 폼 추가
         var commentInput = document.createElement("textarea");
         commentInput.name = "commentContent"; // 댓글 내용 입력 필드
         var commentSubmitButton = document.createElement("button");

         editButton.textContent = "수정";
         deleteButton.textContent = "삭제";
         commentSubmitButton.textContent = "댓글 작성";

         editButton.addEventListener("click", function() {
            form.action = "popup.jsp";
            form.submit();
         });

         deleteButton.addEventListener("click", function() {
            form.action = "deletePost.jsp";
            form.submit();
         });

         commentForm.style.display = "block"; // 댓글 폼을 기본적으로 표시

         commentSubmitButton.addEventListener("click", function() {
            // user_idx 가져오기
            var user_idx = postInfo[0]; // 예: postInfo 배열에서 가져오거나 다른 방법 사용
            // postInfo[4] 가져오기
            var additionalValue = postInfo[4];

            // user_idx를 숨겨진 필드로 commentForm에 추가
            var userIndexInput = document.createElement("input");
            userIndexInput.type = "hidden";
            userIndexInput.name = "user_idx";
            userIndexInput.value = user_idx;
            commentForm.appendChild(userIndexInput);

            // postInfo[4]를 숨겨진 필드로 commentForm에 추가
            var additionalInput = document.createElement("input");
            additionalInput.type = "hidden";
            additionalInput.name = "additionalValue"; // 필드 이름을 원하는 이름으로 수정
            additionalInput.value = additionalValue;
            commentForm.appendChild(additionalInput);

            // commentForm를 comment_action.jsp로 제출
            commentForm.action = "comment_action.jsp";
            commentForm.submit();
         });

         form.method = "post";
         commentForm.method = "post";

         var postInfoWithoutFirstAndLast = postInfo.slice(1, 4);

         postInfoWithoutFirstAndLast.forEach(function(value, index) {
            var element = document.createElement(index === 0 ? "h3" : "h5");
            element.textContent = value;
            li.appendChild(element);
         });

         if (postInfo.length > 5) {
    var postInfoWithoutFirstAndLast = postInfo.slice(5, postInfo.length);
    postInfoWithoutFirstAndLast.forEach(function (comment, index) {
        if (index % 2 == 0) {
            var commentElement = document.createElement("h6");
            commentElement.textContent = comment;
            form.appendChild(commentElement);

            var commentInput = document.createElement("input");
            commentInput.type = "hidden";
            commentInput.name = "comment";
            commentInput.value = comment;
            form.appendChild(commentInput);

            var previousComment = postInfoWithoutFirstAndLast[index - 1];

            console.log(previousComment);

            var commentForm = document.createElement("form");
           
            var editButton = document.createElement("button");
            editButton.textContent = "수정";
            editButton.className = "edit-button";

            var deleteButton = document.createElement("button");
            deleteButton.textContent = "삭제";
            deleteButton.className = "edit-button";

            editButton.addEventListener("click", function () {
                commentForm.action = "editComment.jsp";
                commentForm.submit();
            });

            deleteButton.addEventListener("click", function () {
                commentForm.action = "deleteComment.jsp";
                commentForm.submit();
            });

            commentSubmitButton.addEventListener("click", function () {
                var user_idx = postInfo[0];
                var commentContent = commentInput.value;

                var userIndexInput = document.createElement("input");
                userIndexInput.type = "hidden";
                userIndexInput.name = "user_idx";
                userIndexInput.value = user_idx;
                commentForm.appendChild(userIndexInput);

                var commentContentInput = document.createElement("input");
                commentContentInput.type = "hidden";
                commentContentInput.name = "commentContent";
                commentContentInput.value = comment;
                commentForm.appendChild(commentContentInput);

                commentForm.setAttribute("data-type", "comment");

                commentForm.action = "comment_action.jsp";
                commentForm.submit();
                commentInput.value = "";
            });

            commentForm.method = "post";

            commentForm.appendChild(commentInput);
            commentForm.appendChild(commentSubmitButton);
            commentForm.appendChild(editButton);
            commentForm.appendChild(deleteButton);

            li.appendChild(commentElement);
            li.appendChild(commentForm);
        }
    });
}
   
      
         var titleInput = document.createElement("input");
         titleInput.type = "hidden";
         titleInput.name = "title";
         titleInput.value = postInfo[1];
         form.appendChild(titleInput);

         var contentInput = document.createElement("input");
         contentInput.type = "hidden";
         contentInput.name = "content";
         contentInput.value = postInfo[2];
         form.appendChild(contentInput);

         // user_idx를 가져오고 숨겨진 필드로 추가
         var userIndexInput = document.createElement("input");
         userIndexInput.type = "hidden";
         userIndexInput.name = "user_idx";
         userIndexInput.value = postInfo[0];
         form.appendChild(userIndexInput);

         commentInput.rows = 4; // 여러 줄의 입력 필드로 설정
         commentInput.name = "commentContent"; // 댓글 내용 입력 필드 설정
         commentInput.placeholder = "댓글을 입력하세요"; // 댓글 입력 필드에 플레이스홀더 추가
         commentForm.appendChild(commentInput);

         if (editButton && deleteButton) {
            form.appendChild(editButton);
            form.appendChild(deleteButton);
         }
         
         commentForm.appendChild(commentSubmitButton);

         li.appendChild(form);
         li.appendChild(commentForm);

         ul.appendChild(li);
      });

  </script>


</body>

