package ba.ibu.edu.controller;

import java.util.List;

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

import ba.ibu.edu.dao.FeedRepository;
import ba.ibu.edu.model.Feed;

@Controller
public class FeedController {

	@Autowired
	FeedRepository feedDao;

	@RequestMapping(value = "/sma/feeds", method = RequestMethod.GET)
	public ModelAndView getMyCategories(ModelMap model, HttpServletRequest request) {

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
			ModelAndView modelAndView = new ModelAndView("search-feeds");
			modelAndView.addObject("userId", userId);
			modelAndView.addObject("username", username);
			return modelAndView;
		}
	}

	@RequestMapping(value = "/sma/search-feedck", method = RequestMethod.GET)
	public @ResponseBody List<Feed> getFeedsByCategoryIdAndKeyword(@ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keyword") String keyword, @ModelAttribute("skip") int skip) {
		return feedDao.searchFeedsByCategoryIdAndKeyword(userId, categoryId, keyword, skip);
	}

	@RequestMapping(value = "/sma/search-feedc", method = RequestMethod.GET)
	public @ResponseBody List<Feed> getFeedsByCategoryId(@ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("skip") int skip) {
		return feedDao.searchFeedsByCategoryId(userId, categoryId, skip);
	}

	@RequestMapping(value = "/sma/search-feedk", method = RequestMethod.GET)
	public @ResponseBody List<Feed> getFeedsByKeyword(@ModelAttribute("userId") String userId, @ModelAttribute("keyword") String keyword, @ModelAttribute("skip") int skip) {
		return feedDao.searchFeedsByKeyword(userId, keyword, skip);
	}
}