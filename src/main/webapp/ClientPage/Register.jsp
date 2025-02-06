<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Highlight - FW24 Collection</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- MDB CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css" rel="stylesheet">

</head>
<body>
<section class="vh-100" style="background-color: #999999;">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-xl-10">
                <div class="card" style="border-radius: 1rem;">
                    <div class="row g-0">
                        <div class="col-md-12">
                            <form action="registerController"  method="post" enctype="multipart/form-data" onsubmit="hashPassword()">
                                <div class="row">
                                    <!-- Avatar preview và input file bên trái -->
                                    <div class="col-md-6 d-flex flex-column align-items-center justify-content-center">
                                        <div class="text-center mb-4">
                                            <img id="avatarPreview" 
                                                 src="Image_Customers/noavatar.jpg" 
                                                 alt="Avatar Preview" 
                                                 class="img-fluid rounded" 
                                                 style="width: 400px; height: 400px; object-fit: cover;" />
                                        </div>
                                        <label for="avatarInput" class="btn btn-secondary">Chọn ảnh</label>
                                        <input type="file" id="avatarInput" class="form-control d-none" accept="image/*"
                                               name="image" onchange="previewAvatar(event)"/>
                                   	</div>
                                    
                                    <!-- Form đăng ký bên phải -->
                                    <div class="col-md-6 d-flex align-items-center">
                                        <div class="card-body p-4 p-lg-5 text-black">
                                            <div class="d-flex align-items-center mb-3 pb-1">
                                                <i class="fas fa-user-plus fa-2x me-3" style="color: #ff6219;"></i>
                                                <span class="h1 fw-bold mb-0">ĐĂNG KÝ</span>
                                            </div>

                                            <!-- Name -->
                                            <div class="form-outline mb-4">
                                                <input type="text" id="name" name="name" class="form-control form-control-lg" required
                                              	         pattern="[A-ZÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴEÈÉẸẺẼÊỀẾỆỂỄIÌÍỊỈĨOÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠUÙÚỤỦŨƯỪỨỰỬỮYÝỊỶỸĐ\s]*" 
                      									 oninput="toUpperCase(this); validateInput(this);"
                                                />
                                                <label class="form-label" for="name" >Họ và Tên</label>
                                            </div>

                                            <!-- Email -->
                                            <div class="form-outline mb-4">
                                                <input type="email" id="email" name="email" class="form-control form-control-lg" required/>
                                                <label class="form-label" for="email">Email</label>
                                            </div>

                                            <!-- Phone và Birthday trên cùng 1 hàng -->
                                            <div class="row">
                                                <!-- Phone -->
                                                <div class="col-md-6 mb-4">
                                                    <div class="form-outline">
                                                        <input type="tel" id="phone" name="phone" class="form-control form-control-lg" 
                                                        		 pattern="^\d{10}$" maxlength="10" 
                                                        		 oninput="this.value = this.value.replace(/[^0-9]/g, '')"  inputmode="numeric"
                                                        		 required/>
                                                        <label class="form-label" for="phone">Số Điện Thoại</label>
                                                    </div>
                                                </div>
                                                <!-- Birthday -->
                                                <div class="col-md-6 mb-4">
                                                    <div class="form-outline">
                                                        <input type="date" id="birthday" name="birthday" class="form-control form-control-lg" />
                                                        <label class="form-label" for="birthday">Ngày Sinh</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Address và Gender trên cùng 1 hàng -->
                                            <div class="row">
                                                <!-- Address -->
                                                <div class="col-md-6 mb-4">
                                                    <div class="form-outline">
                                                        <input type="text" id="address" name="address" class="form-control form-control-lg" required/>
                                                        <label class="form-label" for="address">Địa Chỉ</label>
                                                    </div>
                                                </div>
                                                <!-- Gender -->
                                                <div class="col-md-6 mb-4 d-flex align-items-center">
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="radio" name="gender" id="male" value=true />
                                                        <label class="form-check-label" for="male">Nam</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="radio" name="gender" id="female" value=false />
                                                        <label class="form-check-label" for="female">Nữ</label>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Password -->
                                            <div class="form-outline mb-4">
                                                <input type="password" id="password" name="password" class="form-control form-control-lg"  maxlength="20"  required/>
                                                <label class="form-label" for="password">Mật Khẩu</label>
                                            </div>

                                            <!-- Button -->
                                            <div class="pt-1 mb-4">
                                                <button data-mdb-button-init data-mdb-ripple-init 
                                                        class="btn btn-dark btn-lg btn-block" type="submit">
                                                    ĐĂNG KÝ
                                                </button>
                                            </div>
											
											<c:if test="${not empty notificationCustomer}">
											    <div class="container mt-3">
											        <!-- Thẻ thông báo lỗi -->
											        <div class="alert alert-danger alert-dismissible fade show" role="alert" style="max-width: 400px; margin: 0 ; padding:10px;">
											            <c:out value="${notificationCustomer}" />
											            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding:15px;"></button>
											        	<c:remove var="notificationCustomer" scope="session" />
											        </div>
											    </div>
											</c:if>
											
                                            <p class="mb-5 pb-lg-2" style="color: #393f81;">
                                                Nếu bạn đã có Tài Khoản rồi thì 
                                                <a href="loginController" style="color: #808080;font-weight:600;">ĐĂNG NHẬP</a>
                                                ở đây !!!
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<!-- MDB JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"></script>
<!-- CryptoJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.min.js"></script>

<script>
	//Hàm preview Avatar
	function previewAvatar(event) {
	    const reader = new FileReader();
	    reader.onload = function () {
	        const preview = document.getElementById('avatarPreview');
	        preview.src = reader.result;
	    };
	    reader.readAsDataURL(event.target.files[0]);
	}
	
	// Hàm này chuyển tất cả ký tự thành chữ hoa
	function toUpperCase(input) {
	    input.value = input.value.toUpperCase();
	}
	
	// Hàm này kiểm tra và loại bỏ số và ký tự đặc biệt
	function validateInput(input) {
	    const regex = /^[A-ZÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴEÈÉẸẺẼÊỀẾỆỂỄIÌÍỊỈĨOÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠUÙÚỤỦŨƯỪỨỰỬỮYÝỊỶỸĐ\s]*$/;
	    input.value = input.value.replace(/[^A-ZÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴEÈÉẸẺẼÊỀẾỆỂỄIÌÍỊỈĨOÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠUÙÚỤỦŨƯỪỨỰỬỮYÝỊỶỸĐ\s]/g, '');
	}
	
	//Hàm này mã hóa mật khẩu bằng SHA-256 trước khi gửi đi
	function hashPassword() {
	    var password = document.getElementById("password").value;
	    var hashedPassword = CryptoJS.SHA256(password).toString(CryptoJS.enc.Base64); // mã hóa ra chuỗi Base64
	    document.getElementById("password").value = hashedPassword;
	    console.log(hashedPassword);
	}
</script>
</body>
</html>