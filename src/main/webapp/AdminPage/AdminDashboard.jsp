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
			
			.card-title {
			  font-size: 1.2rem;
			}
			
			.table-striped tbody tr:nth-of-type(odd) {
			  background-color: rgba(0, 0, 0, 0.05);
			}
		  
  </style>
</head>
<body>
  <div class="d-flex" id="wrapper">
    <!-- Sidebar -->
    <div class="bg-dark border-end" id="sidebar-wrapper">
      <div class="sidebar-heading text-white text-center py-4">Admin Dashboard</div>
      <div class="list-group list-group-flush">
        <a href="AdminDashboardController" class="list-group-item list-group-item-action bg-white text-dark">Trang Chủ</a>
        <a href="AdminProductController" class="list-group-item list-group-item-action bg-dark text-white">Sản Phẩm</a>
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
      </nav>

      <div class="container-fluid px-4">
        <div class="row my-4">
          <div class="col-lg-3 col-md-6">
            <div class="card text-white bg-primary mb-3">
              <div class="card-body">
                <h5 class="card-title">Total Users</h5>
                <p class="card-text">1,234</p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="card text-white bg-success mb-3">
              <div class="card-body">
                <h5 class="card-title">Revenue</h5>
                <p class="card-text">$12,345</p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="card text-white bg-warning mb-3">
              <div class="card-body">
                <h5 class="card-title">New Signups</h5>
                <p class="card-text">345</p>
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="card text-white bg-danger mb-3">
              <div class="card-body">
                <h5 class="card-title">Pending Issues</h5>
                <p class="card-text">23</p>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-header">Recent Activities</div>
              <div class="card-body">
                <table class="table table-striped">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>User</th>
                      <th>Activity</th>
                      <th>Time</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td>John Doe</td>
                      <td>Logged in</td>
                      <td>2 hours ago</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td>Jane Smith</td>
                      <td>Updated profile</td>
                      <td>1 hour ago</td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td>Mark Wilson</td>
                      <td>Uploaded a file</td>
                      <td>30 mins ago</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- /#page-content-wrapper -->
  </div>
  <!-- /#wrapper -->

  <!-- Bootstrap Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Custom JS -->
  <script>
	// Toggle sidebar visibility
	document.getElementById("menu-toggle").addEventListener("click", function () {
	  const wrapper = document.getElementById("wrapper");
	  wrapper.classList.toggle("toggled");
	});
  </script>
</body>
</html>


