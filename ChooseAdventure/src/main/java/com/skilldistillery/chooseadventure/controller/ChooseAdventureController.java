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
import com.skilldistillery.chooseadventure.entities.Trip;
import com.skilldistillery.chooseadventure.entities.TripComment;

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

	@RequestMapping(path = "showpark.do", params = "state", method = RequestMethod.GET)
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
		model.addAttribute("account", new Account());
		model.addAttribute("activities", dao.getAllActivities());

		return "index";
	}

	@RequestMapping(path = "userprofile.do", method = RequestMethod.POST)
	public String linkToUserProfile(Model model, HttpSession session) {
		model.addAttribute("account", new Account());
		return "nationalparks/userprofile";
	}

	@RequestMapping(path = "userprofile.do", params = "account", method = RequestMethod.POST)
	public String linkToUserProfile(Account account, Model model, HttpSession session) {
		account.setActive(true);
		boolean filled = false;
		Account databaseAccount = dao.createUpdateAccount(account);
		if (account.getId() != 0) {
			filled = true;
		}
		account.setActive(true);
		model.addAttribute("account", databaseAccount);
		if (filled == true) { 
			return "nationalparks/userprofile";
		}
		return "nationalparks/login";
	}

	@RequestMapping(path = "delete.do", method = RequestMethod.POST)
	public String confirmDelete(Model model, HttpSession session) {
		return "nationalparks/delete";
	}

	@RequestMapping(path = "delete.do", params = "aid", method = RequestMethod.POST)
	public String deleteUser(Model model, HttpSession session) {
		Account user = (Account) session.getAttribute("loggedIn");
		session.removeAttribute("loggedIn");
		dao.deleteAccount(user);
		return "nationalparks/delete";
	}

	@RequestMapping(path = "gotoshowpark.do", method = RequestMethod.GET)
	public String linkToShowPark(@RequestParam("pid") int pid, Model model, HttpSession session) {
		model.addAttribute("park", dao.getParkById(pid));
		model.addAttribute("trip", new Trip());
		return "nationalparks/showpark";
	}

	@RequestMapping(path = "bucketList.do", method = RequestMethod.POST)
	public String linkToBucketlist(Trip trip, Model model,@RequestParam("parkId") int parkId, HttpSession session) {
		Account user = (Account) session.getAttribute("loggedIn");
		List<Trip> trips = dao.getTripsByUserId(user.getId());
		trip.setAccount(user);
		trip.setNationalPark(dao.getParkById(parkId));
		Trip managedTrip = dao.createUpdateTrip(trip, user);
		model.addAttribute("trip", managedTrip);
		if(trips.size() > 0) {
			model.addAttribute("trips", trips);			
		}
//		model.addAttribute("comment", new TripComment());
//		model.addAttribute("comments", dao.getTripCommentsByTripId(trip.getId()));
		return "nationalparks/bucketList";
	}
	
	@RequestMapping(path = "edittrip.do", method = RequestMethod.POST)
	public String editATrip(Trip trip, Model model, HttpSession session) {
		Account user = (Account) session.getAttribute("loggedIn");
		Trip managedTrip = dao.createUpdateTrip(trip, user);
		model.addAttribute("trip", managedTrip);
		model.addAttribute("trips", dao.getTripsByUserId(user.getId()));
		model.addAttribute("comment", new TripComment());
		model.addAttribute("comments", dao.getTripCommentsByTripId(trip.getId()));
		return "nationalparks/showpark";
	}
	
	@RequestMapping(path = "deletetrip.do", method = RequestMethod.POST)
	public String deleteATrip(Trip trip, Model model, HttpSession session) {
		dao.deleteTrip(trip);
		return "nationalparks/bucketList";
	}
	
	@RequestMapping(path="createcomment.do", method = RequestMethod.POST)
	public String createComment(TripComment tripComment, Trip trip, Model model, HttpSession session) {
		Account user = (Account) session.getAttribute("loggedIn");
		model.addAttribute("trips", dao.getTripsByUserId(user.getId()));
		model.addAttribute("comment", dao.createUpdateTripComment(tripComment, trip));
		model.addAttribute("comments", dao.getTripCommentsByTripId(trip.getId()));
		return "nationalparks/bucketList";
	}

	@RequestMapping(path = "deletetripcomment.do", method = RequestMethod.POST)
	public String deleteATripComment(TripComment tripComment, Model model, HttpSession session) {
		dao.deleteTripComment(tripComment);
		return "nationalparks/bucketList";
	}
}