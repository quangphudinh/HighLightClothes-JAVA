<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
      <title>Thêm Mới Sản Phẩm</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
    	  /* Header */
         .navbar {
	      padding: 10px 0;
	    }
	    .navbar-brand img {
	      width: 120px; /* Adjust logo size */
	    }
	    .navbar-nav {
	      display: flex;
	      justify-content: center;
	      flex-grow: 1;
	    }
	    .navbar-nav .nav-item {
	      margin: 0 15px;
	    }
	    .navbar-nav .nav-link {
	     /*  color: #000 !important; */
	      font-size: 18px;
	    }
	    .navbar-nav .nav-link:hover {
	      color: #000 !important;
	      text-decoration: underline;
	    }
	   .navbar-icons {
	      display: flex;
	      align-items: center;
	      margin-right : 10px
	    }
	    .navbar-icons i {
	      font-size: 20px;
	      margin-left: 20px;
	      cursor: pointer;
	    }
	    .shopping-cart-container {
	      position: relative; 
	      margin-right : 10px
	    }
	    .shopping-cart-container i{
	     	margin : 0px;
	    }
		.navbar-icons .btn{
			padding : 10px;
			width : auto;
		}
		.navbar-icons .btn i{
			margin : 0px;
		}
	    .navbar-icons .shopping-cart-container .cart-count {
	      position: absolute;
	      top: -5px;
	      right: -10px;
	      background-color: red;
	      color: white;
	      font-size: 12px;
	      font-weight: bold;
	      border-radius: 50%;
	      padding: 2px 6px;
	      min-width: 20px;
	      text-align: center;
	    }
	    /* Input search styling */
	    .navbar-icons .search-input {
	      max-width: 100px;
	      min-width: 100px;
	      width: 100%;
	    }
    	
        body {
	      
		  font-family: Arial, sans-serif;
		}
		
		#wrapper {
		  display: flex;
		}
		
		/* Responsive sidebar (nếu cần cho màn hình nhỏ) */
		@media (max-width: 768px) {
		  #sidebar-wrapper {
		    width: 200px;
		  }
		
		  #page-content-wrapper {
		    margin-left: 200px;
		    width: calc(100% - 200px);
		  }
		}

        form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: bold;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .custom-file-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 490px;
            border: 1px solid #ddd;
            border-radius: 8px; 
            margin-bottom: 10px;
            position: relative;
        }

        .custom-file-container img {
            width: 400px;
            height: 400px;
        }

        .custom-file-container label {
            position: absolute;
            bottom: 10px;
            width: 150px;
            text-align: center;
        }

        .form-control, .form-select {
            max-width: 500px;
        }

        .form-inline-group {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .action-buttons {
            justify-content: center;
        }

        .action-buttons .btn {
            min-width: 100px;
            margin: 0 5px;
        }
          /* Footer */
        .footer {
            background-color: #f8f9fa;
            padding: 40px 0;
            font-size: 14px;
            color: #000;
            margin-top : 50px;
            position: relative;
    		z-index: 100;
        }
        .footer h5 {
            font-weight: bold;
            margin-bottom: 15px;
        }
        .footer a {
            text-decoration: none;
            color: #000;
        }
        .footer a:hover {
            text-decoration: underline;
        }
        .social-icons a {
            margin-right: 10px;
            color: #000;
            font-size: 24px;
        }
        .side-icons {
            position: fixed;
            right: 20px;
            bottom: 20px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .side-icons a {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #000;
            color: #fff;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            text-decoration: none;
            font-size: 20px;
        }
    </style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	    <a class="navbar-brand" href="homeController">
	      <img src="https://theme.hstatic.net/200000848159/1001200696/14/logo.png?v=374" alt="Logo">
	    </a>
	    <div class="collapse navbar-collapse">
	      <ul class="navbar-nav">
	        <li class="nav-item">
	          <a class="nav-link" href="homeController">Trang Chủ</a>
	        </li>
	        <li class="nav-item active">
	          <a class="nav-link" href="productController">Sản Phẩm</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="introductionController">Giới Thiệu</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="contactController">Liên Hệ</a>
	        </li>
	      </ul>
	    </div>
	    
	    <div class="navbar-icons">
	      <div class="d-flex align-items-center gap-2">
	          <input class="form-control search-input" type="text" placeholder="Search">
	          <button type="submit" class="btn">
	          	<i class="fa fa-search" ></i>
	          </button>
	        </div>
	        
       		<div class="navbar-custom-menu">
			    <ul class="nav navbar-nav">
			        <c:if test="${not empty sessionScope.Token}">
			            <!-- Nếu đã có token, hiển thị avatar người dùng -->
			            <li class="nav-item dropdown">
			                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown" 
			                   role="button" data-bs-toggle="dropdown" aria-expanded="false">
			                    <img src="${sessionScope.Avatar}" alt="User Avatar" class="rounded-circle" 
			                         style="width: 30px; height: 30px; object-fit: cover;">
			                </a>
			                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
			                    <!-- User image -->
			                    <li class="dropdown-header text-center">
			                        <img src="${sessionScope.Avatar}" alt="User Avatar" class="rounded-circle mb-2" 
			                             style="width: 50px; height: 50px; object-fit: cover;">
			                        <p class="mb-0">${sessionScope.DisplayName}</p>
			                    </li>
			                    <li><hr class="dropdown-divider"></li>
			                    <!-- Menu Footer -->
			                    <li class="d-flex">
								    <a class="dropdown-item text-danger fw-bold justify-content-center" href="logoutController">Đăng Xuất</a>
								</li>
			                </ul>
			            </li>
			        </c:if>
			
			        <c:if test="${empty sessionScope.Token}">
			            <!-- Nếu chưa có token, hiển thị icon user -->
			            <li class="nav-item">
			                <a class="nav-link" href="loginController">
			                    <i class="fa fa-user"></i>
			                </a>
			            </li>
			        </c:if>
			    </ul>
			</div>
	
	      <a href="shoppingCartController" class="shopping-cart-container nav-link">
			 <i class="fa fa-shopping-cart"></i>
			  <span class="cart-count">
			  	<c:if test="${empty sessionScope.SizeofCart }">
			  		0
			  	</c:if>
			  	<c:if test="${not empty sessionScope.SizeofCart }">
			  		${sessionScope.SizeofCart }
			  	</c:if>
			  </span>
		  </a>
		  
	    </div>
	  </nav>
	  
    <div class="d-flex" id="wrapper">
        <!-- Page Content -->
        <div id="page-content-wrapper" class="w-100">
            
            <c:if test="${not empty sessionScope.notificationCustomer}">
            	<div class="container mt-5">
			        <!-- Thẻ thông báo -->
			        <div class="alert alert-success alert-dismissible fade show" role="alert">
			            <c:out value="${sessionScope.notificationCustomer}" />
			            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			            <c:remove var="notificationCustomer" scope="session" />
			        </div>
			    </div>
			</c:if>
             

            <div class="container my-4">
                <form action="profileUpdateController" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <!-- Ảnh sản phẩm -->
                        <div class="col-md-6">
                            <div class="custom-file-container">
                                <img src="${Customer.getAvatar() }" alt="${Customer.getName() }" id="imagePreview">
                                <label for="image" class="btn btn-secondary">Chọn ảnh</label>
                                <input type="file" class="form-control d-none" id="image" name="image" accept="image/*" onchange="previewImage(event)">
                           		<input type="hidden" value="${Customer.getAvatar() }" name="hiddenImage">
                            </div>
                        </div>

                        <div class="col-md-6">
                           <div class="mb-3">
			                    <label for="fullName" class="form-label">Họ Tên</label>
			                    <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ tên" value="${Customer.getName() }" required>
			                </div>
			               
			                <div class="mb-3 form-inline-group">
							    <div class="col-md-6">
							        <label for="dob" class="form-label">Ngày Sinh</label>
							        <input type="date" class="form-control" id="dob" name="dob" value="${Customer.getBirthDay() }">
							    </div>
							 <div class="col-md-3">
							   	 <label for="gender" class="form-label">Giới Tính</label>
							    <select class="form-select" id="gender" name="gender">
							        <option value="true" 
							        	<c:if test="${Customer.getGender() == true}">
							        		selected
						        		</c:if>>Nam</option>	      
							        <option value="false" 
							        	<c:if test="${Customer.getGender() == false}">
							        		selected
						        		</c:if>>Nữ</option>
							    </select>
							</div>
							</div>
							
			                <div class="mb-3">
			                    <label for="email" class="form-label">Email</label>
			                    <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email" value="${Customer.getEmail() }" required>
			               		<input type="hidden" name="oldemail" value="${Customer.getEmail() }" >
			                </div>
			                <div class="mb-3">
			                    <label for="address" class="form-label">Địa chỉ</label>
			                    <input type="text" class="form-control" id="address" name="address" placeholder="Nhập địa chỉ" value="${Customer.getAddress() }">
			                </div>
			                <div class="mb-3">
							    <label for="phone" class="form-label">Số Điện Thoại</label>
							    <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại" value="${Customer.getPhone()}"
							        pattern="^\d{10}$" maxlength="10" required>
							    <small class="form-text text-muted">Số điện thoại phải có 10 chữ số, bao gồm số 0 đầu tiên.</small>
							</div>
							
		                 </div> 
	                 </div>

                    <!-- Nút hành động -->
                    <div class="d-flex justify-content-center action-buttons mt-4">
                        <button type="button" class="btn btn-secondary border" onclick="window.history.back()">Trở Lại</button>
                        <button type="button" class="btn btn-light border" onclick="location.reload()">Nhập Lại</button>
                        <button type="submit" class="btn btn-primary">Cập Nhật</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- /#page-content-wrapper -->
    </div>
    <!-- /#wrapper -->
	 <!-- Footer -->
	<div class="footer">
	    <div class="container">
	        <div class="row text-start">
	            <!-- HIGHLIGHT STUDIO -->
	            <div class="col-md-3 mb-4">
	                <h5>HIGHLIGHT STUDIO</h5>
	                <div class="social-icons">
	                    <a href="#"><i class="bi bi-facebook"></i></a>
	                    <a href="#"><i class="bi bi-instagram"></i></a>
	                </div>
	            </div>
	
	            <!-- THÔNG TIN LIÊN HỆ -->
	            <div class="col-md-4 mb-4">
	                <h5>THÔNG TIN LIÊN HỆ</h5>
	                <p><i class="bi bi-geo-alt"></i> 23/154 BÀ TRIỆU, PHƯỜNG PHÚ HỘI, TP HUẾ</p>
	                <p><i class="bi bi-telephone"></i> 0866672275</p>
	                <p><i class="bi bi-envelope"></i> CSKH@HIGHLIGHT.VN</p>
	            </div>
	
	            <!-- LIÊN KẾT -->
	            <div class="col-md-3 mb-4">
	                <h5>LIÊN KẾT</h5>
	                <p><a href="#">TÌM KIẾM</a></p>
	                <p><a href="#">GIỚI THIỆU</a></p>
	                <p><a href="#">CHÍNH SÁCH ĐỔI TRẢ</a></p>
	                <p><a href="#">CHÍNH SÁCH BẢO MẬT</a></p>
	                <p><a href="#">ĐIỀU KHOẢN DỊCH VỤ</a></p>
	                <p><a href="#">HÌNH THỨC THANH TOÁN</a></p>
	                <p><a href="#">LIÊN HỆ</a></p>
	            </div>
	
	            <!-- FANPAGE -->
	            <div class="col-md-2 mb-4">
	                <h5>FANPAGE</h5>
	                <p><a href="#">FACEBOOK</a></p>
	                <p><a href="#">INSTAGRAM</a></p>
	            </div>
	        </div>
	        <div class="text-center mt-4">
	            <p>COPYRIGHT © 2024 HIGHLIGHT STUDIO. POWERED BY HARAVAN</p>
	        </div>
	    </div>
	</div>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle sidebar visibility
        document.getElementById("menu-toggle").addEventListener("click", function () {
            const wrapper = document.getElementById("wrapper");
            wrapper.classList.toggle("toggled");
        });

        // Preview image
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function () {
                const output = document.getElementById('imagePreview');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</body>
</html>
