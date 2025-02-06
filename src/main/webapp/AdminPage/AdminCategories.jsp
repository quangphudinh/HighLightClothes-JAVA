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
        <a href="AdminCategoryController" class="list-group-item list-group-item-action bg-white text-dark">Loại Hàng</a>
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
        <p class="my-4">
        	<c:if test="${not empty sessionScope.notificationCategory}">
            	<div class="container mt-5">
			        <!-- Thẻ thông báo -->
			        <div class="alert alert-success alert-dismissible fade show" role="alert">
			            <c:out value="${sessionScope.notificationCategory}" />
			            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			            <c:remove var="notificationCategory" scope="session" />
			        </div>
			    </div>
			</c:if>
        </p>
		
		<!-- Thêm mới loại hàng -->
        <div class="card mb-4">
          <div class="card-header bg-primary text-white">
            <h5>Thêm Mới Loại Hàng</h5>
          </div>
          <div class="card-body">
            <form action="AdminCreateCategoryController" method="post">
              <div class="mb-3">
                <label for="categoryName" class="form-label">Tên Loại Hàng</label>
                <input type="text" id="categoryName" name="categoryName" class="form-control" placeholder="Nhập tên loại hàng" required>
              </div>
              <div class="mb-3">
                <label for="categoryDescription" class="form-label">Mô Tả Loại Hàng</label>
                <textarea id="categoryDescription" name="categoryDescription" class="form-control" rows="3" placeholder="Nhập mô tả loại hàng"></textarea>
              </div>
              <div class="text-end">
                <button type="submit" class="btn btn-success">Thêm Mới</button>
                <button type="reset" class="btn btn-secondary border">Nhập lại</button>
              </div>
            </form>
          </div>
        </div>
        <!-- /#Thêm mới loại hàng -->

		<div class="row">
		    <div class="col-md-8">
		        <div class="d-flex mb-4 align-items-center">
				    <form action="AdminCategoryController" method="post" class="w-100 d-flex gap-3">
				        <!-- Ô tìm kiếm -->
				        <input type="text" name="searchCategories" class="form-control" placeholder="Tìm kiếm loại hàng" aria-label="Tìm kiếm loại hàng" 
				        	value="${empty key ? '' : key}">   
				        <!-- Nút tìm kiếm với chiều rộng lớn hơn -->
				        <button type="submit" class="btn btn-primary w-25">Tìm kiếm</button>
				    </form> 
				</div>
		    </div>
		</div>

        <div class="card mb-4">
          <div class="card-header bg-primary text-white">
            <h5>Danh Sách Loại Hàng</h5>
          </div>
          <div class="card-body">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>STT</th>
                  <th>Tên Loại Hàng</th>
                  <th>Mô Tả</th>
                  <th>Hành Động</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="cate" items="${listCategories}" varStatus="status">
                  <tr>
                    <td>${status.index + 1}</td>
                    <td>${cate.getName()}</td>
                    <td>${cate.getDescription()}</td>
                    <td>
                     	<button class="btn btn-sm btn-warning editCategory" 
                     		data-name="${cate.getName()}" 
                     		data-description="${cate.getDescription()}"
                     		data-id="${cate.getCategoryID()}" 
                     		>
                            <span class="glyphicon glyphicon-pencil"></span> Sửa
                        </button>
                        <a href="AdminDeleteCategoryController?categoryID=${cate.getCategoryID()}" class="btn btn-sm btn-danger deleteCategory">Xóa</a> 
                      <%-- <a href="AdminEditCategoryController?CategoryID=${cate.getCategoryID()}" class="btn btn-sm btn-warning">Sửa</a>
                      <a href="AdminDeleteCategoryController?CategoryID=${cate.getCategoryID()}" class="btn btn-sm btn-danger deleteCategory">Xóa</a> --%>
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
<div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg"> <!-- Tăng kích thước modal -->
    <div class="modal-content shadow-lg border-0">
      <!-- Modal Header -->
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="editCategoryModalLabel"><i class="bi bi-pencil-square"></i> Chỉnh sửa Loại</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body bg-light">
	        <form id="editCategoryForm">
	          <!-- Mã Loại (Ẩn) -->
	          <input type="hidden" class="form-control" id="categoryID" name="categoryID" readonly>
			  <input type="hidden" class="form-control" id="categoryOldName" name="categoryOldName" readonly>
	          <!-- Tên Loại -->
	          <div class="mb-4">
	            <label for="categoryName" class="form-label fw-bold">Tên Loại:</label>
	            <input type="text" class="form-control form-control-lg border-primary" id="categoryName" name="categoryName" placeholder="Nhập tên loại..." required>
	          </div>
	
	          <!-- Mô tả -->
	          <div class="mb-4">
	            <label for="description" class="form-label fw-bold">Mô tả:</label>
	            <textarea class="form-control border-primary" id="description" name="description" rows="3" placeholder="Nhập mô tả loại..." required></textarea>
	          </div>
	
	          <!-- Buttons -->
	          <div class="text-end">
	            <button type="submit" class="btn btn-success"><i class="bi bi-check-circle"></i> Lưu thay đổi</button>
	            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="bi bi-x-circle"></i> Hủy</button>
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
	
	//EditCategory
	$(document).ready(function () {
	    $(".editCategory").click(function (e) {
	        e.preventDefault();
	        var ID = $(this).data("id");
	        var name = $(this).data("name");
	        var description = $(this).data("description");

	        // Điền dữ liệu vào form chỉnh sửa
	        $("#editCategoryModal #categoryID").val(ID);
	        $("#editCategoryModal #categoryName").val(name);
	        $("#editCategoryModal #categoryOldName").val(name);
	        $("#editCategoryModal #description").val(description);

	        // Hiển thị modal chỉnh sửa
	        $("#editCategoryModal").modal("show");
	    });

	    // Thực hiện lưu thay đổi khi form được submit
	    $("#editCategoryForm").submit(function (e) {
	        e.preventDefault();
	        var formData = $(this).serialize();
	        $.ajax({
	            url: "AdminEditCategoryController", 
	            type: "POST",
	            data: formData,
	            success: function(response) {
                    if (response.success) {
                        alert(response.message);  // Thông báo khi thành công
                        $("#editCategoryModal").modal("hide");
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

	// DeleteCategory
	$(document).on("click", ".deleteCategory", function (e) {
	    e.preventDefault();

	    // Lấy đường dẫn xóa từ thuộc tính href
	    const link = $(this).prop("href");
	    if (!link) {
	        alert("Không tìm thấy đường dẫn để xóa.");
	        return;
	    }

	    // Hộp thoại xác nhận
	    if (!confirm("Bạn có chắc chắn muốn xóa loại hàng này không?")) {
	        return;
	    }

	    $.ajax({
	        url: link,
	        type: "POST",
	        success: function (response) {
	            if (response && response.success) {
	                alert(response.message || "Xóa loại hàng thành công!");
	                location.reload();
	            } else {
	                alert(response.message || "Không thể xóa loại hàng.");
	            }
	        },
	        error: function () {
	            alert("Đã xảy ra lỗi không mong muốn.");
	        }
	    });
	});

	
  </script>
</body>
</html>