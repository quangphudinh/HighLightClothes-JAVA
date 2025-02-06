package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PromotionModal.PromotionBO;

/**
 * Servlet implementation class AdminDeletePromotionController
 */
@WebServlet("/AdminDeletePromotionController")
public class AdminDeletePromotionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDeletePromotionController() {
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

	    int promotionID = Integer.parseInt(request.getParameter("promotionID"));
	    System.out.println("ID: " + promotionID);


	    try {
	        PromotionBO prbo = new PromotionBO();
	        int check = prbo.isUse(promotionID);

	        if (check > 0) {
	            response.getWriter().write("{\"error\": true, \"message\": \"Không thể xóa do: ĐÃ CÓ SẢN PHẨM ĐANG ĐƯỢC GẮN KHUYẾN MÃI NÀY!\"}");
	        } else {
	            if (prbo.deletePromotion(promotionID)) {
	                response.getWriter().write("{\"success\": true, \"message\": \"Xóa KHUYẾN MÃI thành công.\"}");
	            } else {
	                response.getWriter().write("{\"error\": true, \"message\": \"Không thể xóa KHUYẾN MÃI này.\"}");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("{\"error\": true, \"message\": \"Đã xảy ra lỗi trong quá trình xóa KHUYẾN MÃI.\"}");
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
