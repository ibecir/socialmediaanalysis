package ba.ibu.edu.helper;

import java.util.List;

public class DateCategoryMap {

	public String _id;
	public List<StringIntMap> categories;

	public DateCategoryMap(String _id, List<StringIntMap> categories) {
		super();
		this._id = _id;
		this.categories = categories;
	}

	public String get_id() {
		return _id;
	}

	public void set_id(String _id) {
		this._id = _id;
	}

	public List<StringIntMap> getCategories() {
		return categories;
	}

	public void setCategories(List<StringIntMap> categories) {
		this.categories = categories;
	}

}
