package ba.ibu.edu.dao;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import ba.ibu.edu.model.Category;
import ba.ibu.edu.model.Keyword;
import ba.ibu.edu.model.Person;

@Repository
public class KeywordRepository {

	@Autowired
	private MongoTemplate mongoTemplate;

	public List<Person> getAllActiveKeywordsByCategoryId(String categoryId) {
		Query query = new Query();
		query.addCriteria(Criteria.where("categories.categoryId").is(categoryId));
		List<Person> person = mongoTemplate.find(query, Person.class);
		Iterator<Person> personIterator = person.iterator();
		while (personIterator.hasNext()) {
			Person p = personIterator.next();
			Iterator<Category> categoryIterator = p.getCategories().iterator();
			while (categoryIterator.hasNext()) {
				Category category = categoryIterator.next();
				if (!category.categoryId.equals(categoryId)) {
					categoryIterator.remove();
					continue;
				} else {
					if (category.getKeywords() == null) {
						break;
					} else {
						Iterator<Keyword> keywordIterator = category.getKeywords().iterator();
						while (keywordIterator.hasNext()) {
							Keyword keyword = keywordIterator.next();
							if (keyword.keywordStatus == 0)
								keywordIterator.remove();
						}
					}
				}
			}
		}
		return person;
	}

	public List<Person> getAllDeletedKeywordsByCategoryId(String categoryId) {
		Query query = new Query();
		query.addCriteria(Criteria.where("categories.categoryId").is(categoryId));
		List<Person> person = mongoTemplate.find(query, Person.class);
		Iterator<Person> personIterator = person.iterator();
		while (personIterator.hasNext()) {
			Person p = personIterator.next();
			Iterator<Category> categoryIterator = p.getCategories().iterator();
			while (categoryIterator.hasNext()) {
				Category category = categoryIterator.next();
				if (!category.categoryId.equals(categoryId)) {
					categoryIterator.remove();
					continue;
				}
				Iterator<Keyword> keywordIterator = category.getKeywords().iterator();
				while (keywordIterator.hasNext()) {
					Keyword keyword = keywordIterator.next();
					if (keyword.keywordStatus == 1)
						keywordIterator.remove();
				}

			}
		}
		return person;
	}

	public void addKeywordToCategory(String userId, String categoryId, List<Keyword> keywords) {
		Object[] keyword = keywords.toArray();
		mongoTemplate.updateFirst(
				Query.query(Criteria.where("_id").is(userId).and("categories.categoryId").is(categoryId)),
				new Update().pushAll("categories.$.keywords", keyword), Person.class);
		System.out.println("Everything is ok. Collection is updated");
	}

	public void deleteKeyword(String userId, String categoryId, String keywordId) {
		Query query = new Query(
				Criteria.where("categories._id").is(categoryId).and("categories.keywords._id").is(keywordId));

		int i = 0;
		int keywordPosition = 0;
		List<Person> person = mongoTemplate.find(query, Person.class);
		Iterator<Person> personIterator = person.iterator();
		while (personIterator.hasNext()) {
			Person p = personIterator.next();
			Iterator<Category> categoryIterator = p.getCategories().iterator();
			while (categoryIterator.hasNext()) {
				Category category = categoryIterator.next();
				if (!category.categoryId.equals(categoryId)) {
					categoryIterator.remove();
					continue;
				}
				Iterator<Keyword> keywordIterator = category.getKeywords().iterator();
				while (keywordIterator.hasNext()) {
					Keyword keyword = keywordIterator.next();
					if (keyword.keywordId.equals(keywordId)) {
						keywordPosition = i;
						System.out.println(keywordPosition);
						break;
					} else {
						i++;
					}
				}
			}
		}
		mongoTemplate.updateFirst(query,
				new Update().set("categories.$.keywords." + keywordPosition + ".keywordStatus", 0), Person.class);
	}

	public void restoreKeyword(String userId, String categoryId, String keywordId) {

		Query query = new Query(
				Criteria.where("categories._id").is(categoryId).and("categories.keywords._id").is(keywordId));

		int i = 0;
		int keywordPosition = 0;
		List<Person> person = mongoTemplate.find(query, Person.class);
		Iterator<Person> personIterator = person.iterator();
		while (personIterator.hasNext()) {
			Person p = personIterator.next();
			Iterator<Category> categoryIterator = p.getCategories().iterator();
			while (categoryIterator.hasNext()) {
				Category category = categoryIterator.next();
				if (!category.categoryId.equals(categoryId)) {
					categoryIterator.remove();
					continue;
				}
				Iterator<Keyword> keywordIterator = category.getKeywords().iterator();
				while (keywordIterator.hasNext()) {
					Keyword keyword = keywordIterator.next();
					if (keyword.keywordId.equals(keywordId)) {
						keywordPosition = i;
						System.out.println(keywordPosition);
						break;
					} else {
						i++;
					}
				}
			}
		}
		mongoTemplate.updateFirst(query,
				new Update().set("categories.$.keywords." + keywordPosition + ".keywordStatus", 1), Person.class);

	}

	public void changeKeywordName(String categoryId, String keywordId, String keywordName) {
		Query query = new Query(
				Criteria.where("categories._id").is(categoryId).and("categories.keywords._id").is(keywordId));

		int i = 0;
		int keywordPosition = 0;
		List<Person> person = mongoTemplate.find(query, Person.class);
		Iterator<Person> personIterator = person.iterator();
		while (personIterator.hasNext()) {
			Person p = personIterator.next();
			Iterator<Category> categoryIterator = p.getCategories().iterator();
			while (categoryIterator.hasNext()) {
				Category category = categoryIterator.next();
				if (!category.categoryId.equals(categoryId)) {
					categoryIterator.remove();
					continue;
				}
				Iterator<Keyword> keywordIterator = category.getKeywords().iterator();
				while (keywordIterator.hasNext()) {
					Keyword keyword = keywordIterator.next();
					if (keyword.keywordId.equals(keywordId)) {
						keywordPosition = i;
						System.out.println(keywordPosition);
						break;
					} else {
						i++;
					}
				}
			}
		}
		mongoTemplate.updateFirst(query,
				new Update().set("categories.$.keywords." + keywordPosition + ".keywordName", keywordName),
				Person.class);
	}

}
