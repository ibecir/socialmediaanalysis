package ba.ibu.edu.dao;

import java.util.ArrayList;
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

import ba.ibu.edu.helper.StringMap;
import ba.ibu.edu.model.Category;
import ba.ibu.edu.model.Person;

@Repository
public class CategoryRepository {

	@Autowired
	public MongoTemplate mongoTemplate;

	public static final String COLLECTION_NAME = "person";

	public void addCategoriesToPerson(String id, List<Category> category) {
		Object[] categories = category.toArray();
		mongoTemplate.updateFirst(Query.query(Criteria.where("_id").is(id)), new Update().pushAll("categories", categories), Person.class);
		System.out.println("Everything is ok. Collection is updated");
	}

	public List<Person> getAllCategoriesWithValidStatusByUserId(String id) {
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(id).and("categories.categoryStatus").is(1).and("categories").elemMatch(Criteria.where("categoryStatus").is(1)));
		List<Person> person = mongoTemplate.find(query, Person.class);
		Iterator<Person> personIterator = person.iterator();
		while (personIterator.hasNext()) {
			Person p = personIterator.next();
			Iterator<Category> categoryIterator = p.getCategories().iterator();
			while (categoryIterator.hasNext()) {
				Category category = categoryIterator.next();
				if (category.categoryStatus == 0 || category.getCategoryName() == "") {
					categoryIterator.remove();
				}
			}
		}
		return person;
	}

	public List<Person> allCategories(String id) {
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(id));
		List<Person> person = mongoTemplate.find(query, Person.class);

		return person;
	}

	public void deleteCategoryById(String categoryId) {

		Query query = new Query(Criteria.where("categories").elemMatch(Criteria.where("categoryId").is(categoryId)));
		mongoTemplate.updateFirst(query, new Update().set("categories.$.categoryStatus", 0), Person.class);
	}

	public void restoreCategory(String categoryId) {
		Query query = new Query(Criteria.where("categories").elemMatch(Criteria.where("categoryId").is(categoryId)));
		mongoTemplate.updateFirst(query, new Update().set("categories.$.categoryStatus", 1), Person.class);

	}

	public void changeCategoryName(String categoryId, String categoryName) {
		Query query = new Query(Criteria.where("categories").elemMatch(Criteria.where("categoryId").is(categoryId)));
		mongoTemplate.updateFirst(query, new Update().set("categories.$.categoryName", categoryName), Person.class);
	}

	public List<Person> getAllDeletedCategoriesByUserId(String userId) {
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(userId).and("categories.categoryStatus").is(0).and("categories").elemMatch(Criteria.where("categoryStatus").is(0)));
		List<Person> person = mongoTemplate.find(query, Person.class);
		Iterator<Person> personIterator = person.iterator();
		while (personIterator.hasNext()) {
			Person p = personIterator.next();
			Iterator<Category> categoryIterator = p.getCategories().iterator();
			while (categoryIterator.hasNext()) {
				Category category = categoryIterator.next();
				if (category.categoryStatus == 1 || category.getCategoryName() == "") {
					categoryIterator.remove();
				}
			}
		}
		return person;
	}

	public List<StringMap> getCategoriesWithValidStatus(String userId) {
		List<StringMap> smap = new ArrayList<>();
		Category category = new Category();
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(userId).and("categories.categoryStatus").is(1).and("categories").elemMatch(Criteria.where("categoryStatus").is(1)));
		Person person = mongoTemplate.findOne(query, Person.class, "person");
		Iterator<Category> categoryIterator = person.getCategories().iterator();
		while (categoryIterator.hasNext()) {
			category = categoryIterator.next();
			if (category.categoryStatus == 1) {
				smap.add(new StringMap(category.categoryId, category.categoryName));
			}
		}
		return smap;
	}

}