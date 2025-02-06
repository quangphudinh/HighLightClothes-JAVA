package Controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ProductsModal.Product;
import ProductsModal.ProductBO;


/**
 * Servlet implementation class AdminDeleteProductController
 */
@WebServlet("/AdminDeleteProductController")
public class AdminDeleteProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDeleteProductController() {
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
     
        String pID = request.getParameter("ProductID");
		int id = Integer.parseInt(pID);
		
		System.out.println("ProductID xoa : " + pID);
        ProductBO Prod = new ProductBO();
        String photo = ""; Product P = new Product();
		try {
			P = Prod.getOneProduct(id);
			photo = P.getPhoto();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		System.out.println(photo);
			
     	try {
     		
     		if(Prod.checkProductinInvoiceDetail(id))
     		{	
     			response.getWriter().write("{\"success\": false , \"message\":\"Sản phẩm đã tồn tại trong Hóa Đơn không thể xóa!\"}");
     		}else {	              
     			if (Prod.deleteProduct(id)) {
     				// Xóa ảnh trong thư mục
        			String dirUrl1 = request.getServletContext().getRealPath(""); 	// Lấy đường dẫn hiện tại của project	
        	        File imageFile = new File(dirUrl1, photo); 						// Đường dẫn đầy đủ của file ảnh cần xóa
        	        // System.out.println(imageFile); 
        	        if (imageFile.exists() && imageFile.isFile()) {					// Kiểm tra ảnh có tồn tại không
        	            // Xóa file
        	            imageFile.delete();
        	        }
    				response.getWriter().write("{\"success\": true , \"message\":\"Xóa sản phẩm "+ P.getName() +" thành công!\"}");
    			}else {
    				response.getWriter().write("{\"success\": false, \"message\": \"Không tìm thấy sản phẩm "+ P.getName() +"\"}");
    			}
     		}
			
		} catch (Exception e) {
			e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Đã xảy ra lỗi khi xóa sách.\"}");
		}
	}

}
