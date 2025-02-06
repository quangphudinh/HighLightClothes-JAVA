package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import CartsShoppingModal.CartBO;
import ProductsModal.Product;
import ProductsModal.ProductBO;
import PromotionModal.Promotion;
import PromotionModal.PromotionBO;

/**
 * Servlet implementation class productDetailController
 */
@WebServlet("/productDetailController")
public class productDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public productDetailController() {
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
	        
	        int productID = Integer.parseInt(request.getParameter("productID"));
	        
	        ProductBO prod = new ProductBO();
	        Product pr = prod.getOneProduct(productID);
	        request.setAttribute("Detail", pr);
	        
	        PromotionBO prom = new PromotionBO();
	        for (Promotion p : prom.getAvailablePromotion()) {
				if(pr.getPromotionID() == p.getPromotionID()){
					request.setAttribute("newPrice", pr.getPrice()-(pr.getPrice() * p.getDiscount() / 100));
				}
			}
        
	     RequestDispatcher rd = request.getRequestDispatcher("ClientPage/DetailProduct.jsp");
	  	 rd.forward(request, response);
		}catch (Exception e) {
			// TODO: handle exception
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Đoạn này để thêm sản phẩm vào giỏ hàng
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		try {
			HttpSession session = request.getSession();
			String token = (String)session.getAttribute("Token");
			
			// Kiểm tra token
	        if (token == null || token.isEmpty()) {
	            // Chuyển hướng đến trang login
	            response.sendRedirect("loginController");
	            return;
	        }
	        
			String size = request.getParameter("size");
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			int productID = Integer.parseInt(request.getParameter("productID"));

			String tb;
			
			CartBO cart = new CartBO();		
			int result = cart.AddProductsToCart(token, size, quantity, productID);
			if (result > 0) {
         			tb = "Thêm vào giỏ hàng thành công";
         			session.setAttribute("notificationCart", tb); // Dùng session để giữ thông báo
         			response.sendRedirect("productDetailController?productID="+productID);
         		} 
         		else {
         			tb = "Thêm vào giỏ hàng thất bại";
         			session.setAttribute("notificationCart", tb);
         			response.sendRedirect("productDetailController?productID="+productID);
         		}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Lỗi thêm loại hàng : ");
			e.printStackTrace();
			response.sendRedirect("productController");
		}	
	}

}
