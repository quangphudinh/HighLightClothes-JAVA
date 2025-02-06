package InvoicesModal;

import java.sql.Timestamp;

public class Invoice {
	private int InvoiceDetailID;
	private int InvoiceID;
	private int ProductID;
	private int CustomerID;
	private int Quantity;
	private String size;
	private Double Price;
	private String Status;
	private String Ttdh;
	private String Name;
	private String Photo;
	private Timestamp CreateAt;
	private Timestamp FinishTime;
	
	public Invoice() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Invoice(int invoiceDetailID, int invoiceID, int productID, int customerID, int quantity, String size,
			Double price, String status, String name, String photo, Timestamp createAt ,Timestamp finishTime  , String ttdh) {
		super();
		InvoiceDetailID = invoiceDetailID;
		InvoiceID = invoiceID;
		ProductID = productID;
		CustomerID = customerID;
		Quantity = quantity;
		this.size = size;
		Price = price;
		Status = status;
		Name = name;
		Photo = photo;
		CreateAt = createAt;
		FinishTime = finishTime;
		Ttdh = ttdh;
	}
	public String getTtdh() {
		return Ttdh;
	}
	public void setTtdh(String ttdh) {
		Ttdh = ttdh;
	}
	public Timestamp getFinishTime() {
		return FinishTime;
	}
	public void setFinishTime(Timestamp finishTime) {
		FinishTime = finishTime;
	}
	public int getInvoiceDetailID() {
		return InvoiceDetailID;
	}
	public void setInvoiceDetailID(int invoiceDetailID) {
		InvoiceDetailID = invoiceDetailID;
	}
	public int getInvoiceID() {
		return InvoiceID;
	}
	public void setInvoiceID(int invoiceID) {
		InvoiceID = invoiceID;
	}
	public int getProductID() {
		return ProductID;
	}
	public void setProductID(int productID) {
		ProductID = productID;
	}
	public int getCustomerID() {
		return CustomerID;
	}
	public void setCustomerID(int customerID) {
		CustomerID = customerID;
	}
	public int getQuantity() {
		return Quantity;
	}
	public void setQuantity(int quantity) {
		Quantity = quantity;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public Double getPrice() {
		return Price;
	}
	public void setPrice(Double price) {
		Price = price;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
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
