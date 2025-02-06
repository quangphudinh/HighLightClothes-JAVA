package CategoryModal;

public class Category {
	private int CategoryID;
	private String Name;
	private String Description;
	public Category() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Category(int categoryID, String name, String description) {
		super();
		CategoryID = categoryID;
		Name = name;
		Description = description;
	}
	public int getCategoryID() {
		return CategoryID;
	}
	public void setCategoryID(int categoryID) {
		CategoryID = categoryID;
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
	
	
}
