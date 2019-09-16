package com.skilldistillery.chooseadventure.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.chooseadventure.data.ChooseAdventureDAO;
import com.skilldistillery.chooseadventure.entities.NationalPark;

@Controller
public class ChooseAdventureController {

	@Autowired
	private ChooseAdventureDAO dao;

	@RequestMapping(path = { "index.do", "/" }, method = RequestMethod.GET)
	public String index(Model model) {

		return "index";
	}

	@RequestMapping(path = "showpark.do", method = RequestMethod.GET)
	public String searchByState(@RequestParam("state") String state, Model model) {
		System.out.println(state);
		model.addAttribute("parks", dao.searchByState(state));
		model.addAttribute("state", state);
		return "nationalparks/results";
	}

	@RequestMapping(path = "search.do", method = RequestMethod.GET)
	public String linkToSearch(Model model) {
		List<NationalPark> parks = dao.getAllParks();
		List<String> states = new ArrayList<>();
		for (NationalPark nationalPark : parks) {
			if (!states.contains(nationalPark.getLocation().getState())) {
				states.add(nationalPark.getLocation().getState());
			}
		}
		Collections.sort(states);
		model.addAttribute("states", states);
		return "nationalparks/search";
	}

	@RequestMapping(path = "results.do", method = RequestMethod.GET)
	public String linkToResults(@RequestParam("keyword") String keyword, Model model) {
		if (keyword != null && keyword != "") {
			model.addAttribute("parks", dao.searchByKeyword(keyword));
		} else {
			model.addAttribute("parks", dao.getAllParks());
		}
		return "nationalparks/results";
	}
}