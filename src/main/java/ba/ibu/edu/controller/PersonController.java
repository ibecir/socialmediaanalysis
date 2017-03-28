package ba.ibu.edu.controller;

import java.security.NoSuchAlgorithmException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import ba.ibu.edu.dao.DataSourceRepository;
import ba.ibu.edu.dao.PersonRepository;
import ba.ibu.edu.model.DataSource;
import ba.ibu.edu.model.Person;

@Controller
public class PersonController {

	@Autowired
	private PersonRepository personDao;

	@Autowired
	private DataSourceRepository dataSourceDao;

	@RequestMapping(value = "/sma/person", method = RequestMethod.GET)
	public String getPersonList(ModelMap model) {
		model.addAttribute("personList", personDao.listPerson());
		return "manage-users";
	}

	@RequestMapping(value = "/sma/user", method = RequestMethod.GET)
	public String getUserHomepage(ModelMap model) {
		return "manage-categories";
	}

	@RequestMapping(value = "/person/save", method = RequestMethod.POST)
	public View createPerson(@ModelAttribute Person person, ModelMap model) throws NoSuchAlgorithmException {
		person.setId(UUID.randomUUID().toString());
		System.out.println(person.toString());
		DataSource ds = new DataSource(person.getId());
		personDao.addPerson(person);
		dataSourceDao.addPersonToCollection(ds);
		return new RedirectView("/socialmediaanalysis/");
	}

	@RequestMapping(value = "/sma/person/delete", method = RequestMethod.GET)
	public View deletePerson(@ModelAttribute Person person, ModelMap model) {
		dataSourceDao.deletePersonFromCollection(new DataSource(person.getId()));
		personDao.deletePerson(person);

		return new RedirectView("/socialmediaanalysis/person");
	}
}
