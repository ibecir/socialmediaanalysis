package ba.ibu.edu.crawler;

import java.util.Map;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

import ba.ibu.edu.model.DataSource;

@Repository
public class Crawler implements Runnable {

	private String user;
	private FacebookDataSource fbDataSource;
	private CategorizeEngine ce;

	public Crawler() {
	}

	public Crawler(MongoTemplate mongoTemplate, String user) {
		this.user = user;
		fbDataSource = new FacebookDataSource();
		fbDataSource.setMongoTemplate(mongoTemplate);
		ce = new CategorizeEngine();
		ce.setMongoTemplate(mongoTemplate);
	}

	@Override
	public void run() {
		System.out.println("Thread of " + user + " has been started");
		DataSource ds = fbDataSource.getValidFacebookPagesByUserId(user);
		Map<String, Map<String, String>> categories = fbDataSource.getCrawlCategoriesByUserId(user);
		System.out.println(categories.size());
		ce.categorize(ds, categories);
	}

}
