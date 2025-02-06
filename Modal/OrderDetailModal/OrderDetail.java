package OrderDetailModal;

public class OrderDetail {
	private int invoiceID;
	private int invoiceDetailID;
	private int productId;
	private String productName;
	private int quantity;
	private double price;
	private double subtotal;
	private String status;
	private String image;
	private String size;
	
	public OrderDetail() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OrderDetail(int invoiceID, int productId, String productName, int quantity, double price, double subtotal,
			String status, String image, int invoiceDetailID ,String size) {
		super();
		this.invoiceID = invoiceID;
		this.productId = productId;
		this.productName = productName;
		this.quantity = quantity;
		this.price = price;
		this.subtotal = subtotal;
		this.status = status;
		this.image = image;
		this.invoiceDetailID = invoiceDetailID;
		this.size = size;
	}

	public int getInvoiceDetailID() {
		return invoiceDetailID;
	}

	public void setInvoiceDetailID(int invoiceDetailID) {
		this.invoiceDetailID = invoiceDetailID;
	}

	public int getInvoiceID() {
		return invoiceID;
	}

	public void setInvoiceID(int invoiceID) {
		this.invoiceID = invoiceID;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
	
	
}
