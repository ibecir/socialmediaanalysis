package ba.ibu.edu.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ba.ibu.edu.dao.SynonymRepository;
import ba.ibu.edu.helper.Serialize;
import ba.ibu.edu.model.Synonym;

@Controller
public class SynonymController {

	@Autowired
	private SynonymRepository synonymDao;

	@RequestMapping(value = "/sma/synonyms", method = RequestMethod.GET)
	public @ResponseBody Serialize getAllActiveSynoyms(ModelMap model, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywordId") String keywordId) {
		Serialize serializedObj = new Serialize();
		serializedObj.setElements(synonymDao.getAllActiveSynonymsOfKeyword(userId, categoryId, keywordId));
		System.out.println("Obj is " + serializedObj.getElements());
		return serializedObj;
	}

	@RequestMapping(value = "/sma/deletedsynonyms", method = RequestMethod.GET)
	public @ResponseBody Serialize getAllDeledSynonyms(ModelMap model, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywordId") String keywordId) {
		Serialize serializedObj = new Serialize();
		serializedObj.setElements(synonymDao.getAllDeletedSynonymsOfKeyword(userId, categoryId, keywordId));
		System.out.println("Obj is " + serializedObj.getElements());
		return serializedObj;
	}

	@RequestMapping(value = "/sma/addsynonyms", method = RequestMethod.POST)
	@ResponseBody
	public void addSynonymsToKeyword(ModelMap modelMap, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywordId") String keywordId, @ModelAttribute("synonyms") String nameOfSynonyms) {

		List<Synonym> synonyms = new ArrayList<Synonym>();

		if (nameOfSynonyms.length() != 0) {
			List<String> rawSynonyms = Arrays.asList(nameOfSynonyms.split(","));
			for (String synonym : rawSynonyms) {
				String trimedSynonymName = synonym.replaceAll("\\s", "");
				synonyms.add(new Synonym(UUID.randomUUID().toString(), trimedSynonymName, 1));
			}
			synonymDao.addSynonymsToKeyword(userId, categoryId, keywordId, synonyms);
		} else {
			System.out.println("Empty");
			modelMap.put("error", "Please fill field");
		}
	}

	@RequestMapping(value = "/sma/deletesynonym", method = RequestMethod.POST)
	@ResponseBody
	public void deleteSynonyms(ModelMap modelMap, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywordId") String keywordId, @ModelAttribute("synonymId") String synonymId) {
		synonymDao.deleteSynonym(userId, categoryId, keywordId, synonymId);
	}

	@RequestMapping(value = "/sma/restoresynonym", method = RequestMethod.POST)
	@ResponseBody
	public void restoreSynonyms(ModelMap modelMap, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywordId") String keywordId, @ModelAttribute("synonymId") String synonymId) {
		synonymDao.restoreSynonym(userId, categoryId, keywordId, synonymId);
	}

	@RequestMapping(value = "/sma/synonymName", method = RequestMethod.POST)
	@ResponseBody
	public void changeSynonymName(ModelMap modelMap, @ModelAttribute("userId") String userId, @ModelAttribute("categoryId") String categoryId, @ModelAttribute("keywordId") String keywordId, @ModelAttribute("synonymId") String synonymId, @ModelAttribute("synonymName") String synonymName) {
		synonymDao.changeSynonymName(userId, categoryId, keywordId, synonymId, synonymName);
	}

}
