package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import CategoryModal.CategoryBO;
import ProductsModal.ProductBO;
import PromotionModal.PromotionBO;

/**
 * Servlet implementation class productController
 */
@WebServlet("/productController")
public class productController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public productController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
	        response.setCharacterEncoding("utf-8");
	        
	        PromotionBO prom = new PromotionBO();
	        request.setAttribute("listPromotions", prom.getAvailablePromotion());
	        
	        ProductBO prod = new ProductBO();
	        CategoryBO cat = new CategoryBO();
	        
	        String categoryIDStr = request.getParameter("categoryID");
	        String priceStr = request.getParameter("priceS");
	        String nameStr = request.getParameter("nameS");
	        String dateStr = request.getParameter("dateS");

	        
//	        System.out.println("categoryID : " + categoryIDStr);
//	        System.out.println("priceS : " + priceStr);
//	        System.out.println("nameS : " + nameStr);
//	        System.out.println("dateS : " + dateStr);
	        
	        if(categoryIDStr != null) {
	        	request.setAttribute("cID", categoryIDStr);
	        }
	        
	        request.setAttribute("listCategories", cat.getCategories());
	        request.setAttribute("listProducts", prod.getSortProducts(categoryIDStr, nameStr, priceStr, dateStr));
	                
	        RequestDispatcher rd = request.getRequestDispatcher("ClientPage/Product.jsp");
	  		rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
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
