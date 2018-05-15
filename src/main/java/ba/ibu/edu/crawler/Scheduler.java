package ba.ibu.edu.crawler;

import java.util.List;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import ba.ibu.edu.model.DataSource;

@Repository
public class Scheduler {

	private MongoTemplate mongoTemplate;
	private final String COLLECTION_NAME = "datasource";

	public MongoTemplate getMongoTemplate() {
		return mongoTemplate;
	}

	public void setMongoTemplate(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
	}

	public Scheduler() {
		System.out.println("Default run");
	}

	
	public void startCrawler() {
		System.out.println("Crawler started from startCrawler method");
		List<DataSource> allUsers = getAllUsersToCrawl();
		for (DataSource dataSource : allUsers) {
			System.out.println("Creating new thread");
			Thread thread = new Thread(new Crawler(mongoTemplate, dataSource.getUserId()));
			thread.start();
		}
	}
	

	public List<DataSource> getAllUsersToCrawl() {
		Query query = new Query();
		query.fields().include("_id");
		List<DataSource> datasource = mongoTemplate.find(query, DataSource.class, COLLECTION_NAME);
		return datasource;
	}

}
