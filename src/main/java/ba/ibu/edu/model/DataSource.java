package ba.ibu.edu.model;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class DataSource {

	@Id
	public String userId;
	List<DataSourcePage> facebookPages;

	public DataSource() {

	}

	public DataSource(String userId) {
		super();
		this.userId = userId;
	}

	public DataSource(String userId, List<DataSourcePage> facebookPages) {
		super();
		this.userId = userId;
		this.facebookPages = facebookPages;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public List<DataSourcePage> getFacebookPages() {
		return facebookPages;
	}

	public void setFacebookPages(List<DataSourcePage> facebookPages) {
		this.facebookPages = facebookPages;
	}

	@Override
	public String toString() {
		return String.format("Id is # %s #", userId);
	}

}
