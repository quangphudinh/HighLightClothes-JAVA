package CustomerModal;

import java.sql.Date;

public class CustomerBO {
	CustomerDAO cdao = new CustomerDAO();
	
	public Customer getCustomer(String token) throws Exception{
		return cdao.getCustomer(token);
	}
	
	public String checkLogin(String name , String pass) throws Exception {
		return cdao.checkLogin(name, pass);
	}
	
	public int checkEmail(String email) throws Exception {
		return cdao.checkEmail(email);
	}
	
	public int addCustomer(String Name,String Email, String Phone,String Address,String Password,Boolean Gender,String Avatar,Date BirthDay) throws Exception {
		return cdao.addCustomer(Name, Email, Phone, Address, Password, Gender, Avatar, BirthDay);
	}
	public int updateCustomer(String token, String email ,String name,String address , String phone ,Boolean gender,String photo ,Date birthday) throws Exception {
		return cdao.updateCustomer(token, email, name, address, phone, gender, photo, birthday);
	}
	
	public int getCustomerIDByToken(String token) throws Exception{
		return cdao.getCustomerIDByToken(token);
	}
}
