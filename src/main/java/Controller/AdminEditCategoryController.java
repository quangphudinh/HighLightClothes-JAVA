package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import CategoryModal.CategoryBO;

/**
 * Servlet implementation class AdminEditCategoryController
 */
@WebServlet("/AdminEditCategoryController")
public class AdminEditCategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminEditCategoryController() {
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
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("utf-8");

	    int categoryID = Integer.parseInt(request.getParameter("categoryID"));
	    String categoryName = request.getParameter("categoryName");
	    String categoryOldName = request.getParameter("categoryOldName");
	    String description = request.getParameter("description");

//	    System.out.println("ID: " + categoryID);
//	    System.out.println("Name: " + categoryName);
//	    System.out.println("OldName: " + categoryOldName);
//	    System.out.println("Description: " + description);

	    try {
	        CategoryBO cbo = new CategoryBO();
	        int check = 0;
	        if (!categoryName.equals(categoryOldName)) {
	            check = cbo.checkName(categoryName); 
	        }

	        if (check > 0) {
	            response.getWriter().write("{\"error\": true, \"message\": \"Không thể cập nhật do: TÊN LOẠI HÀNG ĐÃ TỒN TẠI!\"}");
	        } else {
	            int result = cbo.updateCategory(categoryID, categoryName, description);

	            if (result > 0) {
	                response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật LOẠI HÀNG thành công.\"}");
	            } else {
	                response.getWriter().write("{\"error\": true, \"message\": \"Không thể cập nhật LOẠI HÀNG.\"}");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("{\"error\": true, \"message\": \"Đã xảy ra lỗi trong quá trình cập nhật LOẠI HÀNG.\"}");
	    }
	}

}
