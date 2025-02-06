package InvoicesModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.stream.Collectors;

import CartsShoppingModal.Cart;
import CustomerModal.CustomerBO;
import OrderDetailModal.OrderDetail;
import OrderModal.Order;
import ketnoimodal.KetNoi;

public class InvoiceDAO {

	//lấy danh sách ID đơn hàng của 1 người dùng
	public ArrayList<Integer> getListInvoiceID(String token) throws Exception {
		ArrayList<Integer> ds = new ArrayList<Integer>();
		CustomerBO cus = new CustomerBO();
		int customerID = cus.getCustomerIDByToken(token);
		
	    KetNoi kn = new KetNoi();
	    kn.ketNoi();
	    
	    if(customerID > 0)
	    {
	    	String sql = "select InvoiceID from Invoices Where CustomerID = ? ORDER BY CreatedAt DESC;";

		    PreparedStatement cmd = kn.cn.prepareStatement(sql);
		    cmd.setInt(1, customerID);
		    ResultSet rs = cmd.executeQuery();
		
		    while(rs.next()) {
		    	ds.add(rs.getInt("InvoiceID"));
		    }rs.close();cmd.close();
	    }else {
	    	throw new Exception("Customer không tồn tại hoặc Token không hợp lệ.");
	    }
	    kn.cn.close();
		return ds;
	}
	
	//Lấy chi hết tiết đơn hàng (rồi so sánh bên jsp or controller)
	public ArrayList<Invoice> getListInvoiceDetail() throws Exception {
		ArrayList<Invoice> ds = new ArrayList<Invoice>();
		
	    KetNoi kn = new KetNoi();
	    kn.ketNoi();
	    
    	String sql = "select * from VInvoice";

	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
//	    cmd.setInt(1, invoiceID);
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	    	 int InvoiceDetailID = rs.getInt("InvoiceDetailID");
	    	 int InvoiceID = rs.getInt("InvoiceID");
	    	 int ProductID = rs.getInt("ProductID");
	    	 int CustomerID = rs.getInt("CustomerID");
	    	 int Quantity = rs.getInt("Quantity");
	    	 String size = rs.getString("size");
	    	 Double Price = rs.getDouble("Price");
	    	 String Status = rs.getString("Status");
	    	 String Ttdh = rs.getString("ttdh");
	    	 String Name = rs.getString("Name");
	    	 String Photo = rs.getString("Photo");
	    	 Timestamp CreateAt	= rs.getTimestamp("CreatedAt");
	    	 Timestamp FinishTime	= rs.getTimestamp("FinishTime");
	    	 ds.add(new Invoice(InvoiceDetailID, InvoiceID, ProductID, CustomerID, Quantity, size, Price, Status, Name, Photo, CreateAt,FinishTime,Ttdh));
	    }rs.close();cmd.close();
	 
	    kn.cn.close();
		return ds;
	}
	
	public void DeleteProductsInCart(int cartDetailID) throws Exception {
		KetNoi kn = new KetNoi() ;
		kn.ketNoi();
		
		String sql = "Delete from CartDetails where CartDetailID = ?";
		PreparedStatement deletecmd = kn.cn.prepareStatement(sql);
		deletecmd.setInt(1, cartDetailID);
		deletecmd.executeUpdate();
	    kn.cn.close();
	    return;
	}
	
	public void CreateNewInvoice(ArrayList<Cart> cartDetails) throws Exception {
	    // Kết nối đến cơ sở dữ liệu
	    KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    // Tính tổng số tiền
	    double total = 0;
	    for (Cart cart : cartDetails) {
	        total += cart.getTotal(); // Gọi phương thức getTotal() của từng sản phẩm
	    }

	    // Thêm hóa đơn mới
	    String invoiceQuery = "INSERT INTO Invoices (CustomerID, TotalAmount, Status) VALUES (?, ?, ?)";
	    PreparedStatement insertInvoice = kn.cn.prepareStatement(invoiceQuery, PreparedStatement.RETURN_GENERATED_KEYS);

	    insertInvoice.setInt(1, cartDetails.get(0).getCustomerID());
	    insertInvoice.setDouble(2, total);
	    insertInvoice.setString(3, "Pending");
	    insertInvoice.executeUpdate();

	    // Lấy InvoiceID vừa tạo
	    ResultSet generatedKeys = insertInvoice.getGeneratedKeys();
	    if (generatedKeys.next()) {
	        int invoiceId = generatedKeys.getInt(1);

	        // Thêm chi tiết hóa đơn
	        String detailQuery = "INSERT INTO InvoiceDetails (InvoiceID, ProductID, Quantity, Price, Size,Status) VALUES (?, ?, ?, ?, ?,?)";
	        PreparedStatement insertDetail = kn.cn.prepareStatement(detailQuery);

	        for (Cart cart : cartDetails) {
	            insertDetail.setInt(1, invoiceId);
	            insertDetail.setInt(2, cart.getProductID());
	            insertDetail.setInt(3, cart.getQuantity());
	            insertDetail.setDouble(4, cart.getNewPrice());
	            insertDetail.setString(5, cart.getSize());
	            insertDetail.setString(6, "Pending");
	            insertDetail.executeUpdate();
	        }

	        // Xóa sản phẩm trong giỏ hàng
	        for (Cart cart : cartDetails) {
	            DeleteProductsInCart(cart.getCartDetailID());
	        }
	    }
	}

	//----------------------------------ADMIN INVOICES------------------------------------------//
	
	//lấy danh sách ID đơn hàng của tất cả người dùng
	public ArrayList<Integer> getListInvoiceID() throws Exception {
		ArrayList<Integer> ds = new ArrayList<Integer>();
	
	    KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    	String sql = "select InvoiceID from Invoices ORDER BY CreatedAt DESC;";

		    PreparedStatement cmd = kn.cn.prepareStatement(sql);

		    ResultSet rs = cmd.executeQuery();
		
		    while(rs.next()) {
		    	ds.add(rs.getInt("InvoiceID"));
		    }rs.close();cmd.close();
		    	
	    kn.cn.close();
		return ds;
	}
	
	//Lấy danh sách từng đơn hàng (các đối tượng trong bảng Order) có trạng thái "PENDING"
	public ArrayList<Order> GetListOrder(ArrayList<Integer> invoiceIds) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		ArrayList<Order> ds = new ArrayList<Order>();
		
		// Tạo chuỗi danh sách InvoiceID từ ArrayList
		String invoiceIdList = invoiceIds.stream()
		                                  .map(String::valueOf) // Chuyển từng ID sang chuỗi
		                                  .collect(Collectors.joining(","));

		// Tạo câu truy vấn
		String overviewQuery = """
			    SELECT 
			        o.InvoiceID AS [Order ID],
			        c.Name AS [Customer Name],
			        FORMAT(o.CreatedAt, 'dd/MM/yyyy HH:mm:ss') AS [Order Date],
				    FORMAT(o.FinishTime, 'dd/MM/yyyy HH:mm:ss') AS [Finish Date],
			        o.Status,
			        SUM(od.Quantity * od.Price) AS [Total]
			    FROM 
			        Invoices o
			    JOIN 
			        Customers c ON o.CustomerID = c.CustomerID
			    JOIN 
			        InvoiceDetails od ON o.InvoiceID = od.InvoiceID
			    WHERE 
			        o.InvoiceID IN (%s) 
			        AND o.Status = 'Pending'
			    GROUP BY 
			        o.InvoiceID, c.Name, o.CreatedAt, o.FinishTime,o.Status
			    ORDER BY 
			        o.CreatedAt DESC;
			""".formatted(invoiceIdList);

	    PreparedStatement cmd = kn.cn.prepareStatement(overviewQuery);
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	    	 int InvoiceID = rs.getInt("Order ID");
	    	 String customerName = rs.getString("Customer Name");
	    	 String orderDate = rs.getString("Order Date");
	    	 String finishDate = rs.getString("Finish Date");
	    	 String status = rs.getString("Status");
	    	 double total = rs.getDouble("Total");
	    	 ds.add(new Order(InvoiceID, customerName, orderDate, status, total,finishDate));
	    }rs.close();cmd.close();
	 
	    kn.cn.close();
		return ds;
	}
	
	//Lấy tất cả chi tiết đơn hàng mà phù hợp với OrderDetail cần hiển thị ra bên ngoài
	public ArrayList<OrderDetail> GetListOrderDetails() throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		ArrayList<OrderDetail> ds = new ArrayList<OrderDetail>();
	
		// Tạo câu truy vấn
		String overviewQuery = """
		     SELECT 
                od.InvoiceID AS [Order ID],
                od.InvoiceDetailID,
                od.ProductID,
                p.Name AS [Product Name],
                od.Quantity,
                od.Price,
                (od.Quantity * od.Price) AS [Subtotal],
                od.Status,
                od.Size,
                p.Photo AS [Image]
            FROM 
                InvoiceDetails od
            JOIN 
                Products p ON od.ProductID = p.ProductID
		""";

	    PreparedStatement cmd = kn.cn.prepareStatement(overviewQuery);
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	    	 int invoiceID = rs.getInt("Order ID");
	    	 int invoiceDetailID = rs.getInt("InvoiceDetailID");
	    	 int productId = rs.getInt("ProductID");
	    	 String productName = rs.getString("Product Name");
	    	 int quantity = rs.getInt("Quantity");
	    	 double price = rs.getDouble("Price");
	    	 double subtotal = rs.getDouble("Subtotal");
	    	 String status = rs.getString("Status");
	    	 String image = rs.getString("Image");
	    	 String size = rs.getString("Size");
	    	 ds.add(new OrderDetail(invoiceID, productId, productName, quantity, price, subtotal, status, image,invoiceDetailID,size));
	    }rs.close();cmd.close();
	 
	    kn.cn.close();
		return ds;
	}

	//Hủy đơn hàng
	public int CancelInvoce(int invoiceID) throws Exception{
		 KetNoi kn = new KetNoi();
	     kn.ketNoi();

	    	String sql = "update Invoices\r\n"
	    			+ "set Status = 'Canceled' , FinishTime =  GETDATE()  \r\n"
	    			+ "where InvoiceID = ?";

		    PreparedStatement cmdInvoices = kn.cn.prepareStatement(sql);
		    cmdInvoices.setInt(1, invoiceID);
		    cmdInvoices.executeUpdate();
		    
		    // Cập nhật bảng InvoiceDetails
		    String sqlInvoiceDetails = "UPDATE InvoiceDetails " +
		                               "SET Status = 'Canceled' " +
		                               "WHERE InvoiceID = ?";
		    PreparedStatement cmdInvoiceDetails = kn.cn.prepareStatement(sqlInvoiceDetails);
		    cmdInvoiceDetails.setInt(1, invoiceID);
		    cmdInvoiceDetails.executeUpdate();
		    kn.cn.close();
		    return 1;
	}
	
	//Lấy dánh sách ID detail của 1 hóa đơn
	public ArrayList<Integer> ListProductInInvoice(int InvoiceID) throws Exception{
		 KetNoi kn = new KetNoi();
	     kn.ketNoi();

	     ArrayList<Integer> ds = new ArrayList<Integer>();
	     
	     String sql = "SELECT * FROM InvoiceDetails WHERE InvoiceID = ?";
		 PreparedStatement cmdInvoices = kn.cn.prepareStatement(sql);
		 cmdInvoices.setInt(1, InvoiceID);
		 
		 ResultSet rs = cmdInvoices.executeQuery();
			
	    while(rs.next()) {
	    	 int invoiceDetailID = rs.getInt("InvoiceDetailID");
	    	 ds.add(invoiceDetailID);
	    }
	    kn.cn.close();
		return ds;
	}
	
	// Chấp nhận đơn hàng
	public int AcceptInvoce(int invoiceID , ArrayList<Integer> invoiceDetailID) throws Exception{
		 KetNoi kn = new KetNoi();
	     kn.ketNoi();
	     
	     // 1. Cập nhật trạng thái của bảng Invoices thành 'Accepted'
	     String sqlInvoices = "UPDATE Invoices " +
			                 "SET Status = 'Accepted' , FinishTime = GETDATE() " +
			                 "WHERE InvoiceID = ?";
		 PreparedStatement cmdInvoices = kn.cn.prepareStatement(sqlInvoices);
		 cmdInvoices.setInt(1, invoiceID);
		 cmdInvoices.executeUpdate();
		    

		 // Cập nhật trạng thái 'Accepted' cho các InvoiceDetailID trong danh sách
	     String sqlAccepted = "UPDATE InvoiceDetails SET Status = 'Accepted' " +
	                          "WHERE InvoiceID = ? AND InvoiceDetailID IN (" +
	                          invoiceDetailID.stream().map(String::valueOf).collect(Collectors.joining(",")) + ")";
	     PreparedStatement cmdAccepted = kn.cn.prepareStatement(sqlAccepted);
	     cmdAccepted.setInt(1, invoiceID);
	     cmdAccepted.executeUpdate();

	     // Cập nhật trạng thái 'Canceled' cho các InvoiceDetailID không nằm trong danh sách
	     String sqlCanceled = "UPDATE InvoiceDetails SET Status = 'Canceled' " +
	                          "WHERE InvoiceID = ? AND InvoiceDetailID NOT IN (" +
	                          invoiceDetailID.stream().map(String::valueOf).collect(Collectors.joining(",")) + ")";
	     PreparedStatement cmdCanceled = kn.cn.prepareStatement(sqlCanceled);
	     cmdCanceled.setInt(1, invoiceID);
	     cmdCanceled.executeUpdate();
	     
	     // 4. Tính toán và cập nhật TotalAmount trong bảng Invoices
	     String sqlUpdateTotal = """
	         UPDATE Invoices
	         SET TotalAmount = (
	             SELECT SUM(Quantity * Price)
	             FROM InvoiceDetails
	             WHERE InvoiceID = ? AND Status = 'Accepted'
	         )
	         WHERE InvoiceID = ?
	     """;
	     PreparedStatement cmdUpdateTotal = kn.cn.prepareStatement(sqlUpdateTotal);
	     cmdUpdateTotal.setInt(1, invoiceID);  // Tham số cho subquery
	     cmdUpdateTotal.setInt(2, invoiceID);  // Tham số cho Invoices
	     cmdUpdateTotal.executeUpdate();
        
	    kn.cn.close();
	    return 1;
	}
	
	//----------------------------------ADMIN HISTORY INVOICES------------------------------------------//
	
	//Lấy danh sách những đơn hàng đã được duyệt 'ACCEPTED' hoặc bị Hủy 'CANCELED'
		public ArrayList<Order> GetListOrderHistory(ArrayList<Integer> invoiceIds) throws Exception {
			KetNoi kn = new KetNoi();
			kn.ketNoi();
			
			ArrayList<Order> ds = new ArrayList<Order>();
			
			// Tạo chuỗi danh sách InvoiceID từ ArrayList
			String invoiceIdList = invoiceIds.stream()
			                                  .map(String::valueOf) // Chuyển từng ID sang chuỗi
			                                  .collect(Collectors.joining(","));

			// Tạo câu truy vấn
			String overviewQuery = """
				    SELECT 
				        o.InvoiceID AS [Order ID],
				        c.Name AS [Customer Name],
				        FORMAT(o.CreatedAt, 'dd/MM/yyyy HH:mm:ss') AS [Order Date],
				        FORMAT(o.FinishTime, 'dd/MM/yyyy HH:mm:ss') AS [Finish Date],
				        o.Status,
				        o.TotalAmount AS [Total]
				    FROM 
				        Invoices o
				    JOIN 
				        Customers c ON o.CustomerID = c.CustomerID
				    JOIN 
				        InvoiceDetails od ON o.InvoiceID = od.InvoiceID
				    WHERE 
				        o.InvoiceID IN (%s) 
				        AND o.Status <> 'Pending'
				    GROUP BY 
				        o.InvoiceID, c.Name, o.CreatedAt, o.FinishTime, o.Status,o.TotalAmount
				    ORDER BY 
				        o.FinishTime DESC;  
				""".formatted(invoiceIdList);

		    PreparedStatement cmd = kn.cn.prepareStatement(overviewQuery);
		    ResultSet rs = cmd.executeQuery();
		
		    while(rs.next()) {
		    	 int InvoiceID = rs.getInt("Order ID");
		    	 String customerName = rs.getString("Customer Name");
		    	 String orderDate = rs.getString("Order Date");
		    	 String finishDate = rs.getString("Finish Date");
		    	 String status = rs.getString("Status");
		    	 double total = rs.getDouble("Total");
		    	 ds.add(new Order(InvoiceID, customerName, orderDate, status, total,finishDate));
		    }rs.close();cmd.close();
		 
		    kn.cn.close();
			return ds;
		}
}
