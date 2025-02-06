package CustomerModal;

import java.sql.Timestamp;
import java.util.Date;

public class Customer {
	private int CustomerID;
	private String Name;
	private String Email;
	private String Phone;
	private String Address;
	private String Password;
	private Boolean Gender;
	private String Avatar;
	private Date BirthDay;
	private Timestamp CreateAt;
	private String Token;
	
	public Customer(int customerID, String name, String email, String phone, String address, String password,
			Boolean gender, String avatar, Date birthDay, Timestamp createAt, String token) {
		super();
		CustomerID = customerID;
		Name = name;
		Email = email;
		Phone = phone;
		Address = address;
		Password = password;
		Gender = gender;
		Avatar = avatar;
		BirthDay = birthDay;
		CreateAt = createAt;
		Token = token;
	}
	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getCustomerID() {
		return CustomerID;
	}
	public void setCustomerID(int customerID) {
		CustomerID = customerID;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		Phone = phone;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public Boolean getGender() {
		return Gender;
	}
	public void setGender(Boolean gender) {
		Gender = gender;
	}
	public String getAvatar() {
		return Avatar;
	}
	public void setAvatar(String avatar) {
		Avatar = avatar;
	}
	public Date getBirthDay() {
		return BirthDay;
	}
	public void setBirthDay(Date birthDay) {
		BirthDay = birthDay;
	}
	public Timestamp getCreateAt() {
		return CreateAt;
	}
	public void setCreateAt(Timestamp createAt) {
		CreateAt = createAt;
	}
	public String getToken() {
		return Token;
	}
	public void setToken(String token) {
		Token = token;
	}
	
}
