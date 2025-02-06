package Controller;

import java.io.File;
import java.io.IOException;
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
 * Servlet implementation class AdminEditProductController
 */
@WebServlet("/AdminEditProductController")
public class AdminEditProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminEditProductController() {
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
	        
	        String pID = request.getParameter("ProductID");  

	        System.out.println("PID :" + pID);
	        ProductBO pbo = new ProductBO();
	        request.setAttribute("ProductEdit", pbo.getOneProduct(Integer.parseInt(pID)));
	        
	  		RequestDispatcher rd = request.getRequestDispatcher("AdminPage/AdminEditProduct.jsp");
	  		rd.forward(request, response);
		} catch (Exception e) {
			System.out.println("Loi trang AdminEditProductController : " + e);
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
		 
		 String name = "" , description = "", photo="" , imageHidden="" , oldName="";
		 Boolean status=true;
         int stock = 1 , categoryID = 1 ,promotionID = 1, productID = 0;
         Double price = 0.0 ;
         
         try {
        	 List<FileItem> fileItems = upload.parseRequest(new ServletRequestContext(request));//Lấy về các đối tượng gửi lên
				for (FileItem fileItem : fileItems) {
	 				if (fileItem.isFormField()) {
	                    // Xử lý các trường thông thường (text, select)
	                    String fieldName = fileItem.getFieldName();
	                    String fieldValue = fileItem.getString("utf-8");
	
	                    if (fieldName.equals("productName"))
                     	name = fieldValue;
	                    else if (fieldName.equals("oldName"))
                 		oldName = fieldValue;
 					}
 				}
	 			String tb=null; 
	          	HttpSession session = request.getSession();
	          	ProductBO Prod = new ProductBO();
	  			int ktra;
	  			System.out.println("name : " + name);	
 				System.out.println("oldName : " + oldName);
	  			if(!name.equals(oldName)) {	
	      			ktra = Prod.checkName(name);
	  			}else {
	  				ktra = -1;
	  			}
	  			if(ktra > 0) {	
	      			tb = "Cập nhật thất bại do Tên sản phẩm đã tồn tại !!!";
	      			session.setAttribute("notificationProduct", tb); // Dùng session để giữ thông báo
	      			response.sendRedirect("AdminEditProductController");
	  			}else {
	  				try {
		  				for (FileItem fileItem : fileItems) {
		 					if (fileItem.isFormField()) {
		                        // Xử lý các trường thông thường (text, select)
		                        String fieldName = fileItem.getFieldName();
		                        String fieldValue = fileItem.getString("UTF-8");
		                        
				                 if (fieldName.equals("imageHidden")){
				                	 imageHidden = fieldValue;
				              	}else if (fieldName.equals("description")){
				                	 description = fieldValue;
				               	}else if (fieldName.equals("status")){
				                	 status = Boolean.parseBoolean(fieldValue);
				               	}else if (fieldName.equals("stock")){
				                	 stock = Integer.parseInt(fieldValue);
				               	}else if (fieldName.equals("price")){
				                	 price = Double.parseDouble(fieldValue);
				               	}else if (fieldName.equals("categoryID")){
				                	 categoryID = Integer.parseInt(fieldValue);
				               	}else if (fieldName.equals("productID")){
				               		productID = Integer.parseInt(fieldValue);
				               	}else if (fieldName.equals("promotion")){
				                	 promotionID = Integer.parseInt(fieldValue);
				               	}
							}else {
								if (!fileItem.isFormField()) {//Nếu ko phải các control=>upfile lên
									// xử lý file
									String nameimg = fileItem.getName();
									if (nameimg!="") {
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
								}
		  					}
					} catch (Exception e) {
						// TODO: handle exception
					}
		  			if(photo == "") photo = imageHidden;
		  			else {
		  				String dirUrl2 = request.getServletContext().getRealPath(""); 	// Lấy đường dẫn hiện tại của project	
	        	        File imageFile = new File(dirUrl2, imageHidden); 						// Đường dẫn đầy đủ của file ảnh cần xóa
//	        	        System.out.println(imageFile); 
	        	        if (imageFile.exists() && imageFile.isFile()) {					// Kiểm tra ảnh có tồn tại không
	        	            imageFile.delete();
	        	        }
		  			}
//		  			System.out.println("Ktra : " + ktra);
//		  			System.out.println("productID : " + productID); 
//	 				System.out.println("name : " + name);	
//	 				System.out.println("oldName : " + oldName);	
//					System.out.println("description : " + description);
//					System.out.println("status : " + status);
//					System.out.println("stock : " + stock);
//					System.out.println("price : " + price);
//					System.out.println("categoryID : " + categoryID);
//					System.out.println("Photo : " + photo);
//					System.out.println("imageHidden : " + imageHidden);
//					System.out.println("promotionID : " + promotionID); 
					
					try {
						int result = Prod.updateProduct(productID,name,description,price,stock,categoryID,promotionID,status,photo);
	 	         		
						if (result > 0) {
	 	         			tb = "Chỉnh sửa sản phẩm thành công";
	 	         		} 
	 	         		else {
	 	         			tb = "Chỉnh sửa sản phẩm thất bại";
	 	         		}
						// Điều hướng đến trang danh sách sách hoặc trang thông báo thành công
	         			session.setAttribute("notificationProduct", tb); // Dùng session để giữ thông báo
	         			response.sendRedirect("AdminEditProductController?ProductID=" + productID);
					}catch (Exception e) {
						e.printStackTrace();
	 	         		// Hiển thị thông báo lỗi
	 	         		tb = "Có lỗi xảy ra: " + e.getMessage();
	 	         		session.setAttribute("notificationProduct", tb);
	 	         		response.sendRedirect("AdminEditProductController?ProductID="+productID);
					}
	  			}
	  			

		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
