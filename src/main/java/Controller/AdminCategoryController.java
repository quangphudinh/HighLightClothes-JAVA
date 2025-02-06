package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import CategoryModal.CategoryBO;

/**
 * Servlet implementation class AdminCategoryController
 */
@WebServlet("/AdminCategoryController")
public class AdminCategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminCategoryController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			CategoryBO cbo = new CategoryBO();
			request.setAttribute("listCategories", cbo.getCategories());
			
			String key = request.getParameter("searchCategories");
			System.out.println("KEY : " + key);
			if(key!=null)
				request.setAttribute("listCategories", cbo.searchCategories(key));
			request.setAttribute("key",key);
			
			RequestDispatcher rd = request.getRequestDispatcher("AdminPage/AdminCategories.jsp");
	  		rd.forward(request, response);
		} catch (Exception e) {
			System.out.println("Loi trang Category : ");
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
