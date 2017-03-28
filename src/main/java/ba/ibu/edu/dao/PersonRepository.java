package ba.ibu.edu.dao;

import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import ba.ibu.edu.helper.PasswordConversion;
import ba.ibu.edu.model.Person;

@Repository
public class PersonRepository {

	@Autowired
	public MongoTemplate mongoTemplate;

	public static final String COLLECTION_NAME = "person";

	public void addPerson(Person person) throws NoSuchAlgorithmException {
		if (!mongoTemplate.collectionExists(Person.class)) {
			mongoTemplate.createCollection(Person.class);
		}

		String password = PasswordConversion.hashPassword(person.getPassword());

		person.setPassword(password);

		mongoTemplate.insert(person, COLLECTION_NAME);
	}

	public List<Person> listPerson() {
		System.out.println("IN METHOD");
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").exists(true));
		List<Person> pers = mongoTemplate.find(query, Person.class);
		System.out.println("Persons are " + pers.toString());
		return pers;
	}

	public void deletePerson(Person person) {
		mongoTemplate.remove(person, COLLECTION_NAME);
	}

	public void updatePerson(Person person) {
		mongoTemplate.insert(person, COLLECTION_NAME);
	}

	public Person login(String username, String password) {
		Query query = new Query();
		query.addCriteria(Criteria.where("name").is(username).and("password").is(password)).fields()
				.exclude("categories");

		Person p = mongoTemplate.findOne(query, Person.class);

		if (p != null) {
			System.out.println("Found and obj is " + p.toString());
			return p;
		} else {
			System.out.println("No requested object.");
			return null;
		}
	}

	public List<Person> getPerson(String string) {
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(string));
		return mongoTemplate.find(query, Person.class);
	}
}
