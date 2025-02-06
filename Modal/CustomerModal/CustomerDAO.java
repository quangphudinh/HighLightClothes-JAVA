package CustomerModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ketnoimodal.KetNoi;

public class CustomerDAO {
	
	public String checkLogin (String email , String pass) throws Exception {
		KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    String sql = "select * from Customers where Email = ? and Password = ? ";

	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
	    cmd.setString(1, email);
	    cmd.setString(2, pass);
	    ResultSet rs = cmd.executeQuery();
	    String temp = null;
	    if(rs.next()) {
	    	temp = rs.getString("Token");
	    }
	    kn.cn.close();
		return temp;
	  }
	
	public Customer getCustomer(String token) throws Exception {
	    Customer ctm = new Customer();
	    KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    // Cập nhật câu lệnh SQL để không lấy trường Password và Token
	    String sql = "SELECT CustomerID, Name, Email, Phone, Address, Gender, Avatar, BirthDay, CreateAt FROM Customers WHERE Token = ?";

	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
	    cmd.setString(1, token);  // Set token vào câu lệnh SQL
	    ResultSet rs = cmd.executeQuery();

	    if (rs.next()) {
	        // Lấy các trường cần thiết và thiết lập vào đối tượng Customer
	        ctm.setCustomerID(rs.getInt("CustomerID"));
	        ctm.setName(rs.getString("Name"));
	        ctm.setEmail(rs.getString("Email"));
	        ctm.setPhone(rs.getString("Phone"));
	        ctm.setAddress(rs.getString("Address"));
	        ctm.setGender(rs.getBoolean("Gender"));
	        ctm.setAvatar(rs.getString("Avatar"));
	        ctm.setBirthDay(rs.getDate("BirthDay"));
	        ctm.setCreateAt(rs.getTimestamp("CreateAt"));
	    } rs.close();
	    
	    String checkCartSql = "SELECT * FROM Cart WHERE CustomerID = " + ctm.getCustomerID();
	    PreparedStatement cmdCart = kn.cn.prepareStatement(checkCartSql);
	    ResultSet cs = cmdCart.executeQuery();
	    int count = 0;
	    if (cs.next()) {
	        count = cs.getInt(1);
	    } cs.close();
	    
//	    System.out.println(count);
//	    System.out.println(ctm.getCustomerID());
	    
	    if(count == 0) {
	        String insertCartSql = "INSERT INTO Cart (CustomerID, CreatedAt) VALUES (?, GETDATE());";
	        PreparedStatement cmdInsertCart = kn.cn.prepareStatement(insertCartSql);
	        cmdInsertCart.setInt(1, ctm.getCustomerID());
	        int rowsAffected = cmdInsertCart.executeUpdate();

	        if (rowsAffected > 0) {
	            System.out.println("Cart record inserted successfully.");
	        } else {
	            System.out.println("No record was inserted.");
	        }
	        cmdInsertCart.close();
	    }
	    
	    kn.cn.close();
	    return ctm;
	}

	public int checkEmail (String email) throws Exception {
		KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    String sql = "select count(*) from Customers where Email = ? ";

	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
	    cmd.setString(1, email);

	    ResultSet rs = cmd.executeQuery();
	    int count = 0;
	    if (rs.next()) {
	        count = rs.getInt(1); // Lấy số lượng bản ghi trùng teen san pham
	    }
	    kn.cn.close();
	    return count;
	  }
	
	public int updateCustomer(String token, String email ,String name,String address , String phone ,Boolean gender,String photo ,Date birthday) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();    	
	    
	    String sql = "update Customers\r\n"
	    		+ "set\r\n"
	    		+ "	Name = ?,\r\n"
	    		+ "	Email = ?,\r\n"
	    		+ "	Phone = ?,\r\n"
	    		+ "	Address = ?,\r\n"
	    		+ "	Gender = ?,\r\n"
	    		+ "	Avatar = ?,\r\n"
	    		+ "	BirthDay = ?\r\n"
	    		+ "where Token = ?";
	    PreparedStatement updateCmd = kn.cn.prepareStatement(sql);
		
	    updateCmd.setString(1, name);
	    updateCmd.setString(2, email);
	    updateCmd.setString(3, phone);
	    updateCmd.setString(4, address);
	    updateCmd.setBoolean(5, gender);
	    updateCmd.setString(6, photo);
	    updateCmd.setDate(7, birthday); 
	    updateCmd.setString(8, token);

	    int rowsUpdate = updateCmd.executeUpdate();
	    kn.cn.close();
	    if (rowsUpdate > 0) {
	        return 1; 
	    } else {
	        return 0; 
	    }
	}

	public int addCustomer(String Name,String Email, String Phone,String Address,String Password,Boolean Gender,String Avatar,Date BirthDay) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();    	
	    
	    String sql = "INSERT INTO Customers (Name, Email, Phone, Address, Password, Gender, Avatar, BirthDay, CreateAt, Token)\r\n"
	    		+ "VALUES (?,?,?,?,?,?,?,?,GETDATE(), NEWID());";
	    PreparedStatement insertCmd = kn.cn.prepareStatement(sql);
		
	    insertCmd.setString(1, Name);
	    insertCmd.setString(2, Email);
	    insertCmd.setString(3, Phone);
	    insertCmd.setString(4, Address);
	    insertCmd.setString(5, Password);
	    insertCmd.setBoolean(6, Gender);
	    insertCmd.setString(7, Avatar);
	    insertCmd.setDate(8, BirthDay);
	    
	    // Thực hiện câu lệnh thêm sách
	    int rowsInserted = insertCmd.executeUpdate();

	    // Đóng kết nối
	    kn.cn.close();

	    // Trả về kết quả
	    if (rowsInserted > 0) {
	        return 1; 
	    } else {
	        return 0; 
	    }
	}
	
	public int getCustomerIDByToken(String token) throws Exception {
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
}
