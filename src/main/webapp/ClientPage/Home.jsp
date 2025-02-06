<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	    .carousel-item img {
	      width: 100%;
	      height: 400px;
	      object-fit: cover;
	    }
	    /* Product */
	    .product-img {
	      width: 100%;
	      height: auto;
	      border-radius: 10px;
	    }
	    .carousel-inner {
	      height: 100%;
	    }
	    .carousel-item img {
		  width: 100%;
		  height: 600px; /* Điều chỉnh chiều cao của hình ảnh carousel */
		  object-fit: cover; /* Đảm bảo hình ảnh phủ đầy vùng chứa mà không bị biến dạng */
		}
		.carousel-inner {
		  height: 600px; /* Đảm bảo chiều cao của carousel container lớn hơn */
		}
	    .product-card {
	      text-align: center;
	      margin-bottom: 20px;
	      padding: 10px;
		  transition: transform 0.3s ease; /* Thêm hiệu ứng hover */
	    }
	    .product-card img {
	      max-width: 100%;
	    }
		.product-link {
		  text-decoration: none; /* Xóa gạch chân khỏi liên kết */
		  color: inherit; /* Giữ nguyên màu sắc văn bản */
		}
			
		.product-card:hover {
		  transform: scale(1.05); /* Phóng to khi hover */
		  text-decoration: none; 
		}
	    /* Voucher */
	    .voucher-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            margin: 10px 0;
            padding: 20px;
            background: #fff;
            position: relative;
        }
        .voucher-card::before, .voucher-card::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 20px;
            height: 40px;
            background-color: #f5f5f5;
            border-radius: 50%;
            transform: translateY(-50%);
        }
        .voucher-card::before {
            left: -10px;
        }
        .voucher-card::after {
            right: -10px;
        }
        .voucher-icon {
            background-color: #FF8C56;
            color: #fff;
            border-radius: 50%;
            width: 80px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
        }
        .voucher-content h5 {
            margin-bottom: 10px;
            font-weight: bold;
        }
        .btn-copy {
            background-color: #000;
            color: #fff;
            font-weight: bold;
            border-radius: 5px;
        }
        .btn-copy:hover {
            background-color: #333;
            color: #fff;
        }
        .voucher-detail a {
            color: #0066FF;
            font-weight: bold;
            text-decoration: none;
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
       
        /* Giảm Giá */
        /* Tag giảm giá */
		.discount-tag {
		  position: absolute;
		  top: 10px;
		  left: 10px;
		  background-color: white;
		  color: red;
		  padding: 5px 10px;
		  font-weight: bold;
		  border-radius: 5px;
		  border : solid 1px red;
		  font-size: 14px;
		}
		
		/* Tag hết hàng */
		.out-of-stock-tag {
		  position: absolute;
		  bottom: 10px;
		  right: 10px;
		  background-color: white ;
		  color: gray;
		  padding: 5px 10px;
		  font-weight: bold;
		  border-radius: 5px;
		  border : solid 1px gray;
		  font-size: 14px;
		}
		
		/* Đảm bảo thẻ sản phẩm có position: relative để chứa các tag */
		/* .product-card {
		  position: relative;
		  border: 1px solid #ddd;
		  padding: 10px;
		  border-radius: 8px;
		  transition: transform 0.3s ease;
		} */
		
		/* Thêm hiệu ứng hover */
		.product-card:hover {
		  transform: scale(1.05);
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
        <li class="nav-item active">
          <a class="nav-link" href="homeController">Trang Chủ</a>
        </li>
        <li class="nav-item">
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

 <!-- Carousel -->
  <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="https://theme.hstatic.net/200000848159/1001200696/14/slideshow_2.jpg?v=374" class="d-block w-100" alt="FW24 Collection">
      </div>
      <div class="carousel-item">
        <img src="https://theme.hstatic.net/200000848159/1001200696/14/slideshow_1.jpg?v=374" class="d-block w-100" alt="Highlight Studio">
      </div>
    </div>
    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div> -->

	<!-- KHUYẾN MÃI -->
	<div class="container my-5">
	    <h3 class="text-center mb-4 fw-bold">MÃ KHUYẾN MÃI</h3>
	    <div class="row justify-content-center">
	        <!-- Voucher -->
	        <c:forEach var="prom" items="${listPromotions}">
	        	<div class="col-md-5 mb-3">
		            <div class="voucher-card">
		                <div class="voucher-icon">
		                    <i class="bi bi-gift fs-2"></i>
		                </div>
		                <div class="voucher-content">
		                    <h5>${prom.getName()}</h5>
		                    <p class="mb-1">GIẢM ${prom.getDiscount()}% TỐI ĐA 100,000VNĐ</p>
		                    <p>HSD: ${prom.getEndDay() }</p>
		                    <div class="voucher-detail">
		                        <a href="#">CHI TIẾT</a>
		                    </div>
		                </div>
		                <div class="ms-auto">
		                    <button class="btn btn-copy">SAO CHÉP</button>
		                </div>
		            </div>
		        </div>
	        </c:forEach>
	        
	    </div>
	</div>
	<!-- /#KHUYẾN MÃI -->
	
  <!-- Product Section -->
  <div class="container mt-5">
    <h2 class="text-center mb-4">NEW COLLECTION</h2>
    <div class="row">
    	<c:forEach var="prod" items="${listProducts}"> 				
    		<a href="ProductDetailController?productID=${prod.getProductID() }" class="product-link col-md-3 product-card"> 
    			<c:forEach var="prom" items="${listPromotions}">
	    			<c:if test="${prod.getPromotionID() != 1 && prod.getPromotionID() == prom.getPromotionID() }">
		    			<div class="discount-tag">-${prom.getDiscount()}%</div>
		    		</c:if>
	    		</c:forEach>
	        	<img src="${prod.getPhoto() }" class="product-img" alt="${prod.getName() }">
	        	<h5 class="mt-2">${prod.getName() }</h5>
	        	<p>Giá : ${prod.getPrice() }</p>
     		    <c:if test="${prod.getStatus() == false}">
	    			<div class="out-of-stock-tag">Hết Hàng</div>
	    		</c:if>
	        </a>
    	</c:forEach>
    </div>
  </div>

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

<!-- Fixed Side Icons -->
<div class="side-icons">
   <!--  <a href="#"><i class="bi bi-telephone"></i></a>
    <a href="#"><i class="bi bi-envelope"></i></a>
    <a href="#"><i class="bi bi-geo-alt"></i></a>
    <a href="#"><i class="bi bi-messenger"></i></a> -->
 	<a href="#" class="messenger"><i class="bi bi-messenger"></i></a>
</div>

 
 <!-- Bootstrap JS and dependencies -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


