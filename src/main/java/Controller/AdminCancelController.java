package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import InvoicesModal.InvoiceBO;

/**
 * Servlet implementation class AdminCancelController
 */
@WebServlet("/AdminCancelController")
public class AdminCancelController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminCancelController() {
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
	    
	    try {
	    	 String invocesID = request.getParameter("Id");

	    	 System.out.println("cartDetailID : " + invocesID);

            // Kiểm tra dữ liệu hợp lệ
            if (invocesID == null || invocesID.isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"Hủy đơn hàng thất bại !!.\"}");
                return;
            }
            InvoiceBO ivc = new InvoiceBO();
            int temp = ivc.CancelInvoce(Integer.parseInt(invocesID));
            if(temp > 0)
            	response.getWriter().write("{\"success\": true, \"message\": \"Hủy đơn hàng thành công !!.\"}");
            else
            	response.getWriter().write("{\"success\": false, \"message\": \"Hủy đơn hàng thất bại !!.\"}");
            return;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("{\"error\": true, \"message\": \"Đã xảy ra lỗi trong quá trình hủy đơn hàng.\"}");
	    }
	}

}
