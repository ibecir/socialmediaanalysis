package ba.ibu.edu.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import ba.ibu.edu.dao.PersonRepository;
import ba.ibu.edu.helper.PasswordConversion;
import ba.ibu.edu.model.Person;

@Controller
public class LoginController {

	public static final String APP_ID = "1053360284704688";
	public static final String APP_SECRET = "5ff161f28bd46076fbc44a4cabe2b9a9";

	@Autowired
	private PersonRepository personDao;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getLogin(ModelMap model, HttpServletRequest request) {

		request.getSession();

		Cookie[] cookies = request.getCookies();
		boolean ctr = false;
		if (cookies != null) {
			for (Cookie c : cookies) {
				if (c.getName().equals("session")) {
					ctr = true;
				}
			}
			if (ctr == true) {
				return new ModelAndView("redirect:/sma/home");
			} else
				return new ModelAndView("login");
		} else {
			return new ModelAndView("login");
		}
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute Person person, ModelMap model, HttpServletResponse response) throws NoSuchAlgorithmException, IOException {

		Person p = personDao.login(person.getName(), PasswordConversion.hashPassword(person.getPassword()));

		if (p != null) {
			ModelAndView modelAndView = new ModelAndView("manage-categories");
			modelAndView.addObject("username", p.getName());
			modelAndView.addObject("userId", p.getId());
			Cookie cookieUid = new Cookie("session", p.getId());
			Cookie cookieSession = new Cookie("uname", p.getName());
			cookieUid.setMaxAge(20000);
			cookieSession.setMaxAge(20000);
			response.addCookie(cookieUid);
			response.addCookie(cookieSession);
			return new ModelAndView("redirect:/sma/home");
		} else {
			return new ModelAndView("login", "error", "Wrong username or password.");
		}
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public void logout(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
		Cookie[] cookies = request.getCookies();
		for (Cookie c : cookies) {
			c.setMaxAge(0);
			c.setValue("");
			response.addCookie(c);
		}
		response.sendRedirect("/");
	}

	@RequestMapping(value = "registration", method = RequestMethod.GET)
	public String registration(ModelMap model) {
		return "registration";
	}

}
