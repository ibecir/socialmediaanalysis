package ba.ibu.edu.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import ba.ibu.edu.model.Feed;

@Repository
public class FeedRepository {

	@Autowired
	private MongoTemplate mongoTemplate;
	public static final String COLLECTION_NAME = "categorizedfeeds";

	public List<Feed> searchFeedsByCategoryIdAndKeyword(String userId, String categoryId, String keyword, int skipFeeds) {
		Query query = new Query().addCriteria(Criteria.where("user_id").is(userId).and("categoryId").is(categoryId).and("feedKeywords").is(keyword)).skip(skipFeeds).limit(200);
		query.fields().exclude("_id").exclude("user_id").exclude("feedKeywords").exclude("type").exclude("categoryId").exclude("criteriaId");
		List<Feed> feeds = mongoTemplate.find(query, Feed.class, COLLECTION_NAME);
		if (feeds.isEmpty())
			return new ArrayList<>();
		else
			return feeds;
	}

	public List<Feed> searchFeedsByCategoryId(String userId, String categoryId, int skipFeeds) {
		Query query = new Query().addCriteria(Criteria.where("user_id").is(userId).and("categoryId").is(categoryId)).skip(skipFeeds).limit(200);
		query.fields().exclude("_id").exclude("user_id").exclude("feedKeywords").exclude("type").exclude("categoryId").exclude("criteriaId");
		List<Feed> feeds = mongoTemplate.find(query, Feed.class, COLLECTION_NAME);
		if (feeds.isEmpty())
			return new ArrayList<>();
		else
			return feeds;
	}

	public List<Feed> searchFeedsByKeyword(String userId, String keyword, int skipFeeds) {
		Query query = new Query().addCriteria(Criteria.where("user_id").is(userId).and("feedKeywords").is(keyword)).skip(skipFeeds).limit(200);
		query.fields().exclude("_id").exclude("user_id").exclude("feedKeywords").exclude("type").exclude("categoryId").exclude("criteriaId");
		List<Feed> feeds = mongoTemplate.find(query, Feed.class, COLLECTION_NAME);
		if (feeds.isEmpty())
			return new ArrayList<>();
		else
			return feeds;
	}

}
