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
import ba.ibu.edu.model.Synonym;

@Repository
public class SynonymRepository {

	@Autowired
	private MongoTemplate mongoTemplate;

	public void addSynonymsToKeyword(String userId, String categoryId, String keywordId, List<Synonym> synonyms) {
		Object[] synonym = synonyms.toArray();
		Query query = Query.query(Criteria.where("_id").is(userId).and("categories.categoryId").is(categoryId)
				.and("categories.keywords.keywordId").is(keywordId));
		List<Person> person = mongoTemplate.find(query, Person.class);

		int i = 0;
		int keywordPosition = 0;

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
						System.out.println(keyword.getKeywordId() + "###########" + keywordPosition);
						break;
					} else {
						i++;
					}
				}
			}
		}

		mongoTemplate.updateFirst(query,
				new Update().pushAll("categories.$.keywords." + keywordPosition + ".synonyms", synonym), Person.class);
		System.out.println("Everything is ok. Collection is updated");
	}

	public void deleteSynonym(String userId, String categoryId, String keywordId, String synonymId) {
		Query query = Query.query(Criteria.where("_id").is(userId).and("categories.categoryId").is(categoryId)
				.and("categories.keywords.keywordId").is(keywordId).and("categories.keywords.synonyms.synonymId")
				.is(synonymId));
		List<Person> person = mongoTemplate.find(query, Person.class);

		int i = 0;
		int j = 0;
		int keywordPosition = 0;
		int synonymPosition = 0;

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
						Iterator<Synonym> synonymIterator = keyword.getSynonyms().iterator();
						while (synonymIterator.hasNext()) {
							Synonym synonym = synonymIterator.next();
							if (synonym.getSynonymId().equals(synonymId)) {
								synonymPosition = j;
								break;
							} else {
								j++;
							}
						}
					} else {
						keywordIterator.remove();
						i++;
					}
				}
			}
		}

		mongoTemplate.updateFirst(query,
				new Update().set(
						"categories.$.keywords." + keywordPosition + ".synonyms." + synonymPosition + ".synonymStatus",
						0),
				Person.class);
		System.out.println("Everything is ok. Collection is updated");
	}

	public void restoreSynonym(String userId, String categoryId, String keywordId, String synonymId) {
		Query query = Query.query(Criteria.where("_id").is(userId).and("categories.categoryId").is(categoryId)
				.and("categories.keywords.keywordId").is(keywordId).and("categories.keywords.synonyms.synonymId")
				.is(synonymId));
		List<Person> person = mongoTemplate.find(query, Person.class);

		int i = 0;
		int j = 0;
		int keywordPosition = 0;
		int synonymPosition = 0;

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
						Iterator<Synonym> synonymIterator = keyword.getSynonyms().iterator();
						while (synonymIterator.hasNext()) {
							Synonym synonym = synonymIterator.next();
							if (synonym.getSynonymId().equals(synonymId)) {
								synonymPosition = j;
								break;
							} else {
								j++;
							}
						}
					} else {
						keywordIterator.remove();
						i++;
					}
				}
			}
		}

		mongoTemplate.updateFirst(query,
				new Update().set(
						"categories.$.keywords." + keywordPosition + ".synonyms." + synonymPosition + ".synonymStatus",
						1),
				Person.class);
		System.out.println("Everything is ok. Collection is updated");
	}

	public void changeSynonymName(String userId, String categoryId, String keywordId, String synonymId,
			String synonymName) {
		Query query = Query.query(Criteria.where("_id").is(userId).and("categories.categoryId").is(categoryId)
				.and("categories.keywords.keywordId").is(keywordId).and("categories.keywords.synonyms.synonymId")
				.is(synonymId));
		List<Person> person = mongoTemplate.find(query, Person.class);

		int i = 0;
		int j = 0;
		int keywordPosition = 0;
		int synonymPosition = 0;

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
						Iterator<Synonym> synonymIterator = keyword.getSynonyms().iterator();
						while (synonymIterator.hasNext()) {
							Synonym synonym = synonymIterator.next();
							if (synonym.getSynonymId().equals(synonymId)) {
								synonymPosition = j;
								break;
							} else {
								j++;
							}
						}
					} else {
						keywordIterator.remove();
						i++;
					}
				}
			}
		}

		mongoTemplate.updateFirst(query,
				new Update().set(
						"categories.$.keywords." + keywordPosition + ".synonyms." + synonymPosition + ".synonymName",
						synonymName),
				Person.class);
		System.out.println("Everything is ok. Collection is updated");
	}

	public List<Person> getAllActiveSynonymsOfKeyword(String userId, String categoryId, String keywordId) {

		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(userId).and("categories.categoryId").is(categoryId)
				.and("categories.keywords.keywordId").is(keywordId));
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
							if (!keyword.keywordId.equals(keywordId)) {
								keywordIterator.remove();
								continue;
							} else {
								if (keyword.getSynonyms() == null) {
									break;
								} else {
									Iterator<Synonym> synonymIterator = keyword.getSynonyms().iterator();
									while (synonymIterator.hasNext()) {
										Synonym synonym = synonymIterator.next();
										if (synonym.getSynonymStatus() == 0) {
											synonymIterator.remove();
										}
									}
								}
							}
						}
					}
				}
			}
		}
		return person;

	}

	public List<Person> getAllDeletedSynonymsOfKeyword(String userId, String categoryId, String keywordId) {

		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(userId).and("categories.categoryId").is(categoryId)
				.and("categories.keywords.keywordId").is(keywordId));
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
							if (!keyword.keywordId.equals(keywordId)) {
								keywordIterator.remove();
								continue;
							} else {
								if (keyword.getSynonyms() == null) {
									break;
								} else {
									Iterator<Synonym> synonymIterator = keyword.getSynonyms().iterator();
									while (synonymIterator.hasNext()) {
										Synonym synonym = synonymIterator.next();
										if (synonym.getSynonymStatus() == 1) {
											synonymIterator.remove();
										}
									}
								}
							}
						}
					}
				}
			}
		}
		return person;

	}
}
