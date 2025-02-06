package Controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import CategoryModal.CategoryBO;

/**
 * Servlet implementation class AdminCreateCategoryController
 */
@WebServlet("/AdminCreateCategoryController")
public class AdminCreateCategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminCreateCategoryController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		try {
			String nameC = request.getParameter("categoryName");
			String desC = request.getParameter("categoryDescription");
			Date createAt = new Date(System.currentTimeMillis());
			String tb;HttpSession session = request.getSession();
			CategoryBO cbo = new CategoryBO();
			if(cbo.checkName(nameC) > 0) {
				tb = "Thêm loại hàng THẤT BẠI, Tên loại hàng đã tồn tại!!";	
      			session.setAttribute("notificationCategory", tb); 
      			response.sendRedirect("AdminCategoryController");
			}else {
				int result = cbo.addCategory(nameC, desC, createAt);
				if (result > 0) {
	         			tb = "Thêm loại hàng thành công";
	         			session.setAttribute("notificationCategory", tb); // Dùng session để giữ thông báo
	         			response.sendRedirect("AdminCategoryController");
	         		} 
	         		else {
	         			tb = "Thêm loại hàng thất bại";
	         			session.setAttribute("notificationCategory", tb);
	         			response.sendRedirect("AdminCategoryController");
	         		}
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Lỗi thêm loại hàng : ");
			e.printStackTrace();
			response.sendRedirect("AdminCategoryController");
		}	
	}

}
