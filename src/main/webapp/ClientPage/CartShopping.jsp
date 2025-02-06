<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <!-- Bootstrap 5 CSS -->
   	  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
	  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
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
        /* IMAGE */
   		.fixed-size-img-container {
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        height: 150px;
	        width: 150px;
	        overflow: hidden;
	    }
	
	    .fixed-size-img {
	        width: 100%;
	        height: auto;
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
	<!-- NAV -->
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
			  	<c:if test="${empty listProductinCart.size() }">
			  		0
			  	</c:if>
			  	<c:if test="${not empty listProductinCart.size() }">
			  		${listProductinCart.size() }
			  	</c:if>
			  </span>
		  </a>
	    </div>
	    
	  </nav>
	<!-- /#NAV -->
	
	<div>
        <button class="back-btn" onclick="history.back()">
            <i class="bi bi-arrow-left"></i> Quay lại
        </button>
        <h4 class="text-center">TRANG GIỎ HÀNG</h4>
    </div>
    
    <!-- SẢN PHẨM -->
 <section class="bg-light py-5">
    <div class="container">
    	<c:if test="${not empty CartNotification }">
    		${CartNotification }
    	</c:if>
    	<c:if test="${empty CartNotification }">
    	
    		<form id="cartForm" action="invoicesController" method="post">
			    <c:forEach var="item" items="${listProductinCart}" varStatus="status">
			        <!-- Bắt đầu một hàng mới sau mỗi 2 sản phẩm -->
			        <c:if test="${status.index % 2 == 0}">
			            <div class="row g-4 mb-4">
			        </c:if>
			        
			        <!-- Hiển thị sản phẩm -->
			        <div class="col-md-6">
			            <div class="card position-relative">
			                <div class="row g-0">
			                    <!-- Image Column -->
			                    <div class="col-md-4">
			                        <img src="${item.getPhoto() }" class="img-fluid h-100" alt="Product" style="object-fit: cover;">
			                    </div>
			                    
			                    <!-- Content Column -->
			                    <div class="col-md-8">
			                        <div class="card-body">
			                            <!-- Nút xóa ở trên cùng bên phải -->
			                            <a class="btn btn-danger btn-sm position-absolute top-0 end-0 m-2 deleteProduct" 
			                                href="shoppingCartDeleteController?cartDetailID=${item.getCartDetailID()}">
			                                Xóa
			                            </a>
			                            
			                            <h5 class="card-title">${item.getName()}</h5>
			                            
			                            <div class="d-flex flex-column align-items-start">
			                                <c:if test="${item.getNewPrice() != item.getPrice()}">
			                                    <div class="text-muted" style="font-size: 1.5rem;">
			                                        <del class="text-danger">${item.getPrice()}00 VND</del>
			                                    </div>
			                                    <div class="fw-bold text-success"  style="font-size: 2rem;">
			                                        ${item.getNewPrice()}00 VND
			                                    </div>
			                                </c:if>
			                                
			                                <c:if test="${item.getNewPrice() == item.getPrice()}">
			                                    <div class="fw-bold text-success" style="font-size: 2rem;">
			                                        ${item.getPrice()}00 VND
			                                    </div>
			                                </c:if>
			                            </div>
			                            
			                            <p class="card-text">Số lượng:
			                                <input type="number" name="quantity4" min="1" max="100" 
			                                       class="form-control d-inline-block" style="width: 60px;" value="${item.getQuantity() }" 
			                                       onchange="handleInputChange(event)">
			                            </p>
			                            
			                            <!-- Size and Checkbox Row -->
			                            <div class="d-flex align-items-center justify-content-between">
			                                <!-- Size Selector -->
			                                <div class="me-auto">
			                                    <label for="size4" class="form-label mb-0 me-2">Size:</label>
			                                    <select name="size4" id="size4" class="form-select d-inline-block" style="width: 100px;" onchange="handleInputChange(event)">
			                                        <option value="${item.getSize() }" selected>${item.getSize() }</option>
			                                        <option value="S">S</option>
			                                        <option value="M">M</option>
			                                        <option value="L">L</option>
			                                        <option value="XL">XL</option>
			                                    </select>
			                                </div>
			    
			                                <!-- Checkbox -->
			                                <div class="form-check ms-auto">
			                                    <input type="checkbox" name="selectProduct" value="${item.getCartDetailID()}"
			                                           class="form-check-input" id="selectProduct${item.getCartDetailID()}" 
			                                           data-price="${item.getNewPrice() != null ? item.getNewPrice().intValue()*item.getQuantity() : item.getPrice().intValue()*item.getQuantity()}" 
			                                           checked onchange="updateTotalPrice();">
			                                    <label class="form-check-label" for="selectProduct${item.getCartDetailID()}"></label>
			                                </div>
			                                
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			        </div>
			        
			        <!-- Kết thúc hàng sau mỗi 2 sản phẩm -->
			        <c:if test="${status.index % 2 == 1}">
			            </div>
			        </c:if>
			    </c:forEach>
			    
			    <!-- Thêm input để lưu các cartDetailID đã chọn -->
			    <input type="hidden" id="selectedCartDetailIDs" name="selectedCartDetailIDs">
			    
			    <!-- Tổng thanh toán -->
			    <div class="mt-4">
			        <p class="text-end fw-bold">Tổng số tiền: <span id="totalPrice" class="text-success">0 VND</span></p>
			        <button type="submit" class="btn btn-success float-end" onclick="submitForm(event)">Xác nhận thanh toán</button>
			    </div>
			</form>
	        
    	</c:if>
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
    
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
  		//JQUERY cập nhật giá và số lượng
  		$(document).ready(function() {
		    // Hàm xử lý cập nhật
		    function updateCart(cartDetailID, newQuantity, newSize) {
		      $.ajax({
		        url: 'shoppingCartController',
		        method: 'POST',
		        data: {
		          cartDetailID: cartDetailID,
		          quantity: newQuantity,
		          size: newSize
		        },
		        success: function(response) {
		          console.log('Cập nhật thành công:', response);
				  if(response.success == true){
					  location.reload(); 
				  }
		        },
		        error: function(xhr, status, error) {
		          console.error('Cập nhật thất bại:', error);
		        }
		      });
		    }
		
		    // Lắng nghe sự kiện thay đổi số lượng
		    $('input[name="quantity4"]').on('change', function() {
		      let cartDetailID = $(this).closest('.card').find('input[type="checkbox"]').val();
		      let newQuantity = $(this).val();
		      let newSize = $(this).closest('.card').find('select[name="size4"]').val();
		      updateCart(cartDetailID, newQuantity, newSize);
		    });
		
		    // Lắng nghe sự kiện thay đổi size
		    $('select[name="size4"]').on('change', function() {
		      let cartDetailID = $(this).closest('.card').find('input[type="checkbox"]').val();
		      let newQuantity = $(this).closest('.card').find('input[name="quantity4"]').val();
		      let newSize = $(this).val();
		      updateCart(cartDetailID, newQuantity, newSize);
		    });
		  });

  		
        //JQUERY xóa 1 sản phẩm ra khỏi giỏ hàng
		$(document).on("click", ".deleteProduct", function (e) {
		    e.preventDefault();
	
		    // Lấy đường dẫn xóa từ thuộc tính href
		    const link = $(this).prop("href");
		    if (!link) {
		        alert("Không tìm thấy đường dẫn để xóa.");
		        return;
		    }
	
		    // Hộp thoại xác nhận
		    if (!confirm("Bạn có chắc chắn muốn xóa sản phẩm này ra khỏi giỏ hàng ?")) {
		        return;
		    }
	
		    $.ajax({
		        url: link,
		        type: "POST",
		        success: function (response) {
		            if (response && response.success) {
		                alert(response.message);
		                location.reload();
		            } else {
		                alert(response.message);
		            }
		        },
		        error: function () {
		            alert("Đã xảy ra lỗi không mong muốn khi xóa sản phẩm ra khỏi giỏ.");
		        }
		    });
		    updateTotalPrice();
		});

	    $(document).ready(function() {
	        // Hàm tính tổng tiền
	        function updateTotalPrice() {
	            let totalPrice = 0;
	
	            // Lấy tất cả các checkbox được chọn
	            $('input[name="selectProduct"]:checked').each(function() {
	                const price = parseFloat($(this).data('price')) * 1000;
	                totalPrice += price;
	            });
	
	            console.log(totalPrice);
	            
	            // Hiển thị tổng tiền với định dạng VND
	            $('#totalPrice').text(totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' VND');
	        }
	
	        // Hiển thị tổng tiền ban đầu
	        updateTotalPrice();
	
	        // Cập nhật tổng tiền khi checkbox thay đổi
	        $('input[name="selectProduct"]').on('change', function() {
	            updateTotalPrice();
	        });
	    });
	  
		// Hàm gọi khi người dùng nhấn nút submit
		function submitForm(event) {
		    // Ngăn chặn form gửi trực tiếp để chúng ta có thể xử lý
		    event.preventDefault();
	
		    // Lấy tất cả các cartDetailID đã chọn
		    const selectedCartDetailIDs = [];
		    const checkboxes = document.querySelectorAll('input[name="selectProduct"]:checked');
		    checkboxes.forEach(checkbox => {
		        selectedCartDetailIDs.push(checkbox.value); // Thêm cartDetailID vào mảng
		    });
	
		    // Gán các cartDetailID vào input hidden
		    const selectedCartDetailIDsInput = document.getElementById('selectedCartDetailIDs');
		    selectedCartDetailIDsInput.value = selectedCartDetailIDs.join(","); // Chuyển thành chuỗi phân cách bằng dấu phẩy
	
		    // Sau khi gán giá trị vào input hidden, submit form
		    document.getElementById('cartForm').submit();
		}
    
    </script>

</body>
</html>