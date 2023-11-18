<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page session="true" %>
<%
String idx = (String) session.getAttribute("idx");
String id = (String) session.getAttribute("id");
String pw = (String) session.getAttribute("pw");
String name = (String) session.getAttribute("name");
String birth = (String) session.getAttribute("birth");
String gender = (String) session.getAttribute("gender");
String phone_num = (String) session.getAttribute("phone_num");

session.setAttribute("idx", idx);
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/myhome.css">
    <title>내 정보 보기</title>
</head>
<body>
    <div>
        <div id="title">내 정보</div>
        <div id="myinform"></div>
        <a href="editInform.jsp">
         <input type="button" value="내 정보 수정">
      </a>
      <a href="removeInform.jsp">
        <input type="button" value="회원 탈퇴">
     </a>
    </div>

    <script>
      var idx = "<%= idx %>";
      var id = "<%= id %>";
      var pw = "<%= pw %>";
      var name = "<%= name %>";
      var birth = "<%= birth %>";
      var gender = "<%= gender %>";
      var phone_num = "<%= phone_num %>";
      
     console.log("idx: " + idx);
      console.log("id: " + id);
      console.log("pw: " + pw);
      console.log("name: " + name);
      console.log("birth: " + birth);
      console.log("gender: " + gender);
      console.log("phone_num: " + phone_num);

      var  Div = document.getElementById("myinform");
      Div.textContent = id +","+pw +","+ name+","+birth+","+gender+","+phone_num;

      var updateMessage = "<%= session.getAttribute("updateMessage") %>";
    
    if (updateMessage) {
        alert(updateMessage); // 브라우저 알림으로 메시지 표시
    }
  </script>
  
</body>