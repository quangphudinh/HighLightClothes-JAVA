package ProductsModal;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Timestamp;
import ketnoimodal.KetNoi;


public class ProductDAO {
	
	public void resetPromotion()throws Exception {
		KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    // Cập nhật các PromotionID đã hết hạn
	    String updateSql = """
	        UPDATE Products
			SET PromotionID = 1
			WHERE PromotionID != 1 
			  AND ProductID IN (
			      SELECT p.ProductID
			      FROM Products p
			      INNER JOIN Promotions pr ON p.PromotionID = pr.PromotionID
			      WHERE pr.EndDate < GETDATE());
	    """;
	    PreparedStatement updateCmd = kn.cn.prepareStatement(updateSql);
	    updateCmd.executeUpdate(); // Thực thi lệnh cập nhật các sản phẩm có PromotionID hết hạn
	    kn.cn.close();
	    return;
	}
	
	public ArrayList<Product> getProducts() throws Exception {
		ArrayList<Product> ds = new ArrayList<Product>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi();
 
	    // Lấy danh sách sản phẩm
	    String sql = "select * from Products order by CreateAt";

	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	     int ProductID = rs.getInt("ProductID");
	   	 String Name = rs.getString("Name");
	   	 String Description = rs.getString("Description");
	   	 Double Price = rs.getDouble("Price");
	   	 int Stock = rs.getInt("Stock");
	   	 int CategoryID = rs.getInt("CategoryID");
	   	 int PromotionID = rs.getInt("PromotionID");
	   	 Boolean Status = rs.getBoolean("Status");
	   	 String Photo = rs.getString("Photo");
	   	 Timestamp CreateAt = rs.getTimestamp("CreateAt");
	   	 
	   	 ds.add(new Product(ProductID,Name,Description,Price,Stock,CategoryID,PromotionID,Status,Photo,CreateAt));
	    }rs.close();
	    kn.cn.close();
		return ds;
	   }
	
	public ArrayList<Product> getSortProducts(String categoryID, String name , String price , String date) throws Exception {
		ArrayList<Product> ds = new ArrayList<Product>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    String sql ;
	    PreparedStatement cmd;
	    
	    if (categoryID != null && !categoryID.isEmpty()) {
	    	if (name != null && !name.isEmpty()) {
	    		sql = " select * from Products where CategoryID = ? order by Name " + name;
	    	}else if (price != null && !price.isEmpty()) {
	    		sql = " select * from Products where CategoryID = ? order by Price " + price;
	    	}else if (date != null && !date.isEmpty()) {
	    		sql = " select * from Products where CategoryID = ? order by CreateAt " + date;
	    	}else {
	    		sql = " select * from Products where CategoryID = ?";
	    	}
	    	cmd = kn.cn.prepareStatement(sql);
	    	cmd.setInt(1, Integer.parseInt(categoryID));
	    }else {
	    	if (name != null && !name.isEmpty()) {
	    		sql = " select * from Products order by Name " + name;
	    	}else if (price != null && !price.isEmpty()) {
	    		sql = " select * from Products order by Price " + price;
	    	}else if (date != null && !date.isEmpty()) {
	    		sql = " select * from Products order by CreateAt " + date;
	    	}else {
	    		sql = " select * from Products";
	    	}
	    	cmd = kn.cn.prepareStatement(sql);
	    }
	    
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	     int ProductID = rs.getInt("ProductID");
	   	 String Name = rs.getString("Name");
	   	 String Description = rs.getString("Description");
	   	 Double Price = rs.getDouble("Price");
	   	 int Stock = rs.getInt("Stock");
	   	 int CategoryID = rs.getInt("CategoryID");
	   	 int PromotionID = rs.getInt("PromotionID");
	   	 Boolean Status = rs.getBoolean("Status");
	   	 String Photo = rs.getString("Photo");
	   	Timestamp CreateAt = rs.getTimestamp("CreateAt");
	   	 
	   	 ds.add(new Product(ProductID,Name,Description,Price,Stock,CategoryID,PromotionID,Status,Photo,CreateAt));
	    }rs.close();
	    kn.cn.close();
		return ds;
	   }
	
	public ArrayList<Product> searchProducts(String categoryID , String key) throws Exception {
		ArrayList<Product> ds = new ArrayList<Product>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi();
	    
	    String sql;
	    PreparedStatement cmd ;
	    
	    if(categoryID == "") {
	    	sql = "SELECT * FROM Products WHERE Name LIKE CONCAT('%', ?, '%');";
	    	cmd = kn.cn.prepareStatement(sql);
		    cmd.setString(1, key);
	    }else if (key == null) {
	    	sql = "SELECT * FROM Products WHERE CategoryID = ? ";
	    	cmd = kn.cn.prepareStatement(sql);
		    cmd.setString(1, categoryID);
	    }else {
	    	sql = "SELECT * FROM Products WHERE CategoryID = ? AND Name LIKE CONCAT('%', ?, '%');";
	    	cmd = kn.cn.prepareStatement(sql);
		    cmd.setString(1, categoryID);
		    cmd.setString(2, key);
		    
	    }
	    
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	     int ProductID = rs.getInt("ProductID");
	   	 String Name = rs.getString("Name");
	   	 String Description = rs.getString("Description");
	   	 Double Price = rs.getDouble("Price");
	   	 int Stock = rs.getInt("Stock");
	   	 int CategoryID = rs.getInt("CategoryID");
	   	 int PromotionID = rs.getInt("PromotionID");
	   	 Boolean Status = rs.getBoolean("Status");
	   	 String Photo = rs.getString("Photo");
	   	Timestamp CreateAt = rs.getTimestamp("CreateAt");
	   	 
	   	 ds.add(new Product(ProductID,Name,Description,Price,Stock,CategoryID,PromotionID,Status,Photo,CreateAt));
	    }rs.close();
	    kn.cn.close();
		return ds;
	   }

	public int checkName(String name)throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String sqlCheckName = "select count(*) from Products where Name = ?";
		PreparedStatement checkCmd = kn.cn.prepareStatement(sqlCheckName);
		
	    checkCmd.setString(1, name);

	    ResultSet rs = checkCmd.executeQuery();
	    int count = 0;
	    if (rs.next()) {
	        count = rs.getInt(1); // Lấy số lượng bản ghi trùng teen san pham
	    }
	    kn.cn.close();
	    return count;
	}
	
	public int addProduct(String name,String des,Double price,int stock,int categoryID,int promotionID,Boolean status,String photo,Timestamp createAt) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();    	
	    
	    String sql = "INSERT INTO Products(Name, Description, Price, Stock, CategoryID, PromotionID, Status, Photo, CreateAt) VALUES (?,?,?,?,?,?,?,?,?)";
	    PreparedStatement insertCmd = kn.cn.prepareStatement(sql);
		
	    insertCmd.setString(1, name);
	    insertCmd.setString(2, des);
	    insertCmd.setDouble(3, price);
	    insertCmd.setInt(4, stock);
	    insertCmd.setInt(5, categoryID);
	    insertCmd.setInt(6, promotionID);
	    insertCmd.setBoolean(7, status);
	    insertCmd.setString(8, photo);
	    insertCmd.setTimestamp(9, createAt);
	    
	    // Thực hiện câu lệnh thêm sách
	    int rowsInserted = insertCmd.executeUpdate();

	    // Đóng kết nối
	    kn.cn.close();

	    // Trả về kết quả
	    if (rowsInserted > 0) {
	        return 1; // Thêm sách thành công
	    } else {
	        return 0; // Không thể thêm sách
	    }
	}
	
	public Product getOneProduct(int productID) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String sql = "select * from Products where ProductID = ?";
		PreparedStatement cmd = kn.cn.prepareStatement(sql);
		cmd.setInt(1, productID);
		
		ResultSet rs = cmd.executeQuery();
		Product prd = new Product();
		while(rs.next()) {
			int ProductID = rs.getInt("ProductID");
			String Name = rs.getString("Name");
			String Description = rs.getString("Description");
			Double Price = rs.getDouble("Price");
			int Stock = rs.getInt("Stock");
			int CategoryID = rs.getInt("CategoryID");
			String Photo = rs.getString("Photo");
			Timestamp CreateAt = rs.getTimestamp("CreateAt");
			int PromotionID = rs.getInt("PromotionID");
			Boolean Status = rs.getBoolean("Status");
			prd = new Product(ProductID , Name, Description, Price, Stock, CategoryID,PromotionID, Status, Photo, CreateAt);
		}
		
		kn.cn.close();
		return prd;
		
	}
	
	public int updateProduct(int productID,String name,String des,Double price,int stock,int categoryID,int promotionID,Boolean status,String photo) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();    	
	    
	    String sql = "update Products\r\n"
	    		+ "set\r\n"
	    		+ "	Name = ?,\r\n"
	    		+ "	CategoryID = ?,\r\n"
	    		+ "	Price = ?,\r\n"
	    		+ "	Stock = ?,\r\n"
	    		+ "	Status = ?,\r\n"
	    		+ "	Description = ?,\r\n"
	    		+ "	Photo = ?,\r\n"
	    		+ "	PromotionID = ?\r\n"
	    		+ "where ProductID = ?";
	    PreparedStatement insertCmd = kn.cn.prepareStatement(sql);
		
	    insertCmd.setString(1, name);
	    insertCmd.setInt(2, categoryID);
	    insertCmd.setDouble(3, price);
	    insertCmd.setInt(4, stock);
	    insertCmd.setBoolean(5, status);
	    insertCmd.setString(6, des);
	    insertCmd.setString(7, photo); 
	    insertCmd.setInt(8, promotionID);
	    insertCmd.setInt(9, productID);
	    
	    // Thực hiện câu lệnh thêm sách
	    int rowsInserted = insertCmd.executeUpdate();

	    // Đóng kết nối
	    kn.cn.close();

	    // Trả về kết quả
	    if (rowsInserted > 0) {
	        return 1; // Thêm sách thành công
	    } else {
	        return 0; // Không thể thêm sách
	    }
	}
	
	public Boolean deleteProduct(int productID)throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String deleteSql = "Delete FROM Products WHERE ProductID = ?";
		PreparedStatement deletecmd = kn.cn.prepareStatement(deleteSql);
		deletecmd.setInt(1, productID);
		
	    int rowsDeleted = deletecmd.executeUpdate();
	    kn.cn.close();

	    if (rowsDeleted > 0) {
	        return true;
	    } else {
	        return false;
	    }
	}
	
	public int checkProductInInvoiceDetails (int productID) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String checkINDSql = "SELECT COUNT(*) FROM InvoiceDetails WHERE ProductID = ?";
		PreparedStatement cmd = kn.cn.prepareStatement(checkINDSql);
		cmd.setInt(1, productID);
		
		ResultSet rs = cmd.executeQuery();
	    int count = 0;
	    if (rs.next()) {
	        count = rs.getInt(1);
	    }
	    kn.cn.close();
	    return count;
	}
	
	public ArrayList<Product> productPagination(int page, int pageSize) throws Exception{
	    ArrayList<Product> products = new ArrayList<>();
	    
	    KetNoi kn = new KetNoi();
	    kn.ketNoi();
        
	    int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Products ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        PreparedStatement cmd = kn.cn.prepareStatement(sql);
        
        cmd.setInt(1, offset);
        cmd.setInt(2, pageSize);
        
        ResultSet rs = cmd.executeQuery();
       
    	while(rs.next()) {
   	     int ProductID = rs.getInt("ProductID");
   	   	 String Name = rs.getString("Name");
   	   	 String Description = rs.getString("Description");
   	   	 Double Price = rs.getDouble("Price");
   	   	 int Stock = rs.getInt("Stock");
   	   	 int CategoryID = rs.getInt("CategoryID");
   	   	 int PromotionID = rs.getInt("PromotionID");
   	   	 Boolean Status = rs.getBoolean("Status");
   	   	 String Photo = rs.getString("Photo");
   	     Timestamp CreateAt = rs.getTimestamp("CreateAt");
   	   	 
   	    products.add(new Product(ProductID,Name,Description,Price,Stock,CategoryID,PromotionID,Status,Photo,CreateAt));
   	    }rs.close();
       
        kn.cn.close();
        return products;
	}
	
	public int getTotalProducts() throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
	    int total = 0;
	    
        String sql = "SELECT COUNT(*) AS Total FROM Products";
        PreparedStatement cmd = kn.cn.prepareStatement(sql);
        ResultSet rs = cmd.executeQuery();
        if (rs.next()) {
            total = rs.getInt("Total");
        }rs.close();
        kn.cn.close();
	    return total;
	}
	
	// Lấy tổng số sản phẩm theo tìm kiếm
	public int getTotalProductsBySearch(String categoryID, String key) throws Exception {
	    KetNoi kn =  new KetNoi();
	    kn.ketNoi();
		int total = 0;
	   
        String sql = "SELECT COUNT(*) AS Total FROM Products WHERE 1=1";
        if (categoryID != null && !categoryID.isEmpty()) {
            sql += " AND CategoryID = ?";
        }
        if (key != null && !key.isEmpty()) {
            sql += " AND Name LIKE ?";
        }
        PreparedStatement ps = kn.cn.prepareStatement(sql);
        int index = 1;
        if (categoryID != null && !categoryID.isEmpty()) {
            ps.setInt(index++, Integer.parseInt(categoryID));
        }
        if (key != null && !key.isEmpty()) {
            ps.setString(index, "%" + key + "%");
        }
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            total = rs.getInt("Total");
        }
        rs.close();
        kn.cn.close();
	    return total;
	}

	// Tìm kiếm sản phẩm theo trang
	public ArrayList<Product> searchProductsByPage(String categoryID, String key, int page, int pageSize)throws Exception {
		KetNoi kn =  new KetNoi();
	    kn.ketNoi();
		ArrayList<Product> products = new ArrayList<>();
	   
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Products WHERE 1=1";
        if (categoryID != null && !categoryID.isEmpty()) {
            sql += " AND CategoryID = ?";
        }
        if (key != null && !key.isEmpty()) {
            sql += " AND Name LIKE ?";
        }
        sql += " ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        PreparedStatement ps = kn.cn.prepareStatement(sql);
        int index = 1;
        if (categoryID != null && !categoryID.isEmpty()) {
            ps.setInt(index++, Integer.parseInt(categoryID));
        }
        if (key != null && !key.isEmpty()) {
            ps.setString(index++, "%" + key + "%");
        }
        ps.setInt(index++, offset);
        ps.setInt(index, pageSize);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Product p = new Product();
            p.setProductID(rs.getInt("ProductID"));
            p.setDescription(rs.getString("Description"));
            p.setName(rs.getString("Name"));
            p.setPrice(rs.getDouble("Price"));
            p.setStock(rs.getInt("Stock"));
            p.setPhoto(rs.getString("Photo"));
            p.setCategoryID(rs.getInt("CategoryID"));
            p.setStatus(rs.getBoolean("Status"));
            p.setPromotionID(rs.getInt("PromotionID"));
            p.setCreateAt(rs.getTimestamp("CreateAt"));
            products.add(p);
        }
        rs.close();
        kn.cn.close();
	    return products;
	}
	
	
	
	
	
	
}
