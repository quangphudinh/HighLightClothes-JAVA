package AdminModal;

public class AdminBO {
	AdminDAO adao = new AdminDAO();
	public Admin checkLogin (String email , String pass) throws Exception {
		return adao.checkLogin(email, pass);
	}
}
