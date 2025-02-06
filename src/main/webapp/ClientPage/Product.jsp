<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Highlight - FW24 Collection</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
        /* Sidebar cố định */
        .sidebar {
            position: fixed;
            top: 80px;
            left: 0;
            height: calc(100% - 80px);
            width: 220px;
            background-color: #FFFFFF;
            padding: 20px;
            overflow-y: auto;      
        }
        .sidebar .list-unstyled li {
        	margin-bottom:10px;
        	margin-left : 5px;
        }
        .sidebar .list-unstyled li a{
        	text-decoration: none; /* Xóa gạch chân khỏi liên kết */
        	font-weight : 600;
       		margin-buttom : 10px;
        	color : #999999 ;
        }
        
        .sidebar .list-unstyled li a:hover {
		  color: #000 !important;
	      text-decoration: underline;
		}
        
        .content {
            margin-left: 230px; /* Để tránh bị sidebar che */
        }
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
	    /* Sản Phẩm */
	    .card {
		  position: relative; /* Đặt card làm phần tử cha để các phần tử con có thể định vị tương đối */
		  
		}
		.card a {
		  text-decoration: none; /* Xóa gạch chân khỏi liên kết */
		  color: inherit; /* Giữ nguyên màu sắc văn bản */
		  margin-top : 10px;
		}
		.card a:hover {
		  transform: scale(1.05); /* Phóng to khi hover */
		  text-decoration: none; 
		}
		
		.discount-badge {
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
		
		.sold-out-badge {
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
				
        /* Khuyến Mãi */
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
            overflow: hidden;
        }
        .voucher-card .voucher-icon {
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
        .voucher-card .voucher-content h5 {
            margin-bottom: 10px;
            font-weight: bold;
            color: #333;
        }
        .voucher-card .voucher-content p {
            color: #555;
        }
        .btn-copy {
            background-color: #343a40;
            color: #fff;
            font-weight: bold;
            border-radius: 5px;
        }
        .btn-copy:hover {
            background-color: #007bff;
            color: #fff;
        }
		
		/* Thêm hiệu ứng hover */
		.product-card:hover {
		  transform: scale(1.05);
		}

        /* Fixed Sidebar */
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
        /* Select */
         .select-container select {
            color: gray;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
            font-weight : 600;
            color : #999999 ;
        }

        .select-container select option {
            color: gray;
            background: white;
            text-decoration: none;
        }

        .select-container select option:hover {
            color: black;
            text-decoration: underline;
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

    <!-- Sidebar -->
    <aside class="sidebar">
        <ul class="list-unstyled">
        	<c:forEach var="cate" items="${listCategories}">
        		 <li><a href="productController?categoryID=${cate.getCategoryID()}">${cate.getName() }</a></li>
        	</c:forEach>
        </ul>
    </aside>
	
    <!-- Main Content -->
    <main class="content">
        <!-- Mã Khuyến Mãi -->
        <section class="container mt-4">
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
        </section>

		<!-- Sản Phẩm -->
		<section class="container mt-5">
		    <div class="d-flex justify-content-between align-items-center mb-4">
		        <h4 class="fw-bold text-center">TẤT CẢ SẢN PHẨM</h4>
		        <div class="select-container">
		            <select onchange="location = this.value;">
		                <option value="#" disabled selected>Sắp Xếp Theo</option>
		                <option value="productController?categoryID=${cID}&&priceS=ASC">Giá : Tăng Dần</option>
		                <option value="productController?categoryID=${cID}&&priceS=DESC">Giá : Giảm Dần</option>
		                <option value="productController?categoryID=${cID}&&nameS=ASC">Tên : A - Z</option>
		                <option value="productController?categoryID=${cID}&&nameS=DESC">Tên : Z - A</option>
		                <option value="productController?categoryID=${cID}&&dateS=ASC">Cũ Nhất</option>
		                <option value="productController?categoryID=${cID}&&dateS=DESC">Mới Nhất</option>
		            </select> 
		        </div>
		    </div>
		    <div class="row row-cols-1 row-cols-md-4 g-4">
		        <!-- Sản phẩm mẫu -->
		        <c:forEach var="prod" items="${listProducts}">             
		             <div class="col">
		                <div class="card h-100 shadow-sm position-relative">
		                 <a href="productDetailController?productID=${prod.getProductID() }" >
		                    <img src="${prod.getPhoto() }" class="card-img-top" alt="Product Image">
		                    <c:forEach var="prom" items="${listPromotions}">
		                        <c:if test="${prod.getPromotionID() != 1 && prod.getPromotionID() == prom.getPromotionID() }">
		                            <div class="discount-badge">-${prom.getDiscount()}%</div>
		                        </c:if>
		                    </c:forEach>
		                    <c:if test="${prod.getStatus() == false}">
		                        <div class="sold-out-badge">Hết Hàng</div>
		                    </c:if>
		                    <div class="card-body">
		                        <h5 class="card-title">${prod.getName() }</h5>
		                        <p class="card-text">Giá: ${prod.getPrice() }00 VND</p>
		                        <a href="productDetailController?productID=${prod.getProductID() }" class="btn btn-secondary buy-btn">Mua Ngay</a>
		                    </div>
		                 </a>   
		                </div>
		            </div>
		            </c:forEach>
		    </div>
		</section>

      <%--   <!-- Sản Phẩm -->
        <section class="container mt-5">
            <h4 class="fw-bold mb-4 text-center">TẤT CẢ SẢN PHẨM</h4>
            <div class="row row-cols-1 row-cols-md-4 g-4">
                <!-- Sản phẩm mẫu -->
                <c:forEach var="prod" items="${listProducts}"> 				
     			 <div class="col">
				    <div class="card h-100 shadow-sm position-relative">
				     <a href="ProductDetailController?productID=${prod.getProductID() }" >
				     	<img src="${prod.getPhoto() }" class="card-img-top" alt="Product Image">
				        <c:forEach var="prom" items="${listPromotions}">
			    			<c:if test="${prod.getPromotionID() != 1 && prod.getPromotionID() == prom.getPromotionID() }">
				    			<div class="discount-badge">-${prom.getDiscount()}%</div>
				    		</c:if>
			    		</c:forEach>
			    		<c:if test="${prod.getStatus() == false}">
			    			<div class="sold-out-badge">Hết Hàng</div>
			    		</c:if>
				        <div class="card-body">
				            <h5 class="card-title">${prod.getName() }</h5>
				            <p class="card-text">Giá: ${prod.getPrice() } VND</p>
				            <a href="#" class="btn btn-secondary buy-btn">Mua Ngay</a>
				        </div>
				     </a>   
				    </div>
				</div>
		    	</c:forEach>

            </div>
        </section> --%>
    </main>

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


    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


