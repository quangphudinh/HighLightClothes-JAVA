package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import CategoryModal.CategoryBO;

/**
 * Servlet implementation class AdminDeleteCategoryController
 */
@WebServlet("/AdminDeleteCategoryController")
public class AdminDeleteCategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDeleteCategoryController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("utf-8");

	    int categoryID = Integer.parseInt(request.getParameter("categoryID"));
	    System.out.println("ID: " + categoryID);


	    try {
	        CategoryBO cbo = new CategoryBO();
	        int check = cbo.IsUseCategoryInProducts(categoryID);

	        if (check > 0) {
	            response.getWriter().write("{\"error\": true, \"message\": \"Không thể xóa do: ĐÃ CÓ SẢN PHẨM THUỘC LOẠI HÀNG NÀY!\"}");
	        } else {
	            if (cbo.deleteCategory(categoryID)) {
	                response.getWriter().write("{\"success\": true, \"message\": \"Xóa LOẠI HÀNG thành công.\"}");
	            } else {
	                response.getWriter().write("{\"error\": true, \"message\": \"Không thể xóa LOẠI HÀNG.\"}");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("{\"error\": true, \"message\": \"Đã xảy ra lỗi trong quá trình xóa LOẠI HÀNG.\"}");
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
