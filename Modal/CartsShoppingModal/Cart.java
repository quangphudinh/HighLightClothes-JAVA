package CartsShoppingModal;

import java.sql.Timestamp;

public class Cart {
	private int CartDetailID;
	private int CartID;
	private int CustomerID;
	private int ProductID;
	private String Size;
	private int Quantity;
	private String Name ;
	private Double NewPrice;
	private String Photo;
	private Double Total;
	private Double Discout;
	private Double Price;
	private Timestamp CreateAt;
	public Cart() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Cart(int cartDetailID, int cartID, int customerID, String size, int quantity, String name, String photo,
			Double discout, Double price, Timestamp createAt ,int productID) {
		super();
		CartDetailID = cartDetailID;
		CartID = cartID;
		CustomerID = customerID;
		ProductID = productID;
		Size = size;
		Quantity = quantity;
		Name = name;
		Photo = photo;
		Discout = discout;
		Price = price;
		NewPrice = price - (price * discout / 100);
		Total =  (price - (price * discout / 100)) * quantity;
		CreateAt = createAt;
	}
	public int getProductID() {
		return ProductID;
	}
	public void setProductID(int productID) {
		ProductID = productID;
	}
	public int getCartDetailID() {
		return CartDetailID;
	}
	public void setCartDetailID(int cartDetailID) {
		CartDetailID = cartDetailID;
	}
	public int getCartID() {
		return CartID;
	}
	public void setCartID(int cartID) {
		CartID = cartID;
	}
	public int getCustomerID() {
		return CustomerID;
	}
	public void setCustomerID(int customerID) {
		CustomerID = customerID;
	}
	public String getSize() {
		return Size;
	}
	public void setSize(String size) {
		Size = size;
	}
	public int getQuantity() {
		return Quantity;
	}
	public void setQuantity(int quantity) {
		Quantity = quantity;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public Double getNewPrice() {
		return Price - (Price * Discout / 100);
	}
	public void setNewPrice(Double newPrice) {
		NewPrice = newPrice;
	}
	public String getPhoto() {
		return Photo;
	}
	public void setPhoto(String photo) {
		Photo = photo;
	}
	public Double getTotal() {
		return NewPrice * Quantity;
	}
	public void setTotal(Double total) {
		Total = total;
	}
	public Double getDiscout() {
		return Discout;
	}
	public void setDiscout(Double discout) {
		Discout = discout;
	}
	public Double getPrice() {
		return Price;
	}
	public void setPrice(Double price) {
		Price = price;
	}
	public Timestamp getCreateAt() {
		return CreateAt;
	}
	public void setCreateAt(Timestamp createAt) {
		CreateAt = createAt;
	}
	
	
}
