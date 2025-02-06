package InvoicesModal;

import java.util.ArrayList;

import CartsShoppingModal.Cart;
import OrderDetailModal.OrderDetail;
import OrderModal.Order;

public class InvoiceBO {
	InvoiceDAO idao = new InvoiceDAO();
	
	public ArrayList<Integer> getListInvoiceID(String token) throws Exception {
		return idao.getListInvoiceID(token);
	}
	
	public ArrayList<Invoice> getListInvoiceDetail() throws Exception {
		return idao.getListInvoiceDetail();
	}
	
	public void CreateNewInvoice(ArrayList<Cart> cartDetails) throws Exception{
		idao.CreateNewInvoice(cartDetails);
		return;
	}
	
	//Admin
	public ArrayList<Integer> getListInvoiceID() throws Exception {
		return idao.getListInvoiceID();
	}
	public ArrayList<Order> GetListOrder(ArrayList<Integer> invoiceIds) throws Exception{
		return idao.GetListOrder(invoiceIds);
	}
	public ArrayList<OrderDetail> GetListOrderDetails() throws Exception {
		return idao.GetListOrderDetails();
	}
	public int CancelInvoce(int invoiceID) throws Exception{
		return idao.CancelInvoce(invoiceID);
	}
	
	public ArrayList<Order> GetListOrderHistory(ArrayList<Integer> invoiceIds) throws Exception {
		return idao.GetListOrderHistory(invoiceIds);
	}
	public int AcceptInvoce(int invoiceID , ArrayList<Integer> invoiceDetailID) throws Exception{
		return idao.AcceptInvoce(invoiceID, invoiceDetailID);
	}
}
