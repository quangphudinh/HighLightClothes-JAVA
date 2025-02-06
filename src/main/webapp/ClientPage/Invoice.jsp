<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đặt hàng của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
    	/* ORDER */
        .order-item {
            border-radius: 8px;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            margin-bottom: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .order-item:hover {
            background-color: #f1f3f5;
        }
        .order-item .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .order-item .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .order-details {
            background-color: #ffffff;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .order-item .total-price {
            font-weight: bold;
            color: #28a745;
        }
        .order-item .order-id {
            font-size: 1.2rem;
            color: #007bff;
        }
        .order-item .order-status {
            font-weight: bold;
        }
        .order-item .order-status.pending {
            color: #ffc107;
        }
        .order-item .order-status.approved {
            color: #28a745;
        }
        .order-item .order-status.shipping {
            color: #17a2b8;
        }
        .order-item .order-status.delivered {
            color: #6c757d;
        }
        .list-group-item {
            background-color: transparent;
            border: none;
        }
        .order-item .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
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
		          <a class="nav-link active" href="invoicesController">Lịch Sử</a>
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

    <div class="container mt-5">
        <h2 class="mb-4 text-center text-primary">Lịch sử đặt hàng của tôi</h2>
        
      	 <c:forEach var="i" items="${listInID}">
      	 	<c:set var="TotalMounent" value="0" />
      	 	<c:forEach var="j" items="${listInvoiceDetails}">
      	 		<c:if test="${i == j.getInvoiceID() }">
      	 			<c:set var="TotalMounent" value="${TotalMounent + j.getPrice().intValue()*j.getQuantity()*1000}" />
      	 			<c:set var="dateCreate" value="${j.getCreateAt()}"/>
      	 			<c:set var="Status" value="${j.getTtdh()}"/>
      	 		</c:if>
      	 	</c:forEach>	
        				
   			<!-- Đơn hàng 1 -->
            <div class="order-item">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="order-id">Đơn hàng #${i}</h5>
                    <p>Ngày đặt: ${dateCreate}</p>
                </div>
                <p>Tổng tiền: <span class="total-price">
                	<fmt:formatNumber value="${TotalMounent}" type="currency" currencySymbol="₫" />
                </span></p>
                <p class="order-status">Trạng thái:
                	<c:choose>
					        <c:when test="${Status == 'Canceled'}">
					            <span class="badge bg-danger">Đơn hàng bị hủy</span>
					        </c:when>
					        <c:when test="${Status == 'Accepted'}">
					            <span class="badge bg-success">Đã được xác nhận</span>
					        </c:when>
					        <c:when test="${Status == 'Pending'}">
					             <span class="badge bg-warning">Đang chờ xác nhận</span>
					        </c:when>
				        <c:otherwise>
				            <span class="badge bg-secondary">Đơn hàng lỗi</span>
				        </c:otherwise>
				    </c:choose>
                </p>
                
                
                <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#${i }" aria-expanded="false" aria-controls="orderDetails1">
                    Xem chi tiết
                </button>
                
                <div class="collapse mt-3 order-details" id="${i}">
					    <h6 class="mb-3">Chi tiết đơn hàng</h6>
					    <table class="table table-bordered">
					        <thead>
					            <tr>
					                <th>Sản phẩm</th>
					                <th>Số lượng</th>
					                <th>Đơn giá</th>
					                <th>Thành tiền</th>
					                <th>Trạng thái</th>
					            </tr>
					        </thead>
					        <tbody>
					            <c:forEach var="item" items="${listInvoiceDetails}">
					                <c:if test="${i == item.getInvoiceID()}">
					                    <tr>
					                        <td>
					                            <img src="${item.getPhoto()}" alt="${item.getName()}" class="product-image me-3" style="width: 50px; height: 50px;">
					                            ${item.getName()}
					                        </td>
					                        <td>${item.getQuantity()}</td>
					                        <td><fmt:formatNumber value="${item.getPrice().intValue() * 1000}" type="currency" currencySymbol="₫" /></td>
					                        <td><fmt:formatNumber value="${item.getPrice().intValue() * item.getQuantity() * 1000}" type="currency" currencySymbol="₫" /></td>
					                        <td>
					                        	<c:choose>
												        <c:when test="${item.getStatus() == 'Canceled'}">
												            <span class="badge bg-danger">Đơn hàng bị hủy</span>
												        </c:when>
												        <c:when test="${item.getStatus() == 'Accepted'}">
												            <span class="badge bg-success">Đã được xác nhận</span>
												        </c:when>
												        <c:when test="${item.getStatus() == 'Pending'}">
												            <span class="badge bg-warning">Đang chờ xác nhận</span>      
												        </c:when>
											        <c:otherwise>
											            <span class="badge bg-secondary">Đơn hàng lỗi</span>
											        </c:otherwise>
											    </c:choose>
											</td>
					                    </tr>
					                </c:if>
					            </c:forEach>
					            <tr>
					                <td colspan="3">Giao hàng: Giao hàng nhanh</td>
					                <td colspan="2">100.000 ₫</td>
					            </tr>
					            <tr>
					                <td colspan="3"><strong>Tổng tiền</strong></td>
					                <td colspan="2"><strong><fmt:formatNumber value="${TotalMounent}" type="currency" currencySymbol="₫" /></strong></td>
					            </tr>
					        </tbody>
					    </table>
					</div>
            </div>		
        	</c:forEach>
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
 	

    <!-- Bootstrap 5 JavaScript and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>