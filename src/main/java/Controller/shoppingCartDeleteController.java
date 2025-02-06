package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import CartsShoppingModal.CartBO;
import CategoryModal.CategoryBO;

/**
 * Servlet implementation class shoppingCartDeleteController
 */
@WebServlet("/shoppingCartDeleteController")
public class shoppingCartDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public shoppingCartDeleteController() {
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

	    int cartDetailID = Integer.parseInt(request.getParameter("cartDetailID"));
	    System.out.println("cartDetailID: " + cartDetailID);

	    try {
	        CartBO cbo = new CartBO();
            if (cbo.DeleteProductFromCart(cartDetailID) > 0) {
                response.getWriter().write("{\"success\": true, \"message\": \"Xóa sản phẩm khỏi giỏ hàng thành công.\"}");
            } else {
                response.getWriter().write("{\"error\": true, \"message\": \"Xóa sản phẩm này khỏi giỏ hàng thất bại.\"}");
            }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("{\"error\": true, \"message\": \"Đã xảy ra lỗi trong quá trình xóa sản phẩm khỏi giỏ hàng.\"}");
	    }
	}

}
