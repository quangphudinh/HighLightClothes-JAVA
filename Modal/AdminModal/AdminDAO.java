package AdminModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ketnoimodal.KetNoi;

public class AdminDAO {

	public Admin checkLogin (String email , String pass) throws Exception {
		KetNoi kn = new KetNoi();
	    kn.ketNoi();

	    String sql = "select * from Admins where Email = ? and Password = ? ";

	    PreparedStatement cmd = kn.cn.prepareStatement(sql);
	    cmd.setString(1, email);
	    cmd.setString(2, pass);
	    ResultSet rs = cmd.executeQuery();
	    Admin ad = new Admin();
	    if(rs.next()) {
	    	int id = rs.getInt("AdminID");
	    	String name = rs.getString("Name");
	    	String emai = rs.getString("Email");
	    	String role = rs.getString("Role");
	    
	    	ad.setAdminID(id);
    	    ad.setAdminName(name);
    	    ad.setEmail(emai);
    	    ad.setRole(role);
	    }
	    kn.cn.close();
		return ad;
	  }
}
