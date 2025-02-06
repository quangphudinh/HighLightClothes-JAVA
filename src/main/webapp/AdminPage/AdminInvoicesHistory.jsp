<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HighLight - ADMIN</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	body {
	      margin: 0;
		  font-family: Arial, sans-serif;
		}
		
		#wrapper {
		  display: flex;
		}
		
		#sidebar-wrapper {
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 250px;
		  height: 100vh;
		  background-color: #343a40;
		  z-index: 1000;
		  overflow-y: auto;
		  border-right: 1px solid #ddd;
		}
		
		.sidebar-heading {
		  font-size: 1.5rem;
		  font-weight: bold;
		  text-align: center;
		  color: #fff;
		  padding: 20px;
		  border-bottom: 1px solid #fff;
		}
		.list-group-item {
		  border: none;
		  padding: 15px 20px;
		  transition: all 0.3s ease-in-out;
		}
		.list-group-item:hover {
		  background-color: #495057;
		  color: #fff;
		}
		.list-group-item.bg-white {
		  background-color: #fff;
		  color: #000;
		}
		#page-content-wrapper {
		   margin-left: 250px;
		   padding: 20px;
		   width: calc(100% - 250px);
		}
		@media (max-width: 768px) {
		  #sidebar-wrapper {
		    width: 200px;
		  }
		
		  #page-content-wrapper {
		    margin-left: 200px;
		    width: calc(100% - 200px);
		  }
		  
		 /*  .product-img{
	        width: 100px;
	        height: 100px;
	        object-fit: cover; /* Đảm bảo ảnh không bị méo */
	    }
		 */
</style>
</head>
<body>
	<div class="d-flex" id="wrapper">
    <!-- Sidebar -->
    <div class="bg-dark border-end" id="sidebar-wrapper">
      <div class="sidebar-heading text-white text-center py-4">Admin Dashboard</div>
      <div class="list-group list-group-flush">
        <a href="AdminDashboardController" class="list-group-item list-group-item-action bg-dark text-white">Trang Chủ</a>
        <a href="AdminProductController" class="list-group-item list-group-item-action bg-dark text-white">Sản Phẩm</a>
        <a href="AdminCategoryController" class="list-group-item list-group-item-action bg-dark text-white">Loại Hàng</a>
        <a href="AdminPromotionController" class="list-group-item list-group-item-action bg-dark text-white">Khuyến Mãi</a>
        <a href="AdminAcceptController" class="list-group-item list-group-item-action  bg-dark text-white">Duyệt Đơn Hàng</a>
        <a href="AdminHistoryController" class="list-group-item list-group-item-action  bg-white text-dark">Lịch Sử</a>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper" class="w-100">
      <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
        <div class="container-fluid">
           <div class="container-fluid">
         
          <c:if test="${not empty Admin}">
			    <div class="container mt-3">
			        <div class="d-flex justify-content-between align-items-center">
			            <!-- Hiển thị tên Admin -->
			            <h5>Welcome, ${Admin.getAdminName()}!</h5>
			            
			            <!-- Nút Đăng xuất -->
			            <form action="AdminLogoutController" method="post" class="d-inline">
			                <button type="submit" class="btn btn-danger">Đăng Xuất</button>
			            </form>
			        </div>
			    </div>
			</c:if>
			<c:if test="${empty Admin}">
			    <script>
			        window.location.href = 'AdminLoginController';
			    </script>
			</c:if>
        </div>
        </div>
      </nav>
    	
    <div class="container mt-5">
    <h1 class="text-center mb-4">LỊCH SỬ DUYỆT HÀNG</h1>

        <!-- Orders Table -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>STT</th>
                        <th>Mã Đơn Hàng</th>
                        <th>Tên Khách Hàng</th>
                        <th>Ngày Đặt</th>
                        <th>Ngày Kết Thúc</th>
                        <th>Trạng Thái</th>
                        <th>Tổng Tiền</th>
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="lo" items="${listOrders}" varStatus="status">
                		<!-- Order -->
                		<tr id="${lo.getInvoiceID() }">
	                        <td>${status.index + 1}</td>
	                        <td>${lo.getInvoiceID() }</td>
	                        <td>${lo.getCustomerName() }</td>
	                        <td>${lo.getOrderDate() }</td>
	                        <td>${lo.getFinishDate() }</td>
	                        <td>
	                        	 <c:choose>
							        <c:when test="${lo.getStatus() == 'Canceled'}">
							            <span class="badge bg-danger">Canceled</span>
							        </c:when>
							        <c:when test="${lo.getStatus() == 'Accepted'}">
							            <span class="badge bg-success">Accepted</span>
							        </c:when>
							        <c:otherwise>
							            <span class="badge bg-secondary">Unknown</span>
							        </c:otherwise>
							    </c:choose>
                        	</td>
	                        <td><fmt:formatNumber value="${lo.getTotal().intValue()*1000}" type="currency" currencySymbol="₫" /></td>
	                        
	                        <td>
	                            <button class="btn btn-info btn-sm" data-bs-toggle="collapse" data-bs-target="#${lo.getInvoiceID() }s">
	                                Chi Tiết
	                            </button>   
	                        </td>
	                    </tr>
	                    <!-- Order Details -->
	                    <tr class="collapse" id="${lo.getInvoiceID() }s">
	                        <td colspan="7">
	                            <div class="p-3">
	                                <h5>Order Details - ${lo.getInvoiceID() }</h5>
	                                <table class="table table-bordered">
	                                    <thead class="table-light">
	                                        <tr>
	                                            <th>Chọn</th>
	                                            <th>Ảnh</th>
	                                            <th>Mã Sản Phẩm</th>
	                                            <th>Tên Sản Phẩm</th>
	                                            <th>Số Lượng</th>
	                                            <th>Kích Thước</th>
	                                            <th>Đơn Giá</th>
	                                            <th>Thành Tiền</th>
	                                            <th>Trạng Thái</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                    	<c:forEach var="loDt" items="${listOrderDetails}">
	                                    		<c:if test="${lo.getInvoiceID() ==  loDt.getInvoiceID()}">
	                                    			<tr>
			                                            <td><input type="checkbox" class="product-checkbox" checked
			                                            	data-order-id="${loDt.getInvoiceID() }" data-product-id="${loDt.getProductId() }">
		                                            	</td>
		                                             	<td>
		                                             		<img src="${loDt.getImage() }" alt="${loDt.getProductName() }" 
			                                            	 class="img-thumbnail" style="width: 100px; height: 100px;object-fit: cover;">
		                                            	</td>
			                                            <td>${loDt.getProductId() }</td>
			                                            <td>${loDt.getProductName() }</td>
			                                            <td>${loDt.getQuantity() }</td>
			                                            <td>${loDt.getSize() }</td>
			                                            <td><fmt:formatNumber value="${loDt.getPrice()*1000 }" type="currency" currencySymbol="₫" /></td>
			                                            <td><fmt:formatNumber value="${loDt.getPrice()*loDt.getQuantity()*1000 }" type="currency" currencySymbol="₫" /></td>
			                                            <td>
				                                            <c:choose>
														        <c:when test="${loDt.getStatus() == 'Canceled'}">
														            <span class="badge bg-danger">Canceled</span>
														        </c:when>
														        <c:when test="${loDt.getStatus() == 'Accepted'}">
														            <span class="badge bg-success">Accepted</span>
														        </c:when>
														        <c:otherwise>
														            <span class="badge bg-secondary">Unknown</span>
														        </c:otherwise>
														    </c:choose>
			                                            </td>
			                                        </tr>
	                                    		</c:if>
	                                    	</c:forEach>          
	                                    </tbody>
	                                </table>           
	                            </div>
	                        </td>
	                    </tr>
                	</c:forEach>              
                </tbody>
                
            </table>
        </div>
    </div>
</div>
</div>
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JS -->
    <script>
	    $(document).ready(function() {
	        $(".cancel-order").click(function(e) {
	            e.preventDefault();
	            var id = $(this).data('order-id');
	            
	            if (confirm("Bạn chắc chắn muốn hủy đơn hàng này?")) {
		            $.ajax({
		                url: "AdminAcceptController",  // Địa chỉ controller
		                type: "POST",                  // Phương thức GET
		                data: { Id: id },             // Dữ liệu truyền vào
		                success: function(response) {
		                    alert(response.message);
		                    location.reload(); 
		                },
		                error: function(xhr, status, error) {
		                    alert("Đã xảy ra lỗi khi hủy đơn hàng.");
		                }
		            });
	            }
	        });
	    });
    </script>
</body>
</html>