package PromotionModal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ketnoimodal.KetNoi;

public class PromotionDAO {
	public ArrayList<Promotion> getPromotions() throws Exception {
		ArrayList<Promotion> ds = new ArrayList<Promotion>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    String sql = "select * from Promotions order by StartDate";
   
	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	     int PromotionID = rs.getInt("PromotionID");
	   	 String Name = rs.getString("Name");
	   	 Double Discount = rs.getDouble("DiscountPercentage");
	   	 Date StartDate = rs.getDate("StartDate");
	   	 Date EndDate = rs.getDate("EndDate");
	   	 
	   	 ds.add(new Promotion(PromotionID,Name,Discount,StartDate,EndDate));
	    }rs.close();
	    kn.cn.close();
		return ds;
	   }
	
	public ArrayList<Promotion> searchPromotions(String name, Date startDate , Date endDate) throws Exception {
		ArrayList<Promotion> ds = new ArrayList<Promotion>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi(); 
	    
	    String sql;
	    PreparedStatement cmd ;
	    
	    if(name == null) {
	    	if(endDate != null && startDate != null){
	    		sql = "SELECT * FROM Promotions WHERE StartDate >= ? AND EndDate <= ?";
		    	cmd = kn.cn.prepareStatement(sql);
			    cmd.setDate(1, startDate);
			    cmd.setDate(2, endDate);
	    	}else {
	    		if(startDate != null) {
	    			sql = "SELECT * FROM Promotions WHERE StartDate >= ?";
			    	cmd = kn.cn.prepareStatement(sql);
				    cmd.setDate(1, startDate);
	    		}else {
	    			sql = "SELECT * FROM Promotions WHERE EndDate <= ?";
			    	cmd = kn.cn.prepareStatement(sql);
				    cmd.setDate(1, endDate);
	    		}
	    	}	
	    }else {
	    	if(endDate != null && startDate != null){
	    		sql = "SELECT * FROM Promotions WHERE StartDate >= ? AND EndDate <= ? AND Name LIKE CONCAT('%', ?, '%')";
		    	cmd = kn.cn.prepareStatement(sql);
			    cmd.setDate(1, startDate);
			    cmd.setDate(2, endDate);
			    cmd.setString(3, name);
	    	}else {
	    		if(startDate != null) {
	    			sql = "SELECT * FROM Promotions WHERE StartDate >= ? AND Name LIKE CONCAT('%', ?, '%')";
			    	cmd = kn.cn.prepareStatement(sql);
				    cmd.setDate(1, startDate);
				    cmd.setString(2, name);
	    		}else {
	    			sql = "SELECT * FROM Promotions WHERE EndDate <= ? AND Name LIKE CONCAT('%', ?, '%')";
			    	cmd = kn.cn.prepareStatement(sql);
				    cmd.setDate(1, endDate);
				    cmd.setString(2, name);
	    		}
	    	}	
	    }
    
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	    	int PromotionID = rs.getInt("PromotionID");
		   	 String Name = rs.getString("Name");
		   	 Double Discount = rs.getDouble("DiscountPercentage");
		   	 Date StartDate = rs.getDate("StartDate");
		   	 Date EndDate = rs.getDate("EndDate");
	   	 
	   	 ds.add(new Promotion(PromotionID,Name,Discount,StartDate,EndDate));
	    }rs.close();
	    kn.cn.close();
		return ds;
	  }
	
	public ArrayList<Promotion> getAvailablePromotion() throws Exception {
		ArrayList<Promotion> ds = new ArrayList<Promotion>();

	    KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    String sql = "SELECT * FROM Promotions WHERE Enddate > GETDATE() ORDER BY EndDate;";
   
	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
	    ResultSet rs = cmd.executeQuery();
	
	    while(rs.next()) {
	     int PromotionID = rs.getInt("PromotionID");
	   	 String Name = rs.getString("Name");
	   	 Double Discount = rs.getDouble("DiscountPercentage");
	   	 Date StartDate = rs.getDate("StartDate");
	   	 Date EndDate = rs.getDate("EndDate");
	   	 
	   	 ds.add(new Promotion(PromotionID,Name,Discount,StartDate,EndDate));
	    }rs.close();
	    kn.cn.close();
		return ds;
	   }
	
	public int checkName(String name)throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String sqlCheckName = "select count(*) from Promotions where Name = ?";
		PreparedStatement checkCmd = kn.cn.prepareStatement(sqlCheckName);
		
	    checkCmd.setString(1, name);

	    ResultSet rs = checkCmd.executeQuery();
	    int count = 0;
	    if (rs.next()) {
	        count = rs.getInt(1); // Lấy số lượng bản ghi trùng tên
	    }
	    kn.cn.close();
	    return count;
	}
	
	public int addPromotion(String name,Double discount,Date startDate, Date endDate) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();    	
	    
	    String sql = "INSERT INTO Promotions (Name, DiscountPercentage, StartDate , EndDate) VALUES (?,?,?,?)";
	    PreparedStatement insertCmd = kn.cn.prepareStatement(sql);
		
	    insertCmd.setString(1, name);
	    insertCmd.setDouble(2, discount);
	    insertCmd.setDate(3, startDate);
	    insertCmd.setDate(4, endDate);
	    
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

	public int updatePromotion(int promotionID,String name,Double discount,Date startDate, Date endDate) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();    	
	    
	    String sql = "update Promotions set	Name = ? , DiscountPercentage = ? , StartDate = ? , EndDate = ? where PromotionID = ?";
	    PreparedStatement updateCmd = kn.cn.prepareStatement(sql);
		
	    updateCmd.setString(1, name);
	    updateCmd.setDouble(2, discount);
	    updateCmd.setDate(3, startDate);
	    updateCmd.setDate(4, endDate);
	    updateCmd.setInt(5, promotionID);
	    
	    int rows = updateCmd.executeUpdate();
	    kn.cn.close();

	    // Trả về kết quả
	    if (rows > 0) {
	        return 1; 
	    } else {
	        return 0; 
	    }
	}
	
	public Boolean deletePromotion (int promotionID)throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String deleteSql = "Delete FROM Promotions WHERE PromotionID = ?";
		PreparedStatement deletecmd = kn.cn.prepareStatement(deleteSql);
		deletecmd.setInt(1, promotionID);
		
	    int rowsDeleted = deletecmd.executeUpdate();
	    kn.cn.close();

	    if (rowsDeleted > 0) {
	        return true;
	    } else {
	        return false;
	    }
	}
	
	public int IsUsePromotionInProducts (int promotionID) throws Exception {
		KetNoi kn = new KetNoi();
		kn.ketNoi();
		
		String checkIsUseSql = "SELECT COUNT(*) FROM Products WHERE PromotionID = ?";
		PreparedStatement cmd = kn.cn.prepareStatement(checkIsUseSql);
		cmd.setInt(1, promotionID);
		
		ResultSet rs = cmd.executeQuery();
	    int count = 0;
	    if (rs.next()) {
	        count = rs.getInt(1);
	    }
	    kn.cn.close();
	    return count;
	}
	
	
}
