package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import CartsShoppingModal.Cart;
import CartsShoppingModal.CartBO;
import InvoicesModal.Invoice;
import InvoicesModal.InvoiceBO;
import InvoicesModal.InvoiceDAO;

/**
 * Servlet implementation class invoicesController
 */
@WebServlet("/invoicesController")
public class invoicesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public invoicesController() {
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
	        
	        ArrayList<Integer> InID;
	        ArrayList<Invoice> InvoiceDetails = new ArrayList<Invoice>();
	        HttpSession session = request.getSession();
            String token = (String)session.getAttribute("Token");
            
            // Kiểm tra token
	        if (token == null || token.isEmpty()) {
	            // Chuyển hướng đến trang login
	            response.sendRedirect("loginController");
	            return;
	        }
            
	        InvoiceBO ibo = new InvoiceBO();
	        InID = ibo.getListInvoiceID(token);
//	        InvoiceDetails = ibo.getListInvoiceDetail();
	        InvoiceDetails = ibo.getListInvoiceDetail();
	        if(InID != null && InvoiceDetails != null) {
	        	request.setAttribute("listInID", InID);
	        	request.setAttribute("listInvoiceDetails", InvoiceDetails);
	        }
	        
	        for(Invoice item : InvoiceDetails) {
	        	request.setAttribute(String.valueOf(item.getInvoiceID()), item.getCreateAt());
	        }
	        
			RequestDispatcher dispatcher = request.getRequestDispatcher("ClientPage/Invoice.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} 
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy các cartDetailID từ request
        String selectedCartDetailIDs = request.getParameter("selectedCartDetailIDs");
        
        // Kiểm tra xem có cartDetailID nào được gửi hay không
        if (selectedCartDetailIDs != null && !selectedCartDetailIDs.isEmpty()) {
            // Tách các cartDetailID thành một mảng bằng dấu phẩy
        	String[] cartDetailIDsArray = selectedCartDetailIDs.split(",");
        	ArrayList<String> cartDetailIDList = new ArrayList<>(Arrays.asList(cartDetailIDsArray));
            
            // In các cartDetailID vào console (hoặc hiển thị ra)
            System.out.println("Các cartDetailID đã chọn:");
            for (String cartDetailID : cartDetailIDList) {
                System.out.println(cartDetailID);
            }
            
            HttpSession session = request.getSession();
            String token = (String)session.getAttribute("Token");
                 
            CartBO cbo = new CartBO();
            InvoiceBO ibo = new InvoiceBO();
            ArrayList<Cart> cs;
			try {
				cs = cbo.getSomeProductsInCart(token, cartDetailIDList);
				ibo.CreateNewInvoice(cs);
//				for (Cart c : cs) {
//	            	System.out.println("CusID : "  + c.getCustomerID());
//	            }
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
                  
			response.sendRedirect("invoicesController");
        }
	}
}


