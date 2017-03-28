package ba.ibu.edu.dao;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.FacebookClient.AccessToken;
import com.restfb.Version;
import com.restfb.types.Page;

import ba.ibu.edu.model.DataSource;
import ba.ibu.edu.model.DataSourcePage;

@Repository
public class DataSourceRepository {

	@Autowired
	private MongoTemplate mongoTemplate;
	public static final String COLLECTION_NAME = "datasource";
	public static final String APP_ID = "1053360284704688";
	public static final String APP_SECRET = "5ff161f28bd46076fbc44a4cabe2b9a9";

	public List<DataSource> getAllFacebookPagesWithValidStatusByUserId(String userId) {
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(userId));
		List<DataSource> datasource = mongoTemplate.find(query, DataSource.class, COLLECTION_NAME);
		Iterator<DataSource> dataSourceIterator = datasource.iterator();
		while (dataSourceIterator.hasNext()) {
			DataSource ds = dataSourceIterator.next();
			System.out.println("Hamdija ga sejva " + ds.toString());
			if (ds.getFacebookPages() == null)
				break;
			else {
				Iterator<DataSourcePage> dspIterator = ds.getFacebookPages().iterator();
				while (dspIterator.hasNext()) {
					DataSourcePage dsp = dspIterator.next();
					if (dsp.getStatus() == 0) {
						dspIterator.remove();
					}
				}
			}
		}
		return datasource;
	}

	public List<DataSource> getAllDeletedFacebookPagesByUserId(String userId) {
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(userId));
		List<DataSource> datasource = mongoTemplate.find(query, DataSource.class, COLLECTION_NAME);
		Iterator<DataSource> dataSourceIterator = datasource.iterator();
		while (dataSourceIterator.hasNext()) {
			DataSource ds = dataSourceIterator.next();
			Iterator<DataSourcePage> dspIterator = ds.getFacebookPages().iterator();
			while (dspIterator.hasNext()) {
				DataSourcePage dsp = dspIterator.next();
				System.out.println(dsp.name);
				if (dsp.getStatus() == 1) {
					dspIterator.remove();
				}
			}
		}
		return datasource;
	}

	public boolean isFacebookPageValid(String userId, String url) {
		AccessToken token = new DefaultFacebookClient(Version.LATEST).obtainAppAccessToken(APP_ID, APP_SECRET);
		FacebookClient newClient = new DefaultFacebookClient(token.getAccessToken(), Version.LATEST);

		try {
			int index = url.lastIndexOf('/');
			String pageName = url.substring(index + 1, url.length());
			System.out.println(pageName);
			if (newClient.fetchObject(pageName, Page.class) != null) {
				addFacebookPage(userId, url, pageName);
				return true;
			} else
				return false;
		} catch (Exception e) {
			System.out.println("This is not a page. Please give valid link to facebook page.");
			return false;
		}
	}

	public void addFacebookPage(String userId, String url, String pageName) {
		List<DataSourcePage> page = Arrays.asList(new DataSourcePage(UUID.randomUUID().toString(), url, pageName, 1, "recentlyAdded"));
		Object[] newPage = page.toArray();
		mongoTemplate.updateFirst(Query.query(Criteria.where("_id").is(userId)), new Update().pushAll("facebookPages", newPage), COLLECTION_NAME);
		System.out.println("Everything is ok. Collection is updated");
	}

	public void addPersonToCollection(DataSource ds) {
		mongoTemplate.insert(ds, COLLECTION_NAME);
	}

	public void deletePersonFromCollection(DataSource ds) {
		mongoTemplate.remove(ds, COLLECTION_NAME);
	}

	public void deleteFacebookPageById(String userId, String pageId) {
		Query query = new Query(Criteria.where("_id").is(userId).and("facebookPages").elemMatch(Criteria.where("_id").is(pageId)));
		mongoTemplate.updateFirst(query, new Update().set("facebookPages.$.status", 0), DataSource.class, COLLECTION_NAME);
	}

	public void restoreFacebookPageById(String userId, String pageId) {
		Query query = new Query(Criteria.where("_id").is(userId).and("facebookPages").elemMatch(Criteria.where("_id").is(pageId)));
		mongoTemplate.updateFirst(query, new Update().set("facebookPages.$.status", 1), DataSource.class, COLLECTION_NAME);
	}

}
