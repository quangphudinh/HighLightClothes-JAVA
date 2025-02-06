package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import AdminModal.Admin;
import AdminModal.AdminBO;
import nl.captcha.Captcha;

/**
 * Servlet implementation class AdminLoginController
 */
@WebServlet("/AdminLoginController")
public class AdminLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLoginController() {
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
	        
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        
//	        System.out.println("email : "+ email);
//	        System.out.println("password : "+ password);
	        
//	        if(email != null && password != null) {
//	        	AdminBO abo = new AdminBO();
//	        	Admin ad = new Admin();
//	        	ad = abo.checkLogin(email, password);
//		        if( ad.getEmail() == null) {
//		        	request.setAttribute("errorMessage", "Sai Email hoặc Mật Khẩu !!");
//		        }else {
//		        	HttpSession session = request.getSession();
//		        	session.setAttribute("Admin", ad);
//
//		        	response.sendRedirect("AdminDashboardController");
//		        }
//	        }

	        HttpSession session=request.getSession();
	        Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
	        request.setCharacterEncoding("UTF-8");
	        String answer = request.getParameter("answer");
	        
	        String errorMessage = "";
	        int dem=0;
	        if(session.getAttribute("dem")!=null)
	        dem=(int)session.getAttribute("dem");
	        if(answer!=null)
	        if(dem>=3 && !captcha.isCorrect(answer) ) {
	           RequestDispatcher rd= request.getRequestDispatcher("AdminPage/AdminLogin.jsp");
	           rd.forward(request, response);
	        }
	        if(email != null && password != null) {
	        	AdminBO abo = new AdminBO();Admin ad = new Admin();
	        	ad = abo.checkLogin(email, password);
	        	 if( ad.getEmail() != null){//Xu ly sau
	        		 session.setAttribute("Admin", ad);
	        		 response.sendRedirect("AdminDashboardController");
	        		 return;
	            }else {
	            	errorMessage = "Sai Email hoặc Mật Khẩu !!";
	            	request.setAttribute("errorMessage",errorMessage);
	                if(session.getAttribute("dem")==null)
	                    session.setAttribute("dem", (int)0);
	                int d=(int)session.getAttribute("dem");d++;
	                session.setAttribute("dem", d);
	            }
	        }
	        
			RequestDispatcher rd = request.getRequestDispatcher("AdminPage/AdminLogin.jsp");
		  	 rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Loi trang login admin : " + e);
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


