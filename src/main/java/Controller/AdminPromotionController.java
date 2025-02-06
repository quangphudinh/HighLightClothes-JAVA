package Controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PromotionModal.Promotion;
import PromotionModal.PromotionBO;

/**
 * Servlet implementation class AdminPromotionController
 */
@WebServlet("/AdminPromotionController")
public class AdminPromotionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPromotionController() {
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
	        
	        String name = request.getParameter("searchPromotions");
	        String startStr = request.getParameter("startDate");
	        String endStr = request.getParameter("endDate");
	        
	        Date start=null , end=null;
	        if(startStr != null)
	        	try {
	        		start = Date.valueOf(startStr);
	        		System.out.println("start" + start);
				} catch (Exception e) {
					// TODO: handle exception
				}
	        if(endStr != null)
	        	try {
	        		end = Date.valueOf(endStr);
	        		System.out.println("end" + end);
				} catch (Exception e) {
					// TODO: handle exception
				}
	        	
	        
	        
//	        Date start = Date.valueOf(request.getParameter("startDate"));
//	        Date end = Date.valueOf(request.getParameter("endDate"));
//	        
	        System.out.println("name : " + name);
//	        System.out.println("start : " + start);
//	        System.out.println("end : " + end);
//	        
	        Date currentDate = new Date(System.currentTimeMillis());
	        request.setAttribute("currentDate", currentDate);
	     
	        PromotionBO pbo = new PromotionBO();
	        request.setAttribute("listPromotions", pbo.getPromtions());
	        
	        ArrayList<Promotion> ds = new ArrayList<Promotion>();
	        if(name!=null || start!=null || end!=null) {
	        	ds=pbo.searchPromotions(name, start, end);
	        	request.setAttribute("listPromotions",ds);	
	        }
	        request.setAttribute("key", name);
        	request.setAttribute("startDate", start);
        	request.setAttribute("endDate", end);
	        
			RequestDispatcher rd = request.getRequestDispatcher("AdminPage/AdminPromotions.jsp");
	  		rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Loi trang AdminPromotionController : " + e);
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
