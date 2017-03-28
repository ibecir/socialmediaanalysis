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

import ba.ibu.edu.dao.KeywordRepository;
import ba.ibu.edu.helper.Serialize;
import ba.ibu.edu.model.Keyword;

@Controller
public class KeywordController {

	@Autowired
	private KeywordRepository keywordDao;

	@RequestMapping(value = "/sma/category-keywords", method = RequestMethod.GET)
	public ModelAndView getKeywordsAndSynonmsOfCategory(@ModelAttribute("categoryId") String categoryId, @ModelAttribute("categoryName") String categoryName, HttpServletRequest request) {
		Cookie[] cookie = request.getCookies();
		boolean exists = false;
		String userId = "";
		String username = "";
		for (Cookie c : cookie) {
			if (c.getName().equals("session") && !c.getValue().equals("")) {
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
			ModelAndView modelAndView = new ModelAndView("category-keywords");
			modelAndView.addObject("userId", userId);
			modelAndView.addObject("categoryId", categoryId);
			modelAndView.addObject("categoryName", categoryName);
			return modelAndView;
		}

	}

	@RequestMapping(value = "/sma/addkeywords", method = RequestMethod.POST)
	@ResponseBody
	public void addKeywordsToCategory(ModelMap modelMap, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywords") String nameOfKeywords) {

		List<Keyword> keywords = new ArrayList<Keyword>();

		if (nameOfKeywords.length() != 0) {
			List<String> rawKeywords = Arrays.asList(nameOfKeywords.split(","));
			for (String keyword : rawKeywords) {
				String trimedKeywordName = keyword.replaceAll("\\s", "");
				keywords.add(new Keyword(UUID.randomUUID().toString(), trimedKeywordName, 1));
			}
			keywordDao.addKeywordToCategory(userId, categoryId, keywords);
		} else {
			System.out.println("Empty");
			modelMap.put("error", "Please fill field");
		}
	}

	@RequestMapping(value = "/sma/deletekeyword", method = RequestMethod.POST)
	@ResponseBody
	public void deleteKeyword(ModelMap modelMap, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywordId") String keywordId) {
		keywordDao.deleteKeyword(userId, categoryId, keywordId);
	}

	@RequestMapping(value = "/sma/keywords", method = RequestMethod.GET)
	public @ResponseBody Serialize getAllActiveKeywords(ModelMap model, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId) {
		Serialize serializedObj = new Serialize();
		serializedObj.setElements(keywordDao.getAllActiveKeywordsByCategoryId(categoryId));
		System.out.println("Obj is " + serializedObj.getElements());
		return serializedObj;
	}

	@RequestMapping(value = "/sma/deletedkeywords", method = RequestMethod.GET)
	public @ResponseBody Serialize getAllDeletedKeywords(ModelMap model, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId) {
		Serialize serializedObj = new Serialize();
		serializedObj.setElements(keywordDao.getAllDeletedKeywordsByCategoryId(categoryId));
		System.out.println("Obj is " + serializedObj.getElements());
		return serializedObj;
	}

	@RequestMapping(value = "/sma/restoreKeyword", method = RequestMethod.POST)
	@ResponseBody
	public void restoreKeyword(ModelMap modelMap, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywordId") String keywordId) {
		keywordDao.restoreKeyword(userId, categoryId, keywordId);
	}

	@RequestMapping(value = "/sma/keywordName", method = RequestMethod.POST)
	@ResponseBody
	public void changeKeywordName(ModelMap modelMap, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywordId") String keywordId, @ModelAttribute("keywordName") String keywordName) {
		keywordDao.changeKeywordName(categoryId, keywordId, keywordName);
	}
}
