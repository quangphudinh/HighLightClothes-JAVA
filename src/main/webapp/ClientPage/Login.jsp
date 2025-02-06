<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Highlight - FW24 Collection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet">
</head>
<body>
<section class="vh-100" style="background-color: #999999;">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-xl-10">
                <div class="card" style="border-radius: 1rem;">
                    <div class="row g-0">
                        <div class="col-md-6 d-none d-md-block">
                            <img 
                                src="Image_Products/logo-highlight.jpg" 
                                alt="login form" 
                                class="img-fluid" 
                                style="border-radius: 1rem 0 0 1rem;" />
                        </div>
                        <div class="col-md-6 d-flex align-items-center">
                            <div class="card-body p-4 p-lg-5 text-black">
                                <form action="loginController" method="post" onsubmit="hashPassword()">
                                    <div class="d-flex align-items-center mb-3 pb-1">
                                        <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                                        <span class="h1 fw-bold mb-0">HIGH LIGHT</span>
                                    </div>

                                    <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">ĐĂNG NHẬP TÀI KHOẢN</h5>

                                    <!-- Email -->
                                    <div data-mdb-input-wrapper-init class="form-outline mb-4">
                                        <input type="email" id="form2Example17" name="email" class="form-control form-control-lg" required />
                                        <label class="form-label" for="form2Example17">Email</label>
                                    </div>

                                    <!-- Password -->
                                    <div data-mdb-input-wrapper-init class="form-outline mb-4">
                                        <input 
                                            type="password" 
                                            id="password"  
                                            name="password" 
                                            class="form-control form-control-lg" 
                                            maxlength="20"
                                            required 
                                        />
                                        <label class="form-label" for="form2Example27">Mật Khẩu</label>
                                    </div>
									
									<!-- capcha -->
									<c:set var="d" value="${sessionScope.dem != null ? sessionScope.dem : 0}" />
								   	<c:if test="${d >= 3}">	   
									    <div data-mdb-input-wrapper-init class="form-outline mb-4">
	                                        <input 
	                                            type="text" 
	                                            id="answer"  
	                                            name="answer" 
	                                            class="form-control form-control-lg" 
	                                            required 
	                                        />
	                                        <label class="form-label" for="form2Example27">Enter Capcha</label>
	                                    </div>
	                                     <div data-mdb-input-wrapper-init class="form-outline mb-4">
										    <img class="captcha-image" src="simpleCaptcha.jpg" /><br>
									    </div>
									   	<!-- <input type="text" name="answer" class="form-control" placeholder="Enter Capcha"/><br> -->
								    </c:if>
									
                                    <!-- Button -->
                                    <div class="pt-1 mb-4">
                                        <button 
                                            data-mdb-button-init 
                                            data-mdb-ripple-init 
                                            class="btn btn-dark btn-lg btn-block" 
                                            type="submit">
                                            ĐĂNG NHẬP
                                        </button>
                                    </div>
                                    
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
									<c:if test="${not empty  sessionScope.notificationCustomer}">
									    <div class="container mt-3">
									        <!-- Thẻ thông báo lỗi -->
									        <div class="alert alert-success alert-dismissible fade show" role="alert" style="max-width: 400px; margin: 0 ; padding:10px;">
									            <c:out value="${sessionScope.notificationCustomer}" />
									            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding:15px;"></button>
									        	<c:remove var="notificationCustomer" scope="session" />
									        </div>
									    </div>
									</c:if>

                                    <a class="small text-muted" href="#!">Quên mật khẩu?</a>
                                    <p class="mb-5 pb-lg-2" style="color: #393f81;">
                                        Bạn đã có tài khoản chưa? 
                                        <a href="registerController" style="color: #808080;font-weight:600;">ĐĂNG KÝ</a>
                                    </p>
                                    <a href="#!" class="small text-muted">Đều khoản sử dụng và </a>
                                    <a href="#!" class="small text-muted">Chính sách riêng tư</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"></script>
<!-- CryptoJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.min.js"></script>
<script>
	//Hàm này mã hóa mật khẩu bằng SHA-256 trước khi gửi đi
	function hashPassword() {
	    var password = document.getElementById("password").value;
	    var hashedPassword = CryptoJS.SHA256(password).toString(CryptoJS.enc.Base64); // mã hóa ra chuỗi Base64
	    document.getElementById("password").value = hashedPassword;
	}
</script>
</body>
</html>