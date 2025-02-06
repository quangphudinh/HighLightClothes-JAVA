package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.ForEach;

import CartsShoppingModal.Cart;
import CartsShoppingModal.CartBO;

/**
 * Servlet implementation class shoppingCartController
 */
@WebServlet("/shoppingCartController")
public class shoppingCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public shoppingCartController() {
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
			 
			 HttpSession session = request.getSession();
	         String token = (String)session.getAttribute("Token");
//	         System.out.println(token);
	         if(token != null) {
	        	 CartBO cbo = new CartBO();
	        	 ArrayList<Cart> c = cbo.getCartProducts(token);
	        	 if (c.size() == 0) {
        		    request.setAttribute("CartNotification", "GIỎ HÀNG CỦA BẠN ĐANG TRỐNG !!!");
        		} else {
        		    request.setAttribute("listProductinCart", c);		    
        		}
	        	 session.setAttribute("SizeofCart", c.size());
	         }
			RequestDispatcher rd = request.getRequestDispatcher("ClientPage/CartShopping.jsp");
		  	rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Loi trang giỏ hàng : " + e);
			e.printStackTrace(); // In chi tiết lỗi 
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("utf-8");
	    
	    try {
	    	 String cartDetailID = request.getParameter("cartDetailID");
	    	 String quantityStr = request.getParameter("quantity");
	    	 String size = request.getParameter("size");

	    	 int quantity = Integer.parseInt(quantityStr);
	    	 
//	    	 System.out.println("cartDetailID : " + cartDetailID);
//	    	 System.out.println("quantityStr : " + quantityStr);
//	    	 System.out.println("size : " + size);

            // Kiểm tra dữ liệu hợp lệ
            if (cartDetailID == null || cartDetailID.isEmpty() || quantity <= 0 || size == null || size.isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"Cập nhật thất bại !!.\"}");
                return;
            }
            CartBO cart = new CartBO();
            cart.updateQuantityandSize(Integer.parseInt(cartDetailID), quantity, size);
            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật sản phẩm trong giỏ hàng thành công.\"}");
            return;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("{\"error\": true, \"message\": \"Đã xảy ra lỗi trong quá trình cập nhật sản phẩm trong giỏ hàng.\"}");
	    }
	}

}
