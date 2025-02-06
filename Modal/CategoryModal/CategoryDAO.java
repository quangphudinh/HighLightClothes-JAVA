package CategoryModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ketnoimodal.KetNoi;

public class CategoryDAO {
	
	public ArrayList<Category> getCategories() throws Exception {
		ArrayList<Category> ds = new ArrayList<Category>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    String sql = "select * from Categories ORDER BY Name ASC;";

	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	     int CategoryID = rs.getInt("CategoryID");
	   	 String Name = rs.getString("Name");
	   	 String Description = rs.getString("Description");
	   	 
	   	 ds.add(new Category(CategoryID,Name,Description));
	    }rs.close();
	    kn.cn.close();
		return ds;
	  }
	
	public ArrayList<Category> searchCategories(String name) throws Exception {
		ArrayList<Category> ds = new ArrayList<Category>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    String sql = "SELECT * FROM Categories WHERE Name LIKE CONCAT('%', ? , '%');";

	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
	    cmd.setString(1, name);
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	     int CategoryID = rs.getInt("CategoryID");
	   	 String Name = rs.getString("Name");
	   	 String Description = rs.getString("Description");
	   	 
	   	 ds.add(new Category(CategoryID,Name,Description));
	    }rs.close();
	    kn.cn.close();
		return ds;
	  }

	public int checkName(String name)throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String sqlCheckName = "select count(*) from Categories where Name = ?";
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
	
	public int addCategory(String name,String des,Date createAt) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();    	
	    
	    String sql = "INSERT INTO Categories (Name, Description, CreateAt) VALUES (?,?,?)";
	    PreparedStatement insertCmd = kn.cn.prepareStatement(sql);
		
	    insertCmd.setString(1, name);
	    insertCmd.setString(2, des);
	    insertCmd.setDate(3, createAt);
	    
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
	
	public Category getOneCategory(int categoryID) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String sql = "select * from Categories where CategoryID = ?";
		PreparedStatement cmd = kn.cn.prepareStatement(sql);
		cmd.setInt(1, categoryID);
		
		ResultSet rs = cmd.executeQuery();
		Category prd = new Category();
		while(rs.next()) {
			int CategoryID = rs.getInt("CategoryID");
			String Name = rs.getString("Name");
			String Description = rs.getString("Description");
		
			prd = new Category(CategoryID , Name, Description);
		}
		
		kn.cn.close();
		return prd;
		
	}
	
	public int updateCategory(int categoryID,String name,String des) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();    	
	    
	    String sql = "update Categories set	Name = ? , Description = ? where CategoryID = ?";
	    PreparedStatement insertCmd = kn.cn.prepareStatement(sql);
		
	    insertCmd.setString(1, name);
	    insertCmd.setString(2, des);
	    insertCmd.setInt(3, categoryID);
   
	    int rowsInserted = insertCmd.executeUpdate();
	    kn.cn.close();

	    // Trả về kết quả
	    if (rowsInserted > 0) {
	        return 1; 
	    } else {
	        return 0; 
	    }
	}
	
	public Boolean deleteCategory(int categoryID)throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String deleteSql = "Delete FROM Categories WHERE CategoryID = ?";
		PreparedStatement deletecmd = kn.cn.prepareStatement(deleteSql);
		deletecmd.setInt(1, categoryID);
		
	    int rowsDeleted = deletecmd.executeUpdate();
	    kn.cn.close();

	    if (rowsDeleted > 0) {
	        return true;
	    } else {
	        return false;
	    }
	}
	
	public int IsUseCategoryInProducts (int categoryID) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String checkIsUseSql = "SELECT COUNT(*) FROM Products WHERE CategoryID = ?";
		PreparedStatement cmd = kn.cn.prepareStatement(checkIsUseSql);
		cmd.setInt(1, categoryID);
		
		ResultSet rs = cmd.executeQuery();
	    int count = 0;
	    if (rs.next()) {
	        count = rs.getInt(1);
	    }
	    kn.cn.close();
	    return count;
	}
}
