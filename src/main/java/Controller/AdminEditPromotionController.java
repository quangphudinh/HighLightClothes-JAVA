package Controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PromotionModal.PromotionBO;


/**
 * Servlet implementation class AdminEditPromotionController
 */
@WebServlet("/AdminEditPromotionController")
public class AdminEditPromotionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminEditPromotionController() {
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

	    int promotionID = Integer.parseInt(request.getParameter("promotionID"));
	    String promotionName = request.getParameter("promotionName");
	    String promotionOldName = request.getParameter("promotionOldName");
	    Double discount = Double.parseDouble(request.getParameter("discount"));
	    Date start =  Date.valueOf(request.getParameter("startDate")); // Ép kiểu date theo sql.date
		Date end =  Date.valueOf(request.getParameter("endDate"));

//	    System.out.println("ID: " + promotionID);
//	    System.out.println("Name: " + promotionName);
//	    System.out.println("OldName: " + promotionOldName);
//	    System.out.println("discount: " + discount);
//	    System.out.println("start: " + start);
//	    System.out.println("end: " + end);
		
	    try {
	        PromotionBO cbo = new PromotionBO();
	        int check = 0;
	        if (!promotionName.equals(promotionOldName)) {
	            check = cbo.checkName(promotionName); 
	        }
	        if (check > 0) {
	            response.getWriter().write("{\"error\": true, \"message\": \"Không thể cập nhật do: TÊN KHUYẾN MÃI ĐÃ TỒN TẠI!\"}");
	        } else {
	        	if(start.after(end))
	        		 response.getWriter().write("{\"error\": true, \"message\": \"Không thể cập nhật do: NGÀY KẾT THÚC < NGÀY BẮT ĐẦU!\"}");
	        	else {
	        		int result = cbo.updatePromotion(promotionID, promotionName, discount, start, end);

		            if (result > 0) {
		                response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật KHUYẾN MÃI thành công.\"}");
		            } else {
		                response.getWriter().write("{\"error\": true, \"message\": \"Không thể cập nhật KHUYẾN MÃI này.\"}");
		            }
	        	}	            
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("{\"error\": true, \"message\": \"Đã xảy ra lỗi trong quá trình cập nhật KHUYẾN MÃI.\"}");
	    }
	}

}
