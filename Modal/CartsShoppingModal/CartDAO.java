package CartsShoppingModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import ketnoimodal.KetNoi;

public class CartDAO {
	
	public int getUserByToken(String token) throws Exception {
		KetNoi kn = new KetNoi();
	    kn.ketNoi();
	    
	    String Cusql = "SELECT CustomerID FROM Customers WHERE Token = ?";
	    PreparedStatement cusmd = kn.cn.prepareStatement(Cusql);
	    cusmd.setString(1, token);
	    
	    ResultSet cs = cusmd.executeQuery();
	    int customerID = 0;
	    while(cs.next()) {
	    	customerID = cs.getInt("CustomerID");
	    }cs.close();cusmd.close();
	    return customerID;
	}
	
	public int getCartbyCustomerID(int customerID) throws Exception {
		KetNoi kn = new KetNoi();
	    kn.ketNoi();
	    
	    String Cartql = "SELECT CartID FROM Cart WHERE CustomerID = ?";
	    PreparedStatement cartmd = kn.cn.prepareStatement(Cartql);
	    cartmd.setInt(1, customerID);
	    
	    ResultSet cs = cartmd.executeQuery();
	    int CartID = 0;
	    while(cs.next()) {
	    	CartID = cs.getInt("CartID");
	    }cs.close();cartmd.close();
	    return CartID;
	}
	
	public ArrayList<Cart> getCartProducts(String token) throws Exception {
		ArrayList<Cart> ds = new ArrayList<Cart>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi();
	    
	    int customerID = getUserByToken(token);
	    
	    
	    if(customerID > 0)
	    {	
	    	String sql = "select * from Cart_Shopping Where CartID = ? ORDER BY CreateAt DESC;";

		    PreparedStatement cmd = kn.cn.prepareStatement(sql);
		    cmd.setInt(1, getCartbyCustomerID(customerID));
		    ResultSet rs = cmd.executeQuery();
		
		    while(rs.next()) {
		    	int CartDetailID = rs.getInt("CartDetailID");
		    	int CartID = rs.getInt("CartID");
		    	int CustomerID  = rs.getInt("CustomerID");
		    	int ProductID  = rs.getInt("ProductID");
		    	String Size  = rs.getString("Size");
		    	int Quantity  = rs.getInt("Quantity");
		    	String Name  = rs.getString("Name");
//		    	Double NewPrice  = rs.getDouble("NewPrice");
		    	String Photo  = rs.getString("Photo");
//		    	Double Total  = rs.getDouble("Total");
		    	Double Discout  = rs.getDouble("DiscountPercentage");
		    	Double Price  = rs.getDouble("Price");
		    	Timestamp CreateAt = rs.getTimestamp("CreateAt");

		   	 ds.add(new Cart(CartDetailID, CartID, CustomerID, Size, Quantity, Name, Photo, Discout, Price, CreateAt, ProductID));
		    }rs.close();cmd.close();
	    }else {
	    	throw new Exception("Customer không tồn tại hoặc Token không hợp lệ.");

	    }
	    kn.cn.close();
		return ds;
	  }

	public int AddProductsToCart(String token , String size , int quantity ,int productID) throws Exception {
	    KetNoi kn = new KetNoi();
	    kn.ketNoi();
	    
	    int customerID = getUserByToken(token);
	    if(customerID > 0){
	    	int cartID = getCartbyCustomerID(customerID);
	    	if(cartID > 0) {
	    		String check = "SELECT * FROM CartDetails WHERE CartID = ? AND ProductID = ? AND Size = ?";
    			PreparedStatement checkCmd = kn.cn.prepareStatement(check);
    			
    			checkCmd.setInt(1, cartID);
    			checkCmd.setInt(2, productID);
    			checkCmd.setString(3, size);
    			
    			ResultSet chs = checkCmd.executeQuery();
    			if (chs.next()) {
    			    // Nếu sản phẩm và size trùng, cập nhật số lượng
    			    int currentQuantity = chs.getInt("Quantity");
    			    int newQuantity = currentQuantity + quantity; // 'quantity' là số lượng cần thêm

    			    String update = "UPDATE CartDetails SET Quantity = ? WHERE CartID = ? AND ProductID = ? AND Size = ?";
    			    PreparedStatement updateCmd = kn.cn.prepareStatement(update);

    			    updateCmd.setInt(1, newQuantity);
    			    updateCmd.setInt(2, cartID);
    			    updateCmd.setInt(3, productID);
    			    updateCmd.setString(4, size);

    			    int rowsUpdated = updateCmd.executeUpdate();
    			    kn.cn.close();
    			    if (rowsUpdated > 0) {
    			        return rowsUpdated;
    			    }else return 0;
    			} else {
    				String sql = "INSERT INTO CartDetails (CartID,ProductID,Quantity,Size,CreateAt) VALUES (?,?,?,?,GETDATE())";
        		    PreparedStatement insertCmd = kn.cn.prepareStatement(sql);
        			
        		    insertCmd.setInt(1, cartID);
        		    insertCmd.setInt(2, productID);
        		    insertCmd.setInt(3, quantity);
        		    insertCmd.setString(4, size);

        		    int rowsInserted = insertCmd.executeUpdate();
        		    kn.cn.close();
        		    if (rowsInserted > 0) {
        		        return 1; 
        		    } else {
        		        return 0; 
        		    }
    			}
	    		
	    		
	    	}
	    }else{
	    	throw new Exception("Thêm sản phẩm vào giỏ thất bại do Customer không tồn tại hoặc Token không hợp lệ.");
	    }    	
	    kn.cn.close();
		return 0;
	  }

	public int DeleteProductFromCart(int CartdetailID) throws Exception {
	    KetNoi kn = new KetNoi();
	    kn.ketNoi();
	    	    
		String sql = "DELETE FROM CartDetails WHERE CartDetailID = ?";
	    PreparedStatement deleteCmd = kn.cn.prepareStatement(sql);
		
	    deleteCmd.setInt(1, CartdetailID);


	    int rowsDeleted = deleteCmd.executeUpdate();
	    kn.cn.close();
	    if (rowsDeleted > 0) {
	        return 1; 
	    } else {
	        return 0; 
	    }

	  }

	public ArrayList<Cart> getSomeProductsInCart(String token, ArrayList<String> cartDetailIDList) throws Exception {
	    ArrayList<Cart> cartList = new ArrayList<Cart>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi();
	    
	    int customerID = getUserByToken(token);
	    
	    // Kiểm tra token hợp lệ, nếu không hợp lệ thì ném ngoại lệ
	    if (customerID <= 0) {
	        throw new Exception("Customer không tồn tại hoặc Token không hợp lệ.");
	    }
	    
	    for(String cartDetailIDStr : cartDetailIDList) {
	    	String sql = "SELECT * FROM Cart_Shopping WHERE CartDetailID = ?";
	    	PreparedStatement Cmd = kn.cn.prepareStatement(sql);
	    	Cmd.setInt(1, Integer.parseInt(cartDetailIDStr));

	        ResultSet rs = Cmd.executeQuery();
	        
	        while (rs.next()) {
	            int cartDetailID = rs.getInt("CartDetailID");
	            int cartID = rs.getInt("CartID");
	            int productID = rs.getInt("ProductID");
	            String size = rs.getString("Size");
	            int quantity = rs.getInt("Quantity");
	            String name = rs.getString("Name");
	            String photo = rs.getString("Photo");
	            double discount = rs.getDouble("DiscountPercentage");
	            double price = rs.getDouble("Price");
	            Timestamp createAt = rs.getTimestamp("CreateAt");

	            cartList.add(new Cart(cartDetailID, cartID, customerID, size, quantity, name, photo, discount, price, createAt, productID));
	        } rs.close();       
	    }kn.cn.close();

	    return cartList;
	}
	
	public void updateQuantityandSize(int cartDetailID , int quantity , String size)throws Exception {
		 KetNoi kn = new KetNoi();
		 kn.ketNoi();
		 
		 String sql = "UPDATE CartDetails\r\n"
		 		+ "SET Size = ?, Quantity = ?\r\n"
		 		+ "WHERE CartDetailID = ?;";
    	 PreparedStatement Cmd = kn.cn.prepareStatement(sql);
    	 Cmd.setString(1, size);
    	 Cmd.setInt(2,quantity );
    	 Cmd.setInt(3,cartDetailID );
    	 
    	 Cmd.executeUpdate();
//    	 System.out.println("rowsUpdated : " + rowsUpdated);
    	 kn.cn.close();
	}
}
