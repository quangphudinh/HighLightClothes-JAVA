package Controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import PromotionModal.PromotionBO;

/**
 * Servlet implementation class AdminCreatePromotionController
 */
@WebServlet("/AdminCreatePromotionController")
public class AdminCreatePromotionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminCreatePromotionController() {
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
			String nameP = request.getParameter("promotionName");
			Double discount = Double.parseDouble(request.getParameter("discount"));
			Date start =  Date.valueOf(request.getParameter("startDate")); // Ép kiểu date theo sql.date
			Date end =  Date.valueOf(request.getParameter("endDate"));
			
//			Date createAt = new Date(System.currentTimeMillis());
			String tb;HttpSession session = request.getSession();
			PromotionBO prbo = new PromotionBO();
			
			if(prbo.checkName(nameP) > 0) {
				tb = "Thêm khuyến mãi THẤT BẠI, Tên khuyến mãi đã tồn tại!!";	
      			session.setAttribute("notificationPromotion", tb); 
      			response.sendRedirect("AdminPromotionController");
			}else {
				int result = prbo.addPromotion(nameP, discount, start, end);
				if (result > 0) {
	         			tb = "Thêm khuyến mãi thành công";
	         			session.setAttribute("notificationPromotion", tb); 
	         			response.sendRedirect("AdminPromotionController");
	         		} 
	         		else {
	         			tb = "Thêm khuyến mãi thất bại";
	         			session.setAttribute("notificationPromotion", tb);
	         			response.sendRedirect("AdminPromotionController");
	         		}
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Lỗi thêm loại hàng : ");
			e.printStackTrace();
			response.sendRedirect("AdminPromotionController");
		}	
	}

}
