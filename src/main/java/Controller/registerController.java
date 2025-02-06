package Controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import CustomerModal.CustomerBO;

/**
 * Servlet implementation class registerController
 */
@WebServlet("/registerController")
public class registerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public registerController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("ClientPage/Register.jsp");
	  	 rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
		 response.setCharacterEncoding("utf-8");
		 
		 DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
		 ServletFileUpload upload = new ServletFileUpload(fileItemFactory);
		 String dirUrl1 = request.getServletContext().getRealPath("") +  File.separator + "Image_Customers";
		 response.getWriter().println(dirUrl1);
		 
		 String name = "" , email = "" , phone="" , address="" , image="", password="";
		 Boolean gender = true;
		 Date birthday = new Date(System.currentTimeMillis());
       
       try {
      	 List<FileItem> fileItems = upload.parseRequest(new ServletRequestContext(request));//Lấy về các đối tượng gửi lên
				for (FileItem fileItem : fileItems) {
	 				if (fileItem.isFormField()) {
	                    // Xử lý các trường thông thường (text, select)
	                    String fieldName = fileItem.getFieldName();
	                    String fieldValue = fileItem.getString("utf-8");
	                    if (fieldName.equals("email"))
	                    	email = fieldValue;
					}
				}
	 			String tb=null; 
	          	CustomerBO Cus = new CustomerBO();
	          	HttpSession session = request.getSession();
	          	
	  			int ktra = Cus.checkEmail(email);
//	  			System.out.println("email : " + email);	
	  			
	  			if(ktra > 0) {	
	      			tb = "Đăng Ký thất bại do Email đã tồn tại !!!";
	      			session.setAttribute("notificationCustomer", tb); 
	      			response.sendRedirect("registerController");
	  			}else {
	  				try {
		  				for (FileItem fileItem : fileItems) {
		 					if (fileItem.isFormField()) {
		                        String fieldName = fileItem.getFieldName();
		                        String fieldValue = fileItem.getString("UTF-8");
		                        
		                        if (fieldName.equals("address")){
				              		address = fieldValue;
				               	}else if (fieldName.equals("gender")){
				               		gender = Boolean.parseBoolean(fieldValue);
				               	}else if (fieldName.equals("phone")){
				               		phone = fieldValue;
				               	}else if (fieldName.equals("name")){
				               		name = fieldValue;
				               	}else if (fieldName.equals("birthday")){
				               		birthday = Date.valueOf(fieldValue);
				               	}else if (fieldName.equals("password")){
				               		password = fieldValue;
				               	}
							}else {
								if (!fileItem.isFormField()) {//Nếu ko phải các control=>upfile lên
									// xử lý file
									String nameimg = fileItem.getName();
									if (nameimg!="") {
								           //Lấy đường dẫn hiện tại, chủ ý xử lý trên dirUrl để có đường dẫn đúng
										String dirUrl = request.getServletContext().getRealPath("") +  File.separator + "Image_Customers";
										File dir = new File(dirUrl);
										if (!dir.exists()) {//nếu ko có thư mục thì tạo ra
											dir.mkdir();
										}
										long timestamp = System.currentTimeMillis();
										String newName = "user_" + timestamp + ".jpg";

								           String fileImg = dirUrl + File.separator + newName;
								           File file = new File(fileImg);//tạo file
								            try {
								               fileItem.write(file);//lưu file
								               image = "Image_Customers/"+newName;
											 } catch (Exception e) {
											    e.printStackTrace();
										 	 }
										} 	
									}			
								}
		  					}
					} catch (Exception e) {
						// TODO: handle exception
					}
		  			if(image == "") image = "Image_Customers/noavatar.jpg";

//		  			System.out.println("Ktra : " + ktra);
//		  			System.out.println("image : " + image); 
//		  			System.out.println("name : " + name); 
//		  			System.out.println("email : " + email); 
//		  			System.out.println("phone : " + phone); 
//		  			System.out.println("Date : " + birthday); 
//		  			System.out.println("address : " + address); 
//		  			System.out.println("gender : " + gender); 
//		  			System.out.println("password : " + password); ;


					try {
						int result = Cus.addCustomer(name, email, phone, address, password, gender, image , birthday);
	 	         		
						if (result > 0) {
	 	         			tb = "Đăng ký tài khoản thành công !!";
	 	         			session.setAttribute("notificationCustomer", tb); 
		         			response.sendRedirect("loginController");
	 	         		} 
	 	         		else {
	 	         			tb = "Đăng ký tài khoản thất bại";
	 	         			session.setAttribute("notificationCustomer", tb); 
		         			response.sendRedirect("registerController");
	 	         		}
	         			
					}catch (Exception e) {
						e.printStackTrace();
	 	         		// Hiển thị thông báo lỗi
	 	         		tb = "Có lỗi xảy ra: " + e.getMessage();
	 	         		session.setAttribute("notificationCustomer", tb);
	 	         		response.sendRedirect("registerController");
					}
	  			}
	  			

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
