package com.skilldistillery.chooseadventure.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.chooseadventure.data.ChooseAdventureDAO;
import com.skilldistillery.chooseadventure.entities.Account;
import com.skilldistillery.chooseadventure.entities.Activity;
import com.skilldistillery.chooseadventure.entities.NationalPark;
import com.skilldistillery.chooseadventure.entities.Trip;

@Controller
public class ChooseAdventureController {

	@Autowired
	private ChooseAdventureDAO dao;

	@RequestMapping(path = { "index.do", "/" }, method = RequestMethod.GET)
	public String index(Model model, HttpSession session) {
		model.addAttribute("account", new Account());
		model.addAttribute("activities", dao.getAllActivities());
		return "index";
	}

	@RequestMapping(path = "showpark.do", params="state", method = RequestMethod.GET)
	public String searchByState(@RequestParam("state") String state, Model model, HttpSession session) {
		System.out.println(state);
		model.addAttribute("parks", dao.searchByState(state));
		model.addAttribute("state", state);
		return "nationalparks/results";
	}

	@RequestMapping(path = "search.do", method = RequestMethod.GET)
	public String linkToSearch(Model model, HttpSession session) {
		List<String> states = dao.getAllStates();
		Collections.sort(states);
		model.addAttribute("states", states);
		return "nationalparks/search";
	}

	@RequestMapping(path = "results.do", method = RequestMethod.GET)
	public String linkToResults(@RequestParam("keyword") String keyword, Model model, HttpSession session) {
		if (keyword != null && keyword != "") {
			model.addAttribute("parks", dao.searchByKeyword(keyword));
		} else {
			model.addAttribute("parks", dao.getAllParks());
		}
		return "nationalparks/results";
	}

	@RequestMapping(path = "activities.do", params = "activityIds", method = RequestMethod.POST)
	public String linkToActivitySearchResults(@RequestParam("activityIds") List<Integer> activityIds, Model model,
			HttpSession session) {
		if (activityIds != null && activityIds.size() > 0) {
			List<Activity> activities = new ArrayList<>();
			for (Integer id : activityIds) {
				activities.add(new Activity(id));
			}
			model.addAttribute("parks", dao.searchByActivity(activities));
		} else {
			model.addAttribute("parks", dao.getAllParks());
		}
		return "nationalparks/results";
	}

	@RequestMapping(path = "activities.do", method = RequestMethod.POST)
	public String linkToActivitySearchResults(Model model, HttpSession session) {
		model.addAttribute("parks", dao.getAllParks());
		return "nationalparks/results";
	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String linkToLoginPage(Account account, Model model, HttpSession session) {
		if (dao.isValidAccount(account)) {
			account = dao.getAccountByUsername(account.getUsername());
			session.setAttribute("loggedIn", account);
			model.addAttribute("account", account);
			
			return "nationalparks/userprofile";
		}
		return "nationalparks/login";
	}
	
	@RequestMapping(path = "logout.do", method = RequestMethod.POST)
	public String linkToLogoutPage(Account account, Model model, HttpSession session) {
		session.removeAttribute("loggedIn");
		return "index";
	}

	@RequestMapping(path = "userprofile.do", method = RequestMethod.POST)
	public String linkToUserProfile(Model model, HttpSession session) {
		model.addAttribute("account", new Account());
		return "nationalparks/userprofile";
	}
	
	@RequestMapping(path = "userprofile.do", params = "account", method = RequestMethod.POST)
	public String linkToUserProfile( Account account, Model model, HttpSession session) {
		account.setActive(true);
		model.addAttribute("account", dao.createUpdateAccount(account));
		return "nationalparks/userprofile";
	}
	
	//TELL CASEY ABOUT THIS
	@RequestMapping(path ="delete.do", method = RequestMethod.POST)
	public String confirmDelete(Model model, HttpSession session) {
		return "nationalparks/delete";
	}
	
	@RequestMapping(path = "delete.do", params="aid", method = RequestMethod.POST)
	public String deleteUser(Model model, HttpSession session) {
		Account user = (Account)session.getAttribute("loggedIn");
		session.removeAttribute("loggedIn");
		dao.deleteAccount(user);
		return "nationalParks/delete";
	}
	
	@RequestMapping(path = "showpark.do", params="pid", method = RequestMethod.POST)
	public String linkToShowPark(@RequestParam("pid") int pid, Model model, HttpSession session) {
		model.addAttribute("park", dao.getParkById(pid));
		model.addAttribute("trip", new Trip());
		return "showpark.jsp";
	}
	
	@RequestMapping(path="bucketlist.do", method = RequestMethod.POST)
	public String linkToBucketlist(Trip trip, Model model, HttpSession session) {
		model.addAttribute("trip", dao.createUpdateTrip(trip));
		return "nationalparks/bucketlist";
	}
	
	
	
	
	
	
	
	
	
}