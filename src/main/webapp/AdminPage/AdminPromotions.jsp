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
        <a href="AdminProductController" class="list-group-item list-group-item-action bg-dark text-white">Sản Phẩm</a>
        <a href="AdminCategoryController" class="list-group-item list-group-item-action bg-dark text-white">Loại Hàng</a>
        <a href="AdminPromotionController" class="list-group-item list-group-item-action bg-white text-dark">Khuyến Mãi</a>
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
	        <p class="my-4">
	        	<c:if test="${not empty sessionScope.notificationPromotion}">
	            	<div class="container mt-5">
				        <!-- Thẻ thông báo -->
				        <div class="alert alert-success alert-dismissible fade show" role="alert">
				            <c:out value="${sessionScope.notificationPromotion}" />
				            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				            <c:remove var="notificationCategory" scope="session" />
				        </div>
				    </div>
				</c:if>
	        </p>
			
			<!-- Thêm mới khuyến mãi -->
			<div class="card mb-4">
			  <div class="card-header bg-primary text-white">
			    <h5>Thêm Mới Khuyến Mãi</h5>
			  </div>
			  <div class="card-body">
			    <form action="AdminCreatePromotionController" method="post">
			      <div class="mb-3">
			        <label for="promotionName" class="form-label">Tên Khuyến Mãi</label>
			        <input type="text" id="promotionName" name="promotionName" class="form-control" placeholder="Nhập tên khuyến mãi" required>
			      </div>
			      <div class="mb-3">
			        <label for="discount" class="form-label">Giảm Giá (%)</label>
			        <input type="number" id="discount" name="discount" class="form-control" placeholder="Nhập tỷ lệ giảm giá" min="0" max="100" required>
			      </div>
			      <div class="row">
			        <!-- Ngày Bắt Đầu -->
			        <div class="col-md-6 mb-3">
			          <label for="startDate" class="form-label">Ngày Bắt Đầu</label>
			          <input type="date" id="startDate" name="startDate" class="form-control" required>
			        </div>
			        <!-- Ngày Kết Thúc -->
			        <div class="col-md-6 mb-3">
			          <label for="endDate" class="form-label">Ngày Kết Thúc</label>
			          <input type="date" id="endDate" name="endDate" class="form-control" required>
			        </div>
			      </div>
			      <div class="text-end">
			        <button type="submit" class="btn btn-success">Thêm Mới</button>
			        <button type="reset" class="btn btn-secondary border">Nhập lại</button>
			      </div>
			    </form>
			  </div>
			</div>
			<!-- /#Thêm mới khuyến mãi -->
	
			<div class="row">
			    <div class="col-md-12">
			        <form action="AdminPromotionController" method="post" class="d-flex justify-content-between align-items-center gap-3">
			            <!-- Ô tìm kiếm -->
			            <div class="d-flex align-items-center gap-2 flex-grow-1 mb-2">
			                <input type="text" id="searchPromotions" name="searchPromotions" class="form-control" placeholder="Tìm kiếm loại hàng" 
			                    value="${empty key ? '' : key}">
			            </div>
			
			            <!-- Ô nhập ngày bắt đầu -->
			            <div class="d-flex align-items-center gap-2 flex-grow-1 mb-2">
			                <label for="startDate" class="form-label mb-0">Từ:</label>
			                <input type="date" id="startDate" name="startDate" class="form-control" 
			                    value="${empty startDate ? '' : startDate}">
			            </div>
			
			            <!-- Ô nhập ngày kết thúc -->
			            <div class="d-flex align-items-center gap-2 flex-grow-1 mb-2">
			                <label for="endDate" class="form-label mb-0">Đến:</label>
			                <input type="date" id="endDate" name="endDate" class="form-control" 
			                    value="${empty endDate ? '' : endDate}">
			            </div>
			
			            <!-- Nút tìm kiếm -->
			            <div class="ms-auto mb-2">
			                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
			            </div>
			        </form>
			    </div>
			</div>
	
	        <div class="card mb-4">
	          <div class="card-header bg-primary text-white">
	            <h5>Danh Sách Khuyến Mãi</h5>
	          </div>
	          <div class="card-body">
	            <table class="table table-striped">
	              <thead>
	                <tr>
	                  <th>STT</th>
	                  <th>Tên Khuyến Mãi</th>
	                  <th>Chiết Khấu</th>
	                  <th>Ngày Bắt Đầu</th>
	                  <th>Ngày Kết Thúc</th>
	                  <th>Trạng Thái</th>
	                  <th>Hành Động</th>
	                </tr>
	              </thead>
	              <tbody>
	                <c:forEach var="prom" items="${listPromotions}" varStatus="status">
	                  <tr>
	                    <td>${status.index + 1}</td>
	                    <td>${prom.getName()}</td>
	                    <td>${prom.getDiscount()}%</td>
	                    <td>${prom.getStartDay()}</td>
	                    <td>${prom.getEndDay()}</td>
	                    <td>                  	
	                    	<c:if test="${currentDate.after(prom.getEndDay())}">
	                    		 <span style="color: red;">Dừng Hoạt động</span>
	                    	</c:if>
	                   		<c:if test="${currentDate.before(prom.getEndDay())}">
	                   		
						        <span style="color: green;">Hoạt động</span>
						    </c:if>
	                    </td>
	                    <td>
	                     	<button class="btn btn-sm btn-warning editPromotion" 
	                     		data-name="${prom.getName()}" 
	                     		data-discount="${prom.getDiscount()}"
	                     		data-start="${prom.getStartDay()}"
	                     		data-end="${prom.getEndDay()}"
	                     		data-id="${prom.getPromotionID()}" 
	                     		>
	                            <span class="glyphicon glyphicon-pencil"></span> Sửa
	                        </button>
	                        <a href="AdminDeletePromotionController?promotionID=${prom.getPromotionID()}" class="btn btn-sm btn-danger deletePromotion">Xóa</a> 
	                    </td>
	                  </tr>
	                </c:forEach>
	              </tbody>
	            </table>
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
  
	<!-- MODAL -->
	<div class="modal fade" id="editPromotionModal" tabindex="-1" aria-labelledby="editPromotionModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg"> <!-- Tăng kích thước modal -->
	    <div class="modal-content shadow-lg border-0">
	      <!-- Modal Header -->
	      <div class="modal-header bg-primary text-white">
	        <h5 class="modal-title" id="editPromotionModalLabel">
	          <i class="bi bi-pencil-square"></i> Chỉnh Sửa Khuyến Mãi
	        </h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	
	      <!-- Modal Body -->
	      <div class="modal-body bg-light">
	        <form id="editPromotionForm">
	          <!-- Promotion ID (Ẩn) -->
	          <input type="hidden" class="form-control" id="promotionID" name="promotionID" readonly>
	
	          <!-- Tên Promotion -->
	          <div class="mb-4">
	            <label for="promotionName" class="form-label fw-bold">Tên Khuyến Mãi:</label>
	            <input type="text" class="form-control form-control-lg border-primary" id="promotionName" name="promotionName" placeholder="Nhập tên khuyến mãi..." required>
	            <input type="hidden" name="promotionOldName" id="promotionOldName">
	          </div>
	
	          <!-- Discount -->
	          <div class="mb-4">
	            <label for="discount" class="form-label fw-bold">Discount (%):</label>
	            <input type="number" min="0" max="100" class="form-control border-primary" id="discount" name="discount" placeholder="Nhập discount..." required>
	          </div>
	
	          <!-- Start Date & End Date trên cùng một hàng -->
	          <div class="row mb-4">
	            <div class="col-md-6">
	              <label for="startDate" class="form-label fw-bold">Ngày bắt đầu:</label>
	              <input type="date" class="form-control border-primary" id="startDate" name="startDate" required>
	            </div>
	            <div class="col-md-6">
	              <label for="endDate" class="form-label fw-bold">Ngày kết thúc:</label>
	              <input type="date" class="form-control border-primary" id="endDate" name="endDate" required>
	            </div>
	          </div>
	
	          <!-- Buttons -->
	          <div class="text-end">
	            <button type="submit" class="btn btn-success">
	              <i class="bi bi-check-circle"></i> Lưu thay đổi
	            </button>
	            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
	              <i class="bi bi-x-circle"></i> Hủy
	            </button>
	          </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- /#MODAL -->

  <!-- Bootstrap Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script>
	//
	document.querySelectorAll("form").forEach(function(form) {
		form.addEventListener("submit", function(e) {
			const startDate = form.querySelector("#startDate").value;
			const endDate = form.querySelector("#endDate").value;
		
		    if (new Date(startDate) > new Date(endDate)) {
		        alert("Ngày kết thúc không thể sớm hơn ngày bắt đầu.");
		        e.preventDefault(); // Ngừng gửi form
		    }
		});
	});
	/* document.querySelector("form").addEventListener("submit", function(e) {
	    const startDate = document.getElementById("startDate").value;
	    const endDate = document.getElementById("endDate").value;
	
	    if (new Date(startDate) > new Date(endDate)) {
	        alert("Ngày kết thúc không thể sớm hơn ngày bắt đầu.");
	        e.preventDefault(); // Ngừng gửi form
	    }
	}); */
	
	//EditPromotion
	$(document).ready(function () {
	    $(".editPromotion").click(function (e) {
	        e.preventDefault();
	        var ID = $(this).data("id");
	        var name = $(this).data("name");
	        var discount = $(this).data("discount");
	        var start = $(this).data("start");
	        var end = $(this).data("end");

	        // Điền dữ liệu vào form chỉnh sửa
	        $("#editPromotionModal #promotionID").val(ID);
	        $("#editPromotionModal #promotionName").val(name);
	        $("#editPromotionModal #promotionOldName").val(name);
	        $("#editPromotionModal #discount").val(discount);
	        $("#editPromotionModal #startDate").val(start);
	        $("#editPromotionModal #endDate").val(end);
	        
	        // Hiển thị modal chỉnh sửa
	        $("#editPromotionModal").modal("show");
	    });

	    // Thực hiện lưu thay đổi khi form được submit
	    $("#editPromotionForm").submit(function (e) {
	        e.preventDefault();
	        var formData = $(this).serialize();
	        $.ajax({
	            url: "AdminEditPromotionController", 
	            type: "POST",
	            data: formData,
	            success: function(response) {
                    if (response.success) {
                        alert(response.message);  // Thông báo khi thành công
                        $("#editPromotionModal").modal("hide");
                        location.reload(); 
                    } else {
                        alert(response.message);  // Thông báo khi lỗi
                    }
	            },
	            error: function() {
	                alert("Có lỗi xảy ra trong quá trình cập nhật!");
	            }
	        });
	    });
	});    

	// DeletePromotion
	$(document).on("click", ".deletePromotion", function (e) {
	    e.preventDefault();

	    // Lấy đường dẫn xóa từ thuộc tính href
	    const link = $(this).prop("href");
	    if (!link) {
	        alert("Không tìm thấy đường dẫn để xóa.");
	        return;
	    }

	    // Hộp thoại xác nhận
	    if (!confirm("Bạn có chắc chắn muốn xóa KHUYẾN MÃI này không?")) {
	        return;
	    }

	    $.ajax({
	        url: link,
	        type: "POST",
	        success: function (response) {
	            if (response && response.success) {
	                alert(response.message || "Xóa KHUYẾN MÃI thành công!");
	                location.reload();
	            } else {
	                alert(response.message || "Không thể xóa KHUYẾN MÃI này.");
	            }
	        },
	        error: function () {
	            alert("Đã xảy ra lỗi không mong muốn khi xóa KHUYẾN MÃI.");
	        }
	    });
	});

	
  </script>
</body>
</html>