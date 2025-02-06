package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import InvoicesModal.InvoiceBO;

/**
 * Servlet implementation class AdminHistoryController
 */
@WebServlet("/AdminHistoryController")
public class AdminHistoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminHistoryController() {
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
				request.setAttribute("listOrders", ibo.GetListOrderHistory(id));
				request.setAttribute("listOrderDetails", ibo.GetListOrderDetails());
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("AdminPage/AdminInvoicesHistory.jsp");
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
