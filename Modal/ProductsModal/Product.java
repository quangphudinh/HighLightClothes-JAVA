package ProductsModal;

import java.sql.Timestamp;

public class Product {
	private int ProductID ;
	private String Name;
	private String Description;
	private Double price;
	private int Stock;
	private int CategoryID;
	private int PromotionID;
	private Boolean Status;
	private String Photo;
	private Timestamp CreateAt;
	public Product(int productID , String name, String description, Double price, int stock, int categoryID,
			int promotionID, Boolean status, String photo, Timestamp createAt) {
		super();
		ProductID = productID;
		Name = name;
		Description = description;
		this.price = price;
		Stock = stock;
		CategoryID = categoryID;
		PromotionID = promotionID;
		Status = status;
		Photo = photo;
		CreateAt = createAt;
	}
	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getProductID() {
		return ProductID;
	}
	public void setProductID(int productID) {
		ProductID = productID;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public int getStock() {
		return Stock;
	}
	public void setStock(int stock) {
		Stock = stock;
	}
	public int getCategoryID() {
		return CategoryID;
	}
	public void setCategoryID(int categoryID) {
		CategoryID = categoryID;
	}
	public int getPromotionID() {
		return PromotionID;
	}
	public void setPromotionID(int promotionID) {
		PromotionID = promotionID;
	}
	public Boolean getStatus() {
		return Status;
	}
	public void setStatus(Boolean status) {
		Status = status;
	}
	public String getPhoto() {
		return Photo;
	}
	public void setPhoto(String photo) {
		Photo = photo;
	}
	public Timestamp getCreateAt() {
		return CreateAt;
	}
	public void setCreateAt(Timestamp createAt) {
		CreateAt = createAt;
	}
	
}
