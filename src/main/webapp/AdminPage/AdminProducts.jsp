<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HighLight - ADMIN</title>
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- Custom CSS -->
	<style>
		body {
	      margin: 0;
		  font-family: Arial, sans-serif;
		}
		
		#wrapper {
		  display: flex;
		}
		
		#sidebar-wrapper {
		  position: fixed; /* Cố định sidebar */
		  top: 0; /* Canh trên cùng của màn hình */
		  left: 0; /* Canh bên trái của màn hình */
		  width: 250px; /* Độ rộng sidebar */
		  height: 100vh; /* Chiều cao toàn màn hình */
		  background-color: #343a40; /* Màu nền (dark) */
		  z-index: 1000; /* Đảm bảo sidebar luôn trên cùng */
		  overflow-y: auto; /* Hiển thị thanh cuộn nếu nội dung dài */
		  border-right: 1px solid #ddd; /* Đường viền phải */
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
		   margin-left: 250px; /* Dịch phần nội dung sang phải bằng độ rộng của sidebar */
		   padding: 20px;
		   width: calc(100% - 250px); /* Tính toán độ rộng chính xác của nội dung */
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
		.img-thumbnail{
			width : 100px;
			height : auto;
		}

	</style>
</head>
<body>
  <div class="d-flex" id="wrapper">
    <!-- Sidebar -->
    <div class="bg-dark border-end" id="sidebar-wrapper">
      <div class="sidebar-heading text-white text-center py-4">Admin Dashboard</div>
      <div class="list-group list-group-flush">
        <a href="AdminDashboardController" class="list-group-item list-group-item-action bg-dark text-white">Trang Chủ</a>
        <a href="AdminProductController" class="list-group-item list-group-item-action bg-white text-dark">Sản Phẩm</a>
        <a href="AdminCategoryController" class="list-group-item list-group-item-action bg-dark text-white">Loại Hàng</a>
        <a href="AdminPromotionController" class="list-group-item list-group-item-action bg-dark text-white">Khuyến Mãi</a>
        <a href="AdminAcceptController" class="list-group-item list-group-item-action bg-dark text-white">Duyệt Đơn Hàng</a>
        <a href="AdminHistoryController" class="list-group-item list-group-item-action bg-dark text-white">Lịch Sử</a>
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
		<c:if test="${Admin.getRole() == 'Admin'}">  
	      <div class="container-fluid px-4">
	        <h1 class="my-4">Danh Sách Sản Phẩm</h1>
			<div class="row">
			    <div class="col-md-8">
			        <div class="d-flex mb-4 align-items-center">
					    <form action="AdminProductController" method="post" class="w-100 d-flex gap-3">
					        <!-- Ô tìm kiếm -->
					        <input type="text" name="searchProducts" class="form-control" placeholder="Tìm kiếm sản phẩm" aria-label="Tìm kiếm sản phẩm" 
					        	value="${empty key ? '' : key}"
					        >
					        
					        <!-- Chọn loại hàng -->
					        <select name="category" class="form-select w-auto" aria-label="Tất cả loại hàng">
					            <option value="" selected>Tất cả loại hàng</option>
					            <c:forEach var="cate" items="${listCategories}">
					            	 <c:if test="${not empty cID and cate.getCategoryID() == cID}">
					            	 	<option selected value="${cate.getCategoryID()}">${cate.getName()}</option>
					            	 </c:if>
					            	 <c:if test="${cate.getCategoryID() != cID}">
					            	 	<option value="${cate.getCategoryID()}">${cate.getName()}</option>
					            	 </c:if>     
				        		</c:forEach>
					        </select>
					        
					        <!-- Nút tìm kiếm với chiều rộng lớn hơn -->
					        <button type="submit" class="btn btn-primary w-25">Tìm kiếm</button>
					    </form> 
					</div>
			    </div>
			    <div class="col-md-4">
			        <a href="AdminCreateProductController" class="btn btn-success">Thêm sản phẩm</a>
			    </div>
			</div>
	
	        <div class="card mb-4">
	          <div class="card-header bg-primary text-white">
	            <h5>Danh Sách Sản Phẩm</h5>
	          </div>
	          <div class="card-body">
	            <table class="table table-striped">
	              <thead>
	                <tr>
	                  <th>STT</th>
	                  <th>Ảnh</th>
	                  <th>Tên Sản Phẩm</th>
	                  <th>Danh Mục</th>
	                  <th>Giá</th>
	                  <th>Số Lượng</th>
	                  <th>Trạng Thái</th>
	                  <th>Hành Động</th>
	                </tr>
	              </thead>
	              <tbody>
	                <!-- Example Data -->
	                
	                <c:forEach var="prod" items="${listProducts}" varStatus="status">
			         	<tr>
		                  <td>${status.index + 1}</td>
		                  <td>
		                  	<img src=${prod.getPhoto() } alt="${prod.getName()}" class="img-thumbnail">
		                  </td>
		                  <td>${prod.getName()}</td>
		                  <td>
		                  		 <c:forEach var="cate" items="${listCategories}">
		                  		 	<c:if test="${cate.getCategoryID() == prod.getCategoryID()}">
					            	 	${cate.getName()}
					            	 </c:if>
		                  		 </c:forEach>
		                  </td>
		                  <td>${prod.getPrice()} $</td>
		                  <td>${prod.getStock()}</td>
	                	  <c:if test="${prod.getStatus() == true}"><td>Còn Hàng</td></c:if>
	                	  <c:if test="${prod.getStatus() == false}"><td>Hết Hàng</td></c:if> 	                  
		                  <td>
		                  	<a href="AdminEditProductController?ProductID=${prod.getProductID() }" class="btn btn-sm btn-primary">Chi Tiết</a>
		                    <a href="AdminEditProductController?ProductID=${prod.getProductID() }" class="btn btn-sm btn-warning">Sửa</a>
		                    <a href="AdminDeleteProductController?ProductID=${prod.getProductID() }" class="btn btn-sm btn-danger deleteProduct">Xóa</a>        
		                  </td>
	                	</tr>	
			         </c:forEach>  
	                
	              </tbody>
	            </table>
	            
	            
	            <!-- Pagination -->
				<nav>
				  <ul class="pagination justify-content-center">
				    <c:if test="${currentPage > 1}">
				      <li class="page-item">
				        <a class="page-link" href="AdminProductController?page=${currentPage - 1}&searchProducts=${key}&category=${cID}">Previous</a>
				      </li>
				    </c:if>
				
				    <c:forEach var="i" begin="1" end="${totalPages}">
				      <li class="page-item ${currentPage == i ? 'active' : ''}">
				        <a class="page-link" href="AdminProductController?page=${i}&searchProducts=${key}&category=${cID}">${i}</a>
				      </li>
				    </c:forEach>
				
				    <c:if test="${currentPage < totalPages}">
				      <li class="page-item">
				        <a class="page-link" href="AdminProductController?page=${currentPage + 1}&searchProducts=${key}&category=${cID}">Next</a>
				      </li>
				    </c:if>
				  </ul>
				</nav>
	             <!-- End Pagination -->
	          </div>
	        </div>
	      </div>
      </c:if>
      <c:if test="${Admin.getRole() != 'Admin'}">  
    		<div class="text-center">
			    <h1 class="display-1 text-danger">403</h1>
			    <p class="fs-4 text-secondary">Bạn không có quyền truy cập vào trang này.</p>
			    <a href="AdminDashboardController" class="btn btn-primary mt-3">Quay lại</a>
		  </div>
      </c:if>
    </div>
    <!-- /#page-content-wrapper -->
  </div>
  <!-- /#wrapper -->

  <!-- Bootstrap Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script>
	//Delete
	$(document).on("click", ".deleteProduct", function (e) {
	    e.preventDefault();
	    var link = $(this).prop("href");
	
	    if (!confirm('Có chắc chắn muốn xóa sách này không?')) {
	        return false;
	    }
	
	    $.ajax({
	        url: link,
	        type: 'POST',
	        success: function (response) {
	            if (response.success) {
	            	alert(response.message);
	            	 location.reload(); 	
	            } else {
	                alert(response.message);
	            }
	        },
	        error: function () {
	            alert("Đã xảy ra lỗi khi xóa sản phẩm.");
	        }
	    });
	    return false;
	}); 
	

  </script>
</body>
</html>
