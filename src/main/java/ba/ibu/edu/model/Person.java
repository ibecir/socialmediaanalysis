package ba.ibu.edu.model;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Person {

	@Id
	public String id;
	public String name;
	public String password;
	public String firstName;
	public String lastName;
	public String email;
	public List<Category> categories;

	public Person() {

	}

	public Person(String id, String name, String password, List<Category> categories) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.categories = categories;
	}

	public Person(String id, String name, String password, String firstName, String lastName, String email, List<Category> categories) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.categories = categories;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	@Override
	public String toString() {
		return String.format("Id is # %s # and Username is # %s # and Password is # %s # and fname is # %s # and lname is # %s # and email is # %s #. End of OBJ #", id, name, password, firstName, lastName, email);
	}

}
