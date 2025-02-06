package CartsShoppingModal;

import java.util.ArrayList;

public class CartBO {
	ArrayList<Cart> cs;
	CartDAO cdao = new CartDAO();
	
	public ArrayList<Cart> getCartProducts(String token) throws Exception{
	    cs = cdao.getCartProducts(token);
		return cs;
	}
	public int AddProductsToCart(String token , String size , int quantity ,int productID) throws Exception {
		return cdao.AddProductsToCart(token, size, quantity, productID);
	}
	public int DeleteProductFromCart(int cartDetailID) throws Exception {
		return cdao.DeleteProductFromCart(cartDetailID);
	}
	public ArrayList<Cart> getSomeProductsInCart(String token, ArrayList<String> cartDetailIDList) throws Exception {
		cs = cdao.getSomeProductsInCart(token, cartDetailIDList);
		return cs;
	}
	public void updateQuantityandSize(int cartDetailID , int quantity , String size)throws Exception {
		cdao.updateQuantityandSize(cartDetailID, quantity, size);
		return;
	}
	
	
}
