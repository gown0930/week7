var year = document.getElementById("year");
for (var i = 1950; i <= 2023; i++) {
    var option = document.createElement("option");
    option.value = i;
    option.text = i;
    year.appendChild(option);
}

var month = document.getElementById("month");
for (var i = 1; i <= 12; i++) {
    var option = document.createElement("option");
    option.value = i;
    option.text = i;
    month.appendChild(option);
}

var day = document.getElementById("day");
for (var i = 1; i <= 31; i++) {
    var option = document.createElement("option");
    option.value = i;
    option.text = i;
    day.appendChild(option);
}


var passwordInput = document.getElementById("password");
var confirmPasswordInput = document.getElementById("confirmPassword");
var passwordMatchMessage = document.getElementById("passwordMatchMessage");

passwordInput.addEventListener("input", checkPasswordMatch);
confirmPasswordInput.addEventListener("input", checkPasswordMatch);

function checkPasswordMatch() {
    var password = passwordInput.value;
    var confirmPassword = confirmPasswordInput.value;

    if (password === confirmPassword) {
        passwordMatchMessage.textContent = "비밀번호가 일치합니다.";
        passwordMatchMessage.style.color = "green";
    } else {
        passwordMatchMessage.textContent = "비밀번호가 일치하지 않습니다.";
        passwordMatchMessage.style.color = "red";
    }
}

function previewImage(event) {
   var imageInput = document.getElementById('imageInput');
   var imagePreview = document.getElementById('preview');

   var file = event.target.files[0];

   if (file) {
       var reader = new FileReader();

       reader.onload = function(e) {
           imagePreview.src = e.target.result;
       }

       reader.readAsDataURL(file);
   } else {
       imagePreview.src = '#';
   }
}
