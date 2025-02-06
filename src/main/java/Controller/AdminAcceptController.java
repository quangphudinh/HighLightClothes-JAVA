package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import CartsShoppingModal.CartBO;
import CategoryModal.CategoryBO;
import InvoicesModal.InvoiceBO;

/**
 * Servlet implementation class AdminAcceptController
 */
@WebServlet("/AdminAcceptController")
public class AdminAcceptController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminAcceptController() {
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
			
			InvoiceBO ibo = new InvoiceBO();
			ArrayList<Integer> id = ibo.getListInvoiceID();
			if(id.size() > 0) {
				request.setAttribute("listOrders", ibo.GetListOrder(id));
				request.setAttribute("listOrderDetails", ibo.GetListOrderDetails());
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("AdminPage/AdminAcceptInvoices.jsp");
		  	rd.forward(request, response);
		  	
		} catch (Exception e) {
			System.out.println("Loi trang Accept : ");
			e.printStackTrace();
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
	    	 String invoiceID = request.getParameter("invoiceID");	    	  
	    	 String input = request.getParameter("items");
	    	 
	    	// Chuẩn hóa chuỗi từ string sang ArrayList ID chi tiết từng sản phẩm cần duyệt của đơn hàng
	         if (input.startsWith("[") && input.endsWith("]")) {
	             input = input.substring(1, input.length() - 1);
	         }
	         String[] items = input.split(",");
	         ArrayList<Integer> intList = new ArrayList<>();
	         for (String item : items) {
	             intList.add(Integer.parseInt(item.trim()));
	         }
   	 
//	    	 System.out.println("cartDetailID : " + invoiceID);
//	    	 System.out.println("json : " + json);

            // Kiểm tra dữ liệu hợp lệ
            if (invoiceID == null || invoiceID.isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"Chấp nhận đơn hàng thất bại !!.\"}");
                return;
            }
            InvoiceBO ivc = new InvoiceBO();
            int temp = ivc.AcceptInvoce(Integer.parseInt(invoiceID), intList);
            if(temp > 0)
            	response.getWriter().write("{\"success\": true, \"message\": \"Đơn hàng đã được chấp nhận thành công !!.\"}");
            else
            	response.getWriter().write("{\"success\": false, \"message\": \"Chấp nhận đơn hàng thất bại !!.\"}");
            return;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("{\"error\": true, \"message\": \"Đã xảy ra lỗi trong quá trình chấp nhận đơn hàng.\"}");
	    }
	}

}
