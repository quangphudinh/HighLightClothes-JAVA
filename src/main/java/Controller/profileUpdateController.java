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
 * Servlet implementation class profileUpdateController
 */
@WebServlet("/profileUpdateController")
public class profileUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public profileUpdateController() {
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
	        HttpSession session = request.getSession();
	        String token = (String)session.getAttribute("Token");
	          
	        CustomerBO cbo = new CustomerBO();
	        request.setAttribute("Customer", cbo.getCustomer(token));

			RequestDispatcher rd = request.getRequestDispatcher("ClientPage/Profile.jsp");
		  	 rd.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
		}
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
		 
		 String fullName = "" , email = "" , oldemail = "", phone="" , address="" , image="" , hiddenImage="";
		 HttpSession session = request.getSession();
	     String token = (String)session.getAttribute("Token");
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
	                    else if (fieldName.equals("oldemail"))
	                    	oldemail = fieldValue;
					}
				}
	 			String tb=null; 
	          	CustomerBO Cus = new CustomerBO();
	  			int ktra;
	  			System.out.println("name : " + email);	
				System.out.println("oldName : " + oldemail);
	  			if(!email.equals(oldemail)) {	
	      			ktra = Cus.checkEmail(email);
	  			}else {
	  				ktra = -1;
	  			}
	  			if(ktra > 0) {	
	      			tb = "Cập nhật thất bại do Email đã tồn tại !!!";
	      			session.setAttribute("notificationCustomer", tb); 
	      			response.sendRedirect("profileController");
	  			}else {
	  				try {
		  				for (FileItem fileItem : fileItems) {
		 					if (fileItem.isFormField()) {
		                        String fieldName = fileItem.getFieldName();
		                        String fieldValue = fileItem.getString("UTF-8");
		                        
				                 if (fieldName.equals("hiddenImage")){
				                	 hiddenImage = fieldValue;
				              	}else if (fieldName.equals("address")){
				              		address = fieldValue;
				               	}else if (fieldName.equals("gender")){
				               		gender = Boolean.parseBoolean(fieldValue);
				               	}else if (fieldName.equals("phone")){
				               		phone = fieldValue;
				               	}else if (fieldName.equals("fullName")){
				               		fullName = fieldValue;
				               	}else if (fieldName.equals("dob")){
				               		birthday = Date.valueOf(fieldValue);
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
									           String fileImg = dirUrl + File.separator + nameimg;
									           File file = new File(fileImg);//tạo file
									            try {
									               fileItem.write(file);//lưu file
									               image = "Image_Customers/"+nameimg;
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
		  			if(image == "") image = hiddenImage;
		  			else {
		  				String dirUrl2 = request.getServletContext().getRealPath(""); 	// Lấy đường dẫn hiện tại của project	
	        	        File imageFile = new File(dirUrl2, hiddenImage); 						// Đường dẫn đầy đủ của file ảnh cần xóa
	        	        // System.out.println(imageFile); 
	        	        if (imageFile.exists() && imageFile.isFile()) {					// Kiểm tra ảnh có tồn tại không
	        	            imageFile.delete();
	        	        }
		  			}
//		  			System.out.println("Ktra : " + ktra);
//		  			System.out.println("Date : " + birthday); 
//	
					try {
						int result = Cus.updateCustomer(token, email, fullName, address, phone, gender, image, birthday);
	 	         		
						if (result > 0) {
	 	         			tb = "Cập nhật thông tin cá nhân thành công !!";
	 	         		} 
	 	         		else {
	 	         			tb = "Cập nhật thông tin cá nhân thất bại";
	 	         		}
						// Điều hướng đến trang danh sách sách hoặc trang thông báo thành công
	         			session.setAttribute("notificationCustomer", tb); // Dùng session để giữ thông báo
	         			session.setAttribute("Avatar", image);
	         			response.sendRedirect("profileController");
					}catch (Exception e) {
						e.printStackTrace();
	 	         		// Hiển thị thông báo lỗi
	 	         		tb = "Có lỗi xảy ra: " + e.getMessage();
	 	         		session.setAttribute("notificationCustomer", tb);
	 	         		response.sendRedirect("profileController");
					}
	  			}
	  			

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
