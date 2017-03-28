package ba.ibu.edu.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ba.ibu.edu.dao.CategoryRepository;
import ba.ibu.edu.helper.Serialize;
import ba.ibu.edu.helper.StringMap;
import ba.ibu.edu.model.Category;
import ba.ibu.edu.model.Person;

@Controller
public class CategoryController {

	@Autowired
	private CategoryRepository categoryDao;

	@RequestMapping(value = "/sma/home", method = RequestMethod.GET)
	public ModelAndView home(ModelMap model, HttpServletRequest request) {
		Cookie[] cookie = request.getCookies();
		boolean exists = false;
		String userId = "";
		String username = "";
		for (Cookie c : cookie) {
			if (c.getName().equals("session")) {
				exists = true;
				userId = c.getValue();
			} else if (c.getName().equals("uname")) {
				exists = true;
				username = c.getValue();
			}
		}
		if (exists == false) {
			return new ModelAndView("redirect:/");
		} else {
			ModelAndView modelAndView = new ModelAndView("user-home");
			modelAndView.addObject("userId", userId);
			modelAndView.addObject("username", username);
			return modelAndView;
		}
	}

	@RequestMapping(value = "/sma/categories", method = RequestMethod.GET)
	public @ResponseBody List<Person> categories(ModelMap model) {
		return categoryDao.allCategories("8a9f005c-a982-44cc-abb4-44af37dbb47a");
	}

	@RequestMapping(value = "/sma/get-categories", method = RequestMethod.GET)
	public @ResponseBody List<StringMap> categories(ModelMap model, HttpServletRequest request) {
		String userId = "";
		for (Cookie c : request.getCookies()) {
			if (c.getName().equals("session"))
				userId = c.getValue();
		}
		return categoryDao.getCategoriesWithValidStatus(userId);
	}

	@RequestMapping(value = "/sma/deleted-categories", method = RequestMethod.GET)
	public ModelAndView getDeletedCategoriesView(ModelMap model, HttpServletRequest request) {

		Cookie[] cookie = request.getCookies();
		boolean exists = false;
		String userId = "";
		String username = "";
		for (Cookie c : cookie) {
			if (c.getName().equals("session")) {
				exists = true;
				userId = c.getValue();
			} else if (c.getName().equals("uname")) {
				exists = true;
				username = c.getValue();
			}
		}
		if (exists == false) {
			return new ModelAndView("redirect:/");
		} else {
			ModelAndView modelAndView = new ModelAndView("deleted-categories");
			modelAndView.addObject("userId", userId);
			modelAndView.addObject("username", username);
			return modelAndView;
		}
	}

	@RequestMapping(value = "/sma/active-categories", method = RequestMethod.GET)
	public ModelAndView getActiveCategoriesView(ModelMap model, HttpServletRequest request) {

		Cookie[] cookie = request.getCookies();
		boolean exists = false;
		String userId = "";
		String username = "";
		for (Cookie c : cookie) {
			if (c.getName().equals("session")) {
				exists = true;
				userId = c.getValue();
			} else if (c.getName().equals("uname")) {
				exists = true;
				username = c.getValue();
			}
		}
		if (exists == false) {
			return new ModelAndView("redirect:/");
		} else {
			ModelAndView modelAndView = new ModelAndView("manage-categories");
			modelAndView.addObject("userId", userId);
			modelAndView.addObject("username", username);
			return modelAndView;
		}
	}

	@RequestMapping(value = "/sma/activecategories", method = RequestMethod.GET)
	public @ResponseBody Serialize getAllActiveCategories(ModelMap model, @ModelAttribute("userId") String userId) {
		Serialize serializedObj = new Serialize();
		serializedObj.setElements(categoryDao.getAllCategoriesWithValidStatusByUserId(userId));
		System.out.println("Obj is " + serializedObj.getElements());
		return serializedObj;
	}

	@RequestMapping(value = "/sma/deletedcategories", method = RequestMethod.GET)
	public @ResponseBody Serialize getAllCategories(ModelMap model, @ModelAttribute("userId") String userId) {
		Serialize serializedObj = new Serialize();
		serializedObj.setElements(categoryDao.getAllDeletedCategoriesByUserId(userId));
		System.out.println("Obj is DELETED CATEGORIES " + serializedObj.getElements());
		return serializedObj;
	}

	@RequestMapping(value = "/sma/addcategory", method = RequestMethod.POST)
	@ResponseBody
	public void addCategory(ModelMap modelMap, @ModelAttribute("userId") String userId, @ModelAttribute("categoryName") String categoryName) {

		List<Category> categories = new ArrayList<Category>();

		if (categoryName.length() != 0) {
			List<String> rawCategories = Arrays.asList(categoryName.split(","));
			for (String category : rawCategories) {
				String trimedCategoryName = category.replaceAll("\\s", "");
				categories.add(new Category(UUID.randomUUID().toString(), trimedCategoryName, 1));
			}
			categoryDao.addCategoriesToPerson(userId, categories);
		} else {
			System.out.println("Empty");
			modelMap.put("error", "Please fill field");
		}
	}

	@RequestMapping(value = "/sma/deleteCategory", method = RequestMethod.POST)
	@ResponseBody
	public void deleteCategory(ModelMap modelMap, @ModelAttribute("categoryId") String categoryId) {
		categoryDao.deleteCategoryById(categoryId);
	}

	@RequestMapping(value = "/sma/categoryName", method = RequestMethod.POST)
	@ResponseBody
	public void changeCtegoryNsme(ModelMap modelMap, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("categoryName") String categoryName) {
		categoryDao.changeCategoryName(categoryId, categoryName);
	}

	@RequestMapping(value = "/sma/restoreCategory", method = RequestMethod.POST)
	@ResponseBody
	public void restoreCategory(ModelMap modelMap, @ModelAttribute("categoryId") String categoryId) {
		categoryDao.restoreCategory(categoryId);
	}
}
