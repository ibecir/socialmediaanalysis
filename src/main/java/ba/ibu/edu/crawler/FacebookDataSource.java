package ba.ibu.edu.crawler;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import ba.ibu.edu.model.Category;
import ba.ibu.edu.model.DataSource;
import ba.ibu.edu.model.DataSourcePage;
import ba.ibu.edu.model.Keyword;
import ba.ibu.edu.model.Person;
import ba.ibu.edu.model.Synonym;

@Repository
public class FacebookDataSource {

	@Autowired
	private MongoTemplate mongoTemplate;

	private final String COLLECTION_NAME = "datasource";

	public FacebookDataSource() {

	}

	public DataSource getValidFacebookPagesByUserId(String userId) {

		Query query = new Query(Criteria.where("_id").is(userId));
		DataSource datasource = mongoTemplate.findOne(query, DataSource.class, COLLECTION_NAME);
		if (datasource.getFacebookPages() == null)
			return null;
		else {
			Iterator<DataSourcePage> dspIterator = datasource.getFacebookPages().iterator();
			while (dspIterator.hasNext()) {
				DataSourcePage dsp = dspIterator.next();
				if (dsp.getStatus() == 0) {
					dspIterator.remove();
				}
			}
		}
		return datasource;
	}

	public void setLastCrawledFeed(String userId, String pageId, String feedId) {
		Query query = new Query(Criteria.where("_id").is(userId).and("facebookPages").elemMatch(Criteria.where("_id").is(pageId)));
		mongoTemplate.updateFirst(query, new Update().set("facebookPages.$.lastSavedFeedId", feedId), DataSource.class, COLLECTION_NAME);
	}

	public Map<String, Map<String, String>> getCrawlCategoriesByUserId(String userId) {
		Map<String, Map<String, String>> mainMap = new HashMap<String, Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();

		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(userId.toString()));
		Person person = mongoTemplate.findOne(query, Person.class);
		System.out.println("Person is " + person.toString());
		try {

			categoryLoop: for (Iterator<Category> categoryIterator = person.getCategories().iterator(); categoryIterator.hasNext();) {
				map = new HashMap<String, String>();
				Category category = categoryIterator.next();
				if (category.categoryStatus == 0 || category.getCategoryName() == "") {
					categoryIterator.remove();
				} else {
					map.put(category.categoryId, category.categoryName);
					if (category.getKeywords() == null) {
						System.out.println(category.getCategoryName() + " is null");
						mainMap.put(category.getCategoryId(), map);
					} else {
						Iterator<Keyword> keywordIterator = category.getKeywords().iterator();
						while (keywordIterator.hasNext()) {
							Keyword keyword = keywordIterator.next();
							if (keyword.getKeywordStatus() == 0 || keyword.getKeywordName() == "") {
								keywordIterator.remove();
							} else {
								map.put(keyword.getKeywordId(), keyword.getKeywordName());
								if (keyword.getSynonyms() == null) {
									System.out.println(keyword.getKeywordName() + " has no sysnonyms");
								} else {
									Iterator<Synonym> synonymIterator = keyword.getSynonyms().iterator();
									while (synonymIterator.hasNext()) {
										Synonym synonym = synonymIterator.next();
										if (synonym.getSynonymStatus() == 0 || synonym.getSynonymName() == "") {
											synonymIterator.remove();
										} else {
											map.put(synonym.getSynonymId(), synonym.getSynonymName());
										}
									}
								}
							}
						}
					}
					mainMap.put(category.getCategoryId(), map);
					continue categoryLoop;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("There is no categories for " + userId);
		}

		return mainMap;
	}

	public List<DataSource> getAllUsersWithValidFacebookPages() {

		Query query = new Query();
		List<DataSource> datasource = mongoTemplate.find(query, DataSource.class, COLLECTION_NAME);
		Iterator<DataSource> dataSourceIterator = datasource.iterator();
		while (dataSourceIterator.hasNext()) {
			DataSource ds = dataSourceIterator.next();
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

	public void setMongoTemplate(MongoTemplate mongoTemplate2) {
		mongoTemplate = mongoTemplate2;
	}

}
