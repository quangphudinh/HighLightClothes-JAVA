package AdminModal;

public class Admin {
	private int AdminID;
	private String AdminName;
	private String Email;
	private String Password;
	private String Role;
	public Admin() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Admin(int adminID, String adminName, String email, String password, String role) {
		super();
		AdminID = adminID;
		AdminName = adminName;
		Email = email;
		Password = password;
		Role = role;
	}
	public int getAdminID() {
		return AdminID;
	}
	public void setAdminID(int adminID) {
		AdminID = adminID;
	}
	public String getAdminName() {
		return AdminName;
	}
	public void setAdminName(String adminName) {
		AdminName = adminName;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public String getRole() {
		return Role;
	}
	public void setRole(String role) {
		Role = role;
	}
	
	
}
