package CategoryModal;

import java.sql.Date;
import java.util.ArrayList;

public class CategoryBO {
	CategoryDAO cdao = new CategoryDAO();
	ArrayList<Category> ds;
	
	public ArrayList<Category> getCategories() throws Exception{
		ds = cdao.getCategories();
		return ds;
	}
	
	public ArrayList<Category> searchCategories(String name) throws Exception{
		ds = cdao.searchCategories(name);
		return ds;
	}
	
	public int checkName(String name) throws Exception {
		return cdao.checkName(name);
	}
	
	public int addCategory(String name , String Des , Date createAt) throws Exception {
		return cdao.addCategory(name, Des, createAt);
	}
	
	public Category getOneCategory(int categoryID) throws Exception {
		return cdao.getOneCategory(categoryID);
	}
	
	public int updateCategory(int categoryID , String name , String des)throws Exception {
		return cdao.updateCategory(categoryID, name, des);
	}
	
	public int IsUseCategoryInProducts(int categoryID) throws Exception {
		return cdao.IsUseCategoryInProducts(categoryID);
	}
	
	public Boolean deleteCategory(int categoryID) throws Exception{
		return cdao.deleteCategory(categoryID);
	}
}
