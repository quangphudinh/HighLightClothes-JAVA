package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import CategoryModal.CategoryBO;
import ProductsModal.Product;
import ProductsModal.ProductBO;

/**
 * Servlet implementation class AdminProductController
 */
@WebServlet("/AdminProductController")
public class AdminProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminProductController() {
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

		        ProductBO pbo = new ProductBO();

		        // Lấy tham số tìm kiếm
		        String cID = request.getParameter("category");
		        String key = request.getParameter("searchProducts");

		        // Lấy tham số phân trang
		        String pageParam = request.getParameter("page");
		        int page = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
		        int pageSize = 5; // Số sản phẩm trên mỗi trang

		        // Tổng số sản phẩm
		        int totalProducts;
		        ArrayList<Product> products;

		        // Kiểm tra nếu có tìm kiếm
		        if (cID != null  || key != null) {
		            totalProducts = pbo.getTotalProductsBySearch(cID, key); // Số sản phẩm phù hợp với tìm kiếm
		            products = pbo.searchProductsByPage(cID, key, page, pageSize); // Sản phẩm theo tìm kiếm và phân trang
		            request.setAttribute("key", key);
		            request.setAttribute("cID", cID);
		        } else {
		            totalProducts = pbo.getTotalProducts(); // Tổng sản phẩm không lọc
		            products = pbo.getProductsByPage(page, pageSize); // Sản phẩm theo phân trang
		        }

		        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

		        // Gửi dữ liệu sang JSP
		        request.setAttribute("listProducts", products);
		        request.setAttribute("currentPage", page);
		        request.setAttribute("totalPages", totalPages);

		        // Gửi về JSP
		        RequestDispatcher rd = request.getRequestDispatcher("AdminPage/AdminProducts.jsp");
		        rd.forward(request, response);
		    } catch (Exception e) {
		        System.out.println("Lỗi trang AdminProductController: " + e);
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
