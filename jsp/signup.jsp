<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>  
<%
String errorMessage = (String) session.getAttribute("errorMessage");
String duplicateMessage = (String) session.getAttribute("duplicateMessage");

if (errorMessage != null) {
   out.println("<script>var errorMessage = '" + errorMessage + "';</script>");
   session.removeAttribute("errorMessage"); // 필요하면 메시지 삭제
} else {
   out.println("<script>var errorMessage = '';</script>"); // errorMessage가 null일 경우 빈 문자열로 초기화
}

if (duplicateMessage != null) {
   out.println("<script>var duplicateMessage = '" + duplicateMessage + "';</script>");
   session.removeAttribute("duplicateMessage"); // 필요하면 메시지 삭제
} else {
   out.println("<script>var duplicateMessage = '';</script>"); // duplicateMessage가 null일 경우 빈 문자열로 초기화
}
%>
   <head>
      <meta charset="UTF-8"> 
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>회원가입</title>
      <link rel="stylesheet" type="text/css" href="../css/signup.css">
   </head>
   <body>
      <div id="imformBox">
         <form action="signup_action.jsp">
            <img src="../image/행복페페.png" id="logo" class="out">
            <div id="title">회원가입</div>
            <input type="text" name="id" class="signup" placeholder="아이디 (필수) ">
            <input type="submit" id="idCheck" name="checkDuplicate" value="중복확인">
            <div id="duplicateMessage" class="message"></div>
            <input type="password" name="password" class="signup" id="password" placeholder="비밀번호 (필수)" onblur="validatePassword()">
            <input type="password" class="signup" id="confirmPassword" placeholder="비밀번호 확인">
            <p id="passwordMatchMessage" class="message"></p>
            <span id="passwordErrorMessage" class="message"></span>

            <input type="text" name="name" class="signup" placeholder="이름 (필수)">

            <input type="text" name="phone_num" id="phone" class="signup" placeholder="전화번호 (필수)">
            <div class="selectBox">
               <div for="profileImage">생년월일</div>
               <select id="year" name="year">
               </select>년
               <select id="month" name="month">
               </select>월
               <select id="day" name="day">
               </select>일
            </div>
            <div class="selectBox">
               <div for="profileImage">성별</div>
               <input type="radio" id="male" name="gender" value="male">
               <label for="male">남자</label>
               <input type="radio" id="female" name="gender" value="female">
               <label for="female">여자</label>
            </div>
            <div>
               <div for="profileImage">프로필 이미지</div>
               <input type="file" id="imageInput" accept="image/*" onchange="previewImage(event)">
               <div id="imagePreview">
                  <img id="preview" src="#" alt="이미지 미리보기">
               </div>
            </div>
            <div id="errorMessage" class="message"></div>
            <input type="submit" id="answar" name="signup" value="회원가입">

         </form>
      </div>

      <script src="../js/signup.js"></script>
      <script>
         console.log(errorMessage);
         if (typeof errorMessage !== 'undefined') {
             var errorDiv = document.getElementById("errorMessage");
             errorDiv.textContent = errorMessage;
         }
         if (typeof duplicateMessage !== 'undefined') {
             var duplicateDiv = document.getElementById("duplicateMessage");
             duplicateDiv.textContent = duplicateMessage; // 수정: errorDiv가 아닌 duplicateDiv를 사용
         }

         var duplicateButtonClicked = false;

         function validatePassword() {
         // 중복확인 버튼을 누르지 않았을 때만 유효성 검사를 수행
         if (!duplicateButtonClicked) {
            var passwordInput = document.getElementById("password");
            var password = passwordInput.value;

            var regexPw = /^[A-Za-z0-9`~!@#\$%\^&\*\(\)\{\}\[\]\-_=\+\\|;:'"<>,\./\?]{8,20}$/;
            var isValidPassword = regexPw.test(password);

            var errorMessage = document.getElementById("passwordErrorMessage");

            if (!isValidPassword) {
               errorMessage.textContent = "8~20자 영문 대소문자, 숫자, 특수문자를 사용하세요.";
               passwordInput.value = ""; // 입력란 비우기
               passwordInput.focus(); // 입력란으로 포커스 이동
               return false;
            } else {
               errorMessage.textContent = ""; // 에러 메시지를 초기화
            }
         }

  return true;
}


     </script>
   </body>
