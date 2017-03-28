package ba.ibu.edu.model;

import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;

public class Feed {

	@Id
	public String id;
	public String user_id;
	public String feedId;
	public String message;
	public List<String> feedKeywords;
	public Date dateOfCreation;
	public String url;
	public String source;
	public String type;
	public String fb_userid;
	public String userName;
	public List<String> categoryId;
	public List<String> criteriaId;

	public Feed(String id, String user_id, String feedId, String message, List<String> feedKeywords, Date dateOfCreation, String url, String source, String type, String fb_userid, String userName, List<String> categoryId, List<String> criteriaId) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.feedId = feedId;
		this.message = message;
		this.feedKeywords = feedKeywords;
		this.dateOfCreation = dateOfCreation;
		this.url = url;
		this.source = source;
		this.type = type;
		this.fb_userid = fb_userid;
		this.userName = userName;
		this.categoryId = categoryId;
		this.criteriaId = criteriaId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getFeedId() {
		return feedId;
	}

	public void setFeedId(String feedId) {
		this.feedId = feedId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<String> getFeedKeywords() {
		return feedKeywords;
	}

	public void setFeedKeywords(List<String> feedKeywords) {
		this.feedKeywords = feedKeywords;
	}

	public Date getDateOfCreation() {
		return dateOfCreation;
	}

	public void setDateOfCreation(Date dateOfCreation) {
		this.dateOfCreation = dateOfCreation;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUserId() {
		return fb_userid;
	}

	public void setUserId(String fb_userid) {
		this.fb_userid = fb_userid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public List<String> getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(List<String> categoryId) {
		this.categoryId = categoryId;
	}

	public List<String> getCriteriaId() {
		return criteriaId;
	}

	public void setCriteriId(List<String> criteriaId) {
		this.criteriaId = criteriaId;
	}

}
