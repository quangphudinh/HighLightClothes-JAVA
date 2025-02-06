package ProductsModal;

import java.sql.Timestamp;
import java.util.ArrayList;

public class ProductBO {
 ProductDAO pdao = new ProductDAO();
 ArrayList<Product> ds;
 
 public void resetPromotion() throws Exception {
	 pdao.resetPromotion();
	 return;
 }
 
 public ArrayList<Product> getProducts() throws Exception{
	 ds=pdao.getProducts();
	 return ds;
 }
 
 public ArrayList<Product> getSortProducts(String categoryID, String name , String price , String date)throws Exception {
	 return pdao.getSortProducts(categoryID, name, price, date);
 }
 
 public ArrayList<Product> searchProducts(String categoryID , String key) throws Exception{
	 ds=pdao.searchProducts(categoryID, key);
	 return ds;
 }
 
 public int checkName(String name)throws Exception {
	 int tam = pdao.checkName(name);
	 return tam;
 }
 
 public Product getOneProduct(int productID) throws Exception {
	 return pdao.getOneProduct(productID);
 }
 
 public int addProduct(String name,String des,Double price,int stock,int categoryID,int promotionID,Boolean status,String photo,Timestamp createAt) throws Exception  {
	 int tam = pdao.addProduct(name, des, price, stock, categoryID, promotionID, status, photo, createAt);
	 return tam;
 }
 
 public int updateProduct(int productID,String name,String des,Double price,int stock,int categoryID,int promotionID,Boolean status,String photo) throws Exception  {
	 int tam = pdao.updateProduct(productID,name,des,price,stock,categoryID,promotionID,status,photo);
	 return tam;
 }
 
 public Boolean deleteProduct(int productID) throws Exception {
	 return pdao.deleteProduct(productID);
 }
 
 public Boolean checkProductinInvoiceDetail(int productID) throws Exception {
	 int tam = pdao.checkProductInInvoiceDetails(productID);
	 if(tam > 0) return true;
	 return false;
 }
 
 public ArrayList<Product> getProductsByPage(int page, int pageSize) throws Exception{
	 return pdao.productPagination(page, pageSize);
 }
 
 public int getTotalProducts() throws Exception {
	 return pdao.getTotalProducts();
 }
 
 public int getTotalProductsBySearch(String categoryID, String key) throws Exception {
	 return pdao.getTotalProductsBySearch(categoryID, key);
 }
 
 public ArrayList<Product> searchProductsByPage(String categoryID, String key, int page, int pageSize)throws Exception {
	 return pdao.searchProductsByPage(categoryID, key, page, pageSize);
 }
 
 
}