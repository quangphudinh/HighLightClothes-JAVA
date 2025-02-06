package OrderModal;


public class Order {
	private int InvoiceID;
	private String customerName;
	private String orderDate;
	private String finishDate;
	private String status;
	private double total;
	public Order() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Order(int invoiceID, String customerName, String orderDate, String status, double total ,String finishDate) {
		super();
		InvoiceID = invoiceID;
		this.customerName = customerName;
		this.orderDate = orderDate;
		this.status = status;
		this.total = total;
		this.finishDate = finishDate;
	}
	public String getFinishDate() {
		return finishDate;
	}
	public void setFinishDate(String finishDate) {
		this.finishDate = finishDate;
	}
	public int getInvoiceID() {
		return InvoiceID;
	}
	public void setInvoiceID(int invoiceID) {
		InvoiceID = invoiceID;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	
	
}
