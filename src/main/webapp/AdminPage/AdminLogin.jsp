<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HighLight - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
  <style>
    body {
      background-color: #f8f9fa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .login-card {
      width: 100%;
      max-width: 400px;
      padding: 2rem;
      background: white;
      border-radius: 0.5rem;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
  </style>
</head>
<body>
  <div class="login-card">
    <h3 class="text-center mb-4">Đăng Nhập ADMIN</h3>
    <form id="loginForm" action="AdminLoginController" method="post">
      <div class="mb-3">
        <label for="username" class="form-label">Email</label>
        <input type="text" class="form-control" id="email" name="email" placeholder="Nhập Email:" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Mật khẩu :</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu : " required>
      </div>
      <c:set var="d" value="${sessionScope.dem != null ? sessionScope.dem : 0}" />
	   <c:if test="${d >= 3}">
		    <img class="captcha-image" src="simpleCaptcha.jpg" /><br>
		   	<input type="text" name="answer" class="form-control" placeholder="Enter Capcha"/><br>
	   </c:if>
	
      <button type="submit" class="btn btn-primary w-100">Đăng Nhập</button>
    </form>
    <c:if test="${not empty errorMessage}">
	    <div class="container mt-3">
	        <!-- Thẻ thông báo lỗi -->
	        <div class="alert alert-danger alert-dismissible fade show" role="alert" style="max-width: 400px; margin: 0 ; padding:10px;">
	            <c:out value="${errorMessage}" />
	            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding:15px;"></button>
	        	 <c:remove var="errorMessage" scope="page" />
	        </div>
	    </div>
	</c:if>
  </div>

  <!-- <script>
    // Xử lý mã hóa mật khẩu trước khi gửi form
    document.getElementById('loginForm').addEventListener('submit', function (e) {
      e.preventDefault(); // Ngăn không cho form gửi đi ngay

      const username = document.getElementById('username').value;
      const password = document.getElementById('password').value;

      // Mã hóa mật khẩu bằng SHA-256
      const hashedPassword = CryptoJS.SHA256(password).toString();

      // In dữ liệu ra console (thay vì gửi đi server trong ví dụ này)
      console.log('Username:', username);
      console.log('Hashed Password:', hashedPassword);

      // Giả sử gửi dữ liệu đến server
      alert('Login data ready to be sent to the server!');
    });
  </script> -->
</body>
</html>