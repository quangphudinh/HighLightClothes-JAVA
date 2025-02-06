<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
      <title>HighLight - ADMIN</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                    <button class="btn btn-primary" id="menu-toggle">Toggle Menu</button>
                    <h2 class="ms-auto">Chỉnh Sửa Sản Phẩm</h2>
                </div>
            </nav>
            <c:if test="${not empty sessionScope.notificationProduct}">
            	<div class="container mt-5">
			        <!-- Thẻ thông báo -->
			        <div class="alert alert-success alert-dismissible fade show" role="alert">
			            <c:out value="${sessionScope.notificationProduct}" />
			            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			            <c:remove var="notificationProduct" scope="session" />
			        </div>
			    </div>
			</c:if>
              

            <div class="container my-4">
                <form action="AdminEditProductController" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <!-- Ảnh sản phẩm -->
                        <div class="col-md-6">
                            <div class="custom-file-container">
                                <img src="${ProductEdit.getPhoto()}" alt="Product Preview" id="imagePreview">
                                <label for="image" class="btn btn-secondary">Chọn ảnh</label>
                                <input type="file" class="form-control d-none" id="image" name="image" accept="image/*" onchange="previewImage(event)">
                            	<input type="hidden" name="imageHidden" value="${ProductEdit.getPhoto()}" >
                            </div>
                        </div>

                        <!-- Thông tin sản phẩm -->
                        <div class="col-md-6">
                        	<input type="hidden" value="${ProductEdit.getProductID()}" name="productID">
                            <!-- Tên sản phẩm -->
                            <div class="mb-3">
                                <label for="productName" class="form-label">Tên sản phẩm</label>
                                <input type="text" value="${ProductEdit.getName()}" class="form-control" id="productName" name="productName" placeholder="Nhập tên sản phẩm" required>
                           		<input type="hidden" value="${ProductEdit.getName()}" name="oldName">
                            </div>

                            <!-- Loại hàng -->
                            <div class="mb-3 row">
                            	<!-- Loại Hàng -->
                            	<div class="col-md-6">
	                                <label for="category" class="form-label">Loại hàng</label>
	                                <select class="form-select" id="category" name="categoryID" required>
	                                    <option value="" selected disabled>Chọn loại hàng</option>
	                                    <c:forEach var="cate" items="${listCategories}">
	                                    	<c:if test="${ProductEdit.getCategoryID() == cate.getCategoryID()}">
	                                    		 <option selected value="${cate.getCategoryID()}">${cate.getName()}</option>
	                                    	</c:if>
	                                        <c:if test="${ProductEdit.getCategoryID() != cate.getCategoryID()}">
	                                    		 <option value="${cate.getCategoryID()}">${cate.getName()}</option>
	                                    	</c:if>
	                                    </c:forEach>
	                                </select>
                                </div>
 						    	<!-- Trạng thái -->
                                <div class="col-md-4">
		                            <div class="mb-3">
		                                <label for="status" class="form-label">Trạng thái</label>
		                                <select class="form-select" id="status" name="status" required>
		                                	<c:if test="${ProductEdit.getStatus() == false}">
		                                   		 <option selected value=false>Hết Hàng</option>
		                                   		 <option value=true>Còn hàng</option>
		                                    </c:if>
		                                    <c:if test="${ProductEdit.getStatus() == true}">
		                                   		 <option value=false>Hết Hàng</option>
		                                   		 <option selected value=true>Còn hàng</option>
		                                    </c:if>
		                                </select>
		                            </div>
                                </div>
                            </div>

                            <!-- Giá và số lượng -->
                            <div class="mb-3 form-inline-group">
                                <div>
                                    <label for="price" class="form-label">Giá</label>
                                    <input type="number" step="0.001" min=1 value="${ProductEdit.getPrice()}" class="form-control" id="price" name="price" placeholder="Nhập giá sản phẩm" required>
                                </div>
                                <div>
                                    <label for="stock" class="form-label">Số lượng</label>
                                    <input type="number" min=0 value="${ProductEdit.getStock()}" class="form-control" id="stock" name="stock" placeholder="Nhập số lượng" required>
                                </div>
                            </div>

                            <!-- Chọn khuyến mãi -->
				            <div class="mb-3">
				                <label for="promotion" class="form-label">Khuyến Mãi</label>
				                    <select class="form-select" id="promotion" name="promotion" required>
				                        <option value=""  disabled>Chọn Khuyến Mãi</option>
				                        <c:forEach var="prom" items="${listPromotions}">
				                        	<c:if test="${ProductEdit.getPromotionID() == prom.getPromotionID()}">
				                        		<option selected value="${prom.getPromotionID()}">${prom.getName()}</option>
				                        	</c:if>
				                            <option value="${prom.getPromotionID()}">${prom.getName()}</option>
				                        </c:forEach>
				                    </select>
				            </div>

                            <!-- Mô tả -->
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả sản phẩm</label>
                                <textarea class="form-control" id="description" name="description" rows="3" placeholder="Nhập mô tả sản phẩm" required>${ProductEdit.getDescription()}
                                </textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Nút hành động -->
                    <div class="d-flex justify-content-center action-buttons mt-4">
                        <a href="AdminProductController" class="btn btn-secondary">Trở lại</a>
                        <button type="reset" class="btn btn-light border">Nhập lại</button>
                        <button type="submit" class="btn btn-success">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- /#page-content-wrapper -->
    </div>
    <!-- /#wrapper -->

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
