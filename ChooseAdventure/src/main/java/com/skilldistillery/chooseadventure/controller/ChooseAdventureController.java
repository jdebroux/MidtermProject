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
import com.skilldistillery.chooseadventure.entities.TripActivity;
import com.skilldistillery.chooseadventure.entities.TripComment;

@Controller
public class ChooseAdventureController {

	@Autowired
	private ChooseAdventureDAO dao;

	@RequestMapping(path = { "index.do", "/" }, method = RequestMethod.GET)
	public String index(Model model, HttpSession session) {
		model.addAttribute("account", new Account());
		List<Activity> activities = dao.getAllActivities();
		activities = dao.sortActivities(activities);
		model.addAttribute("activities", activities);
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
		account = dao.getAccountByUsername(account.getUsername());
		if (dao.isValidAccount(account)) {
			if(account.getActive() == true) {
			account = dao.getAccountByUsername(account.getUsername());
			session.setAttribute("loggedIn", account);
			model.addAttribute("account", account);
			return "nationalparks/userprofile";
			}

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
		account.setPrivilege(false);
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
	
	@RequestMapping(path="admin.do", method= RequestMethod.POST)
	public String linkToAdminPage(Model model, HttpSession session) {
		List<Account> accounts = dao.getAllAccounts();
		accounts = dao.sortAccounts(accounts);
		model.addAttribute("accounts", accounts);
		return"nationalparks/admin";
	}
	
	@RequestMapping(path="toggleuseraccountactive.do", method=RequestMethod.POST)
	public String deleteAnAccount(@RequestParam("id") int userId, Model model) {
		Account accountToDeactivate = dao.getAccountById(userId);
		if (accountToDeactivate.getActive() == true) {
			accountToDeactivate.setActive(false);
			dao.createUpdateAccount(accountToDeactivate);
		}else if (accountToDeactivate.getActive() == false) {
			accountToDeactivate.setActive(true);
			dao.createUpdateAccount(accountToDeactivate);
		}
		List<Account> accounts = dao.getAllAccounts();
		accounts = dao.sortAccounts(accounts);
		model.addAttribute("accounts", accounts);
		return "nationalparks/admin";
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

	@RequestMapping(path = "bucketlist.do", method = RequestMethod.POST)
	public String linkToBucketlist(@RequestParam("activityIds") List<Integer> activityIds,
			@RequestParam("id") int tripId, Trip trip, Model model, @RequestParam("parkId") int parkId,
			HttpSession session) {
		Account user = (Account) session.getAttribute("loggedIn");
		if (activityIds != null && activityIds.size() > 0) {
			List<Activity> activities = new ArrayList<>();
			for (Integer id : activityIds) {
				activities.add(dao.getActivityById(id));
			}
			List<TripActivity> tripActivities = trip.getTripActivities();
			System.err.println(tripActivities.size() + "         TRIP ACTIVITIES ###############################");
			dao.removeTripActivities(user, trip);
			for (Activity activity : activities) {
				trip.addTripActivity(new TripActivity(activity));
			}
			System.err.println(trip.getTripActivities().size() + "   ^^^^^^^^^^^^^^^^^^^");
		}
		trip.setAccount(user);
		trip.setNationalPark(dao.getParkById(parkId));
		Trip managedTrip = dao.createUpdateTrip(trip, user);

		System.err.println(managedTrip.getTripActivities().size() + "   MANAGEDTRIP $$$$$$$$$$$$$$$$$$$$$$$$$$$");

		model.addAttribute("activities", trip.getTripActivities());
		model.addAttribute("trip", managedTrip);
		List<Trip> trips = dao.getTripsByUserId(user.getId());
		if (trips.size() > 0) {
			model.addAttribute("trips", trips);
		} 

//		model.addAttribute("comment", new TripComment());
//		model.addAttribute("comments", dao.getTripCommentsByTripId(trip.getId()));
		return "nationalparks/bucketList";
	}

	@RequestMapping(path = "gotobucketlist.do", method = RequestMethod.POST)
	public String linkToBucketlist(Model model, HttpSession session) {
		Account user = (Account) session.getAttribute("loggedIn"); // TODO check for null on session - logged in
		List<Trip> trips = dao.getTripsByUserId(user.getId());
		for (Trip trip : trips) {
			System.err.println(trip.getTripActivities().size() + "*************************");
		}
		model.addAttribute("trips", trips);
		return "nationalparks/bucketList";
	}

	@RequestMapping(path = "edittrip.do", method = RequestMethod.POST)
	public String editATrip(@RequestParam("tripId") int tripId, Model model, HttpSession session) {
		Trip trip = dao.getTripById(tripId);
		model.addAttribute("trip", trip);
		model.addAttribute("park", trip.getNationalPark());
//		model.addAttribute("comment", new TripComment());
//		model.addAttribute("comments", dao.getTripCommentsByTripId(trip.getId()));
		return "nationalparks/showpark";
	}

	@RequestMapping(path = "deletetrip.do", method = RequestMethod.POST)
	public String deleteATrip(@RequestParam("tripId") int tripId, Model model, HttpSession session) {
		Trip trip = dao.getTripById(tripId);
		dao.deleteTrip(trip);
		Account user = (Account) session.getAttribute("loggedIn");
		model.addAttribute("trips", dao.getTripsByUserId(user.getId()));
		return "nationalparks/bucketList";
	}

	@RequestMapping(path = "createcomment.do", method = RequestMethod.POST)
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