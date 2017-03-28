package ba.ibu.edu.model;

import java.util.List;

import org.springframework.data.annotation.Id;

public class Category {

	@Id
	public String categoryId;
	public String categoryName;
	public int categoryStatus;
	public List<Keyword> keywords;

	public Category() {
	}

	public Category(String categoryId, String categoryName, int categoryStatus) {
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.categoryStatus = categoryStatus;
	}

	public Category(String categoryId, String categoryName, int categoryStatus, List<Keyword> keywords) {
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.categoryStatus = categoryStatus;
		this.keywords = keywords;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getCategoryStatus() {
		return categoryStatus;
	}

	public void setCategoryStatus(int categoryStatus) {
		this.categoryStatus = categoryStatus;
	}

	public List<Keyword> getKeywords() {
		return keywords;
	}

	public void setKeywords(List<Keyword> keywords) {
		this.keywords = keywords;
	}

	@Override
	public String toString() {
		return String.format("Id is # %s # and categoryName is # %s # and categoryStatus is # %d #. End of OBJ #",
				categoryId, categoryName, categoryStatus);
	}

}
