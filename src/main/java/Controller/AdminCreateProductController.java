package Controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
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

import CategoryModal.CategoryBO;
import ProductsModal.ProductBO;
import PromotionModal.PromotionBO;


/**
 * Servlet implementation class AdminCreateProductController
 */
@WebServlet("/AdminCreateProductController")
public class AdminCreateProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminCreateProductController() {
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
	        
	        CategoryBO cbo = new CategoryBO();
	        request.setAttribute("listCategories", cbo.getCategories());
	        PromotionBO prombo = new PromotionBO();
	        request.setAttribute("listPromotions", prombo.getPromtions());
	        
	  		RequestDispatcher rd = request.getRequestDispatcher("AdminPage/AdminCreateProduct.jsp");
	  		rd.forward(request, response);
		} catch (Exception e) {
			System.out.println("Loi trang AdminCreateProductController : " + e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
		 response.setCharacterEncoding("utf-8");

		
//		 DiskFileItemFactory factory = new DiskFileItemFactory();
		 DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
		 ServletFileUpload upload = new ServletFileUpload(fileItemFactory);
		 String dirUrl1 = request.getServletContext().getRealPath("") +  File.separator + "Image_Products";
		 response.getWriter().println(dirUrl1);
		 
		 String name = "" , description = "", photo="";
		 Boolean status=true;
         int stock = 1 , categoryID = 1 , promotionID = 1;
         Double price = 0.0 ;
         Timestamp createAt = new Timestamp(System.currentTimeMillis());
		 
		 try {
        	 //Kiem tra masach
	            List<FileItem> fileItems = upload.parseRequest(new ServletRequestContext(request));//Lấy về các đối tượng gửi lên
				for (FileItem fileItem : fileItems) {
	 				if (fileItem.isFormField()) {
	                    // Xử lý các trường thông thường (text, select)
	                    String fieldName = fileItem.getFieldName();
	                    String fieldValue = fileItem.getString("utf-8");
	
	                    if (fieldName.equals("productName")){
	                        	name = fieldValue;
	                        	break;
	                    	}
	 					}
	 				}
				System.out.println(name);
    			String tb=null; 
             	HttpSession session = request.getSession();
     			ProductBO Prod = new ProductBO();
     			int ktra = Prod.checkName(name);
    			
     			if(ktra > 0) {	
         			tb = "Thêm thất bại do Tên sản phẩm đã tồn tại !!!";
         			session.setAttribute("notificationProduct", tb); // Dùng session để giữ thông báo
         			response.sendRedirect("AdminCreateProductController");
     			}else {
     				for (FileItem fileItem : fileItems) 
    				{
    		 			 if (!fileItem.isFormField()) {//Nếu ko phải các control=>upfile lên
    						// xử lý file
    						String nameimg = fileItem.getName();
    						if (!nameimg.equals("")) {
    					           //Lấy đường dẫn hiện tại, chủ ý xử lý trên dirUrl để có đường dẫn đúng
    							String dirUrl = request.getServletContext().getRealPath("") +  File.separator + "Image_Products";
    							File dir = new File(dirUrl);
    							if (!dir.exists()) {//nếu ko có thư mục thì tạo ra
    								dir.mkdir();
    							}
    						           String fileImg = dirUrl + File.separator + nameimg;
    						           File file = new File(fileImg);//tạo file
    						            try {
    						               fileItem.write(file);//lưu file
    						               photo = "Image_Products/"+nameimg;
			    						 } catch (Exception e) {
			    						    e.printStackTrace();
			    						 }
    							}
    		 			 }
	    				else//Neu la control
	    				{
	    					if (fileItem.isFormField()) {
	                            // Xử lý các trường thông thường (text, select)
	                            String fieldName = fileItem.getFieldName();
	                            String fieldValue = fileItem.getString("UTF-8");
	
	                            if (fieldName.equals("productName")){
			                     	name = fieldValue;
			                 	}
				                 else if (fieldName.equals("description")){
				                	 description = fieldValue;
				               	}
				                 else if (fieldName.equals("status")){
				                	 status = Boolean.parseBoolean(fieldValue);
				               	}
				                 else if (fieldName.equals("stock")){
				                	 stock = Integer.parseInt(fieldValue);
				               	}
				                 else if (fieldName.equals("price")){
				                	 price = Double.parseDouble(fieldValue);
				               	}
				                 else if (fieldName.equals("categoryID")){
				                	 categoryID = Integer.parseInt(fieldValue);
				               	}
				                 else if (fieldName.equals("promotion")){
				                	 promotionID = Integer.parseInt(fieldValue);
				               	}
	                            
	    					}
	    				}
    				}
     				
     				
     				System.out.println("name : " + name);	
					System.out.println("description : " + description);
					System.out.println("status : " + status);
					System.out.println("stock : " + stock);
					System.out.println("price : " + price);
					System.out.println("categoryID : " + categoryID);
					System.out.println("photo : " + photo);
					System.out.println("photo : " + promotionID);
     	         	
     	         	try {
     	         		int result = Prod.addProduct(name, description, price, stock, categoryID, promotionID , status, photo, createAt);
     	         		if (result > 0) {
     	         			tb = "Thêm sản phẩm thành công";
     	         			// Điều hướng đến trang danh sách sách hoặc trang thông báo thành công
     	         			session.setAttribute("notificationProduct", tb); // Dùng session để giữ thông báo
     	         			response.sendRedirect("AdminCreateProductController");
     	         		} 
     	         		else {
     	         			tb = "Thêm sản phẩm thất bại";
     	         			session.setAttribute("notificationProduct", tb);
     	         			response.sendRedirect("AdminCreateProductController");
     	         		}
     	         	} catch (Exception e) {
     	         		e.printStackTrace();
     	         		// Hiển thị thông báo lỗi
     	         		tb = "Có lỗi xảy ra: " + e.getMessage();
     	         		session.setAttribute("notificationProduct", tb);
     	         		RequestDispatcher rd = request.getRequestDispatcher("AdminCreateProductController");
     	         		rd.forward(request, response);
     		        }
     			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Lỗi thêm sản phẩm : ");
			e.printStackTrace();
		}
		 
	}
}
