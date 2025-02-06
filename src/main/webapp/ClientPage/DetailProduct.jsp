<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	  <meta charset="UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <title>Highlight - FW24 Collection</title>
	  <!-- Bootstrap CSS -->
	  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
	  <style>
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

        /* Footer */
        .footer {
            background-color: #f8f9fa;
            padding: 40px 0;
            font-size: 14px;
            color: #000;
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
        .side-icons a.messenger {
            background-color: #0078FF;
        }
		/* Btn-Back */
		 .back-btn {
            border: none;
            background-color: white;
            color: gray;
            font-size: 16px;
            display: inline-flex;
            align-items: center;
            padding: 8px 16px;
            cursor: pointer;
        }

        .back-btn:hover {
            color: black;
        }

        .back-btn i {
            margin-right: 8px;
        }
	  </style>
</head>
<body>
  <!-- Navbar -->
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
        <li class="nav-item">
	          <a class="nav-link" href="invoicesController">Lịch Sử</a>
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
			                    <li>
			                        <a class="dropdown-item" href="profileController">Thông Tin Cá Nhân</a>
			                    </li>
			                    <li>
			                        <a class="dropdown-item text-danger" href="logoutController">Đăng Xuất</a>
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

	<div>
        <button class="back-btn" onclick="history.back()">
            <i class="bi bi-arrow-left"></i> Quay lại
        </button>
    </div>

<section class="py-5">
  <div class="container">
    <div class="row gx-5">
      <div class="col-lg-6 mb-4 mb-lg-0 mx-auto">
        <img 
          src="${Detail.getPhoto() }" 
          alt="${Detail.getName() }" 
          class="img-fluid rounded d-block mx-auto"
        >
      </div>
      
      <div class="col-lg-6 mx-auto">
        <h6 class="text-muted text-uppercase">HIGHT LIGHT STUDIO</h6>
        <h1 class="h3 mb-3 fw-bold text-uppercase">${Detail.getName() }</h1>
		<div class="d-flex flex-column align-items-start">
		    <c:if test="${not empty newPrice}">
		        <div class="text-muted" style="font-size: 1.5rem;">
		            <del class="text-danger">${Detail.getPrice()}00 VND</del>
		        </div>
		        <div class="fw-bold text-success" style="font-size: 2rem;">
		            ${newPrice}00 VND
		        </div>
		    </c:if>
		    <c:if test="${newPrice == null}">
		        <div class="fw-bold text-success" style="font-size: 2rem;">
		            ${Detail.getPrice()}00 VND
		            
		        </div>
		    </c:if>
		</div>
        <div class="d-flex align-items-center mb-4">
          <div class="d-flex me-3">
            <i class="bi bi-star-fill text-primary"></i>
            <i class="bi bi-star-fill text-primary"></i>
            <i class="bi bi-star-fill text-primary"></i>
            <i class="bi bi-star-fill text-primary"></i>
            <i class="bi bi-star text-primary"></i>
          </div>
          <span class="text-muted">4 Reviews</span>
        </div>

        <div class="mb-4">
            <%-- Chuỗi đầu vào --%>
		    <c:set var="description" value=" ${Detail.getDescription() }" />
		    <%-- Tách chuỗi thành mảng dựa trên dấu "-" --%>
		    <c:set var="parts" value="${fn:split(description, ';')}" />
		    <%-- Hiển thị từng phần tử trên từng dòng --%>
		    <h3>Mô tả sản phẩm:</h3>
		    <ul>
		        <c:forEach var="part" items="${parts}">
		            <li style="white-space: pre-wrap;">${part}</li>
		        </c:forEach>
		    </ul>
        </div>

        <div class="mb-4 pb-3 border-bottom">
          <div class="mb-3">
            <span class="me-3">Color</span>
            <button class="btn btn-sm btn-outline-secondary rounded-circle p-3"></button>
            <button class="btn btn-sm btn-secondary rounded-circle p-3 ms-2"></button>
            <button class="btn btn-sm btn-primary rounded-circle p-3 ms-2"></button>
          </div>
          
           <form action="productDetailController" method="post">
	            <!-- Chọn Size và Số Lượng nằm trên cùng 1 hàng -->
	            <div class="row mb-3">
	                <div class="col">
	                    <label for="size" class="form-label">Chọn Size</label>
	                    <select class="form-select" id="size" name="size" required>
	                        <option value="S">S</option>
	                        <option value="M">M</option>
	                        <option value="L">L</option>
	                        <option value="XL">XL</option>
	                        <option value="XXL">XXL</option>
	                    </select>
	                </div>
	                <div class="col">
	                    <label for="quantity" class="form-label">Số Lượng</label>
	                    <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="1" max="${Detail.getStock() }" required>
	                </div>
	            </div>
	
	            <!-- Input ẩn productID và idcustomer -->
	            <input type="hidden" id="productID" name="productID" value="${Detail.getProductID() }">
	
	            <!-- Nút gửi -->
	            <button type="submit" class="btn btn-primary px-4 me-2">Add to Cart</button>
	        </form>  
	        
        	<c:if test="${not empty  sessionScope.notificationCart}">
			    <div class="container mt-3">
			        <div class="alert alert-success alert-dismissible fade show" role="alert" style="max-width: 400px; margin: 0 ; padding:10px;">
			            <c:out value="${sessionScope.notificationCart}" />
			            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding:15px;"></button>
			        	<c:remove var="notificationCart" scope="session" />
			        </div>
			    </div>
			</c:if>
 
        </div>   
      </div>
    </div>
    
    <div class="row gx-5">
	  <div class="col d-flex justify-content-center">
	    <img 
	      src="https://file.hstatic.net/200000848159/file/ban_sao_cua_size_chart_98ba650af30e4f979189e392eb9c7c00_grande.png" 
	      alt="ảnh size áo" 
	      class="img-fluid rounded"
	    >
	  </div>
	  <div class="col d-flex justify-content-center">
	    <img 
	      src="https://file.hstatic.net/200000848159/file/ban_sao_cua_size_chart_e9a31f248e7a437789d2146fcb3a2e21_grande.png" 
	      alt="ảnh size quần" 
	      class="img-fluid rounded"
	    >
	  </div>
	</div>
  </div>
</section>

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


  <!-- Bootstrap JS and dependencies -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

 
</body>
</html>


