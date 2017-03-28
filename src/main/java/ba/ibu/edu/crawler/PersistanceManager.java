package ba.ibu.edu.crawler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.mongodb.BasicDBList;

import ba.ibu.edu.model.DataSource;
import ba.ibu.edu.model.Feed;

@Repository
public class PersistanceManager {

	@Autowired
	private MongoTemplate mongoTemplate;

	private final String COLLECTION_NAME_ = "categorizedfeeds";
	private final String COLLECTION_NAME = "datasource";

	public PersistanceManager() {
	}

	public void setMongoTemplate(MongoTemplate mongoTemplateSet) {
		mongoTemplate = mongoTemplateSet;
	}

	public void saveFeeds(List<Feed> feeds) {
		System.out.println("CALLED FOR INSERT");
		BasicDBList d = new BasicDBList();
		d.addAll(feeds);
		mongoTemplate.insert(d, COLLECTION_NAME_);
	}

	public void setLastCrawledFeed(String userId, String pageId, String feedId) {
		Query query = new Query(Criteria.where("_id").is(userId).and("facebookPages").elemMatch(Criteria.where("_id").is(pageId)));
		mongoTemplate.updateFirst(query, new Update().set("facebookPages.$.lastSavedFeedId", feedId), DataSource.class, COLLECTION_NAME);
		System.out.println("OK");
	}

	public List<String> getFeedKeywords(String message) {
		String trimedMessage = message.replaceAll("\\p{P}", " ").toLowerCase().trim().replaceAll("(\\s)+", "$1");
		String[] feeds = trimedMessage.split(" ");
		List<String> feedKeywords = new ArrayList<>();
		for (String s : feeds) {
			if (s.length() > 3 && !feedKeywords.contains(s)) {
				feedKeywords.add(s);
			}
		}
		return feedKeywords;
	}

	public DataSource getLastCrawlFeedId(String userId, String pageId) {
		Query query = new Query(Criteria.where("_id").is(userId).and("facebookPages").elemMatch(Criteria.where("lastSavedFeedId").is(pageId)));
		DataSource pg = mongoTemplate.findOne(query, DataSource.class, COLLECTION_NAME);
		System.out.println("OK");
		return pg;
	}
}
