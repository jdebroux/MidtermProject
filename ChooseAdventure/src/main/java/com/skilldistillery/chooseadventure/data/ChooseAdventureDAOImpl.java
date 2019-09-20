package com.skilldistillery.chooseadventure.data;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.chooseadventure.entities.Account;
import com.skilldistillery.chooseadventure.entities.Activity;
import com.skilldistillery.chooseadventure.entities.NationalPark;
import com.skilldistillery.chooseadventure.entities.Trip;
import com.skilldistillery.chooseadventure.entities.TripActivity;
import com.skilldistillery.chooseadventure.entities.TripComment;

@Service
@Transactional
public class ChooseAdventureDAOImpl implements ChooseAdventureDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public List<NationalPark> searchByState(String search) {
		search = "%" + search + "%";
		String query = "select np from NationalPark np where np.location.state like :input";
		List<NationalPark> parks = em.createQuery(query, NationalPark.class).setParameter("input", search)
				.getResultList();
		return parks;
	}

	@Override
	public List<NationalPark> getAllParks() {
		String query = "select np from NationalPark np";
		List<NationalPark> parks = em.createQuery(query, NationalPark.class).getResultList();

		return parks;
	}

	@Override
	public NationalPark getParkById(int id) {
		return em.find(NationalPark.class, id);
	}

	@Override
	public Set<NationalPark> searchByKeyword(String keyword) {
		keyword = "%" + keyword + "%";
		keyword = keyword.replaceAll(" ", "% %");
		String wordsarr[] = keyword.split(" ");
		Set<NationalPark> npset = new HashSet<>();

		for (String search : wordsarr) {
			String query = "select np from NationalPark np where np.name like :input"
					+ " OR np.description like :input";

			npset.addAll(em.createQuery(query, NationalPark.class).setParameter("input", search).getResultList());
		}
		return npset;
	}

	@Override
	public List<NationalPark> searchByActivity(List<Activity> activities) {
		List<NationalPark> parks = getAllParks();
		List<NationalPark> filteredParks = new ArrayList<>(parks);
		for (NationalPark nationalPark : parks) {
			for (int i = 0; i < activities.size(); i++) {
				if (nationalPark.getActivities().contains(activities.get(i))) {
					continue;
				} else {
					filteredParks.remove(nationalPark);
				}
			}
		}
		return filteredParks;
	}

	@Override
	public List<Activity> getAllActivities() {
		String query = "select a from Activity a";
		List<Activity> activities = em.createQuery(query, Activity.class).getResultList();

		return activities;
	}

	@Override
	public List<String> getAllStates() {
		List<String> states = new ArrayList<>();
		List<NationalPark> parks = getAllParks();
		for (NationalPark nationalPark : parks) {
			if (!states.contains(nationalPark.getLocation().getState())) {
				states.add(nationalPark.getLocation().getState());
			}
		}
		return states;
	}

	@Override
	public Account createAccount(Account user) {
		if (isEmailUnique(user.getEmail())) {
			em.persist(user);
			em.flush();
			return user;
		}
		return null;
	}

	@Override
	public Account getAccountById(int id) {
		return em.find(Account.class, id);
	}

	@Override
	public Account createUpdateAccount(Account user) {
		Account databaseAccount = null;
		if (user.getId() != 0) {
			Account newAccount = em.find(Account.class, user.getId());
			newAccount.setFirstName(user.getFirstName());
			newAccount.setLastName(user.getLastName());
			newAccount.setEmail(user.getEmail());
			newAccount.setPassword(user.getPassword());
			newAccount.setUsername(user.getUsername());
			em.persist(newAccount);
			em.flush();
			System.err.println(newAccount);
			return newAccount;
		} else if (isEmailUnique(user.getEmail())) {
			em.persist(user);
			em.flush();
			databaseAccount = getAccountByUsername(user.getUsername());
		}
		return databaseAccount;
	}

	@Override
	public boolean deleteAccount(Account user) {
		if (isValidAccount(user)) {
			Account managedAccount = em.find(Account.class, user.getId());
			em.remove(managedAccount);
			em.flush();
			if (managedAccount == null) {
				return true;
			}
		}
		return false;
	}

	@Override
	public boolean isEmailUnique(String email) {
		List<Account> accounts = getAllAccounts();
		for (Account account : accounts) {

			if (account.getEmail().equals(email)) {
				return false;
			}
		}
		return true;
	}

	@Override
	public Account getAccountByUsername(String username) {
		List<Account> accounts = getAllAccounts();

		for (Account account : accounts) {
			if (account.getUsername().equals(username)) {
				return account;
			}
		}
		return null;
	}

	@Override
	public boolean isValidAccount(Account user) {
		List<Account> accounts = getAllAccounts();
		if (getAccountByUsername(user.getUsername()) == null) {
			return false;
		}
		for (Account account : accounts) {
			if (account.getUsername().equals(user.getUsername())) {
				if (account.getPassword().equals(user.getPassword())) {
					return true;
				}
			}
		}
		return false;
	}

	public List<Account> getAllAccounts() {
		String query = "select a from Account a";
		List<Account> accounts = em.createQuery(query, Account.class).getResultList();

		return accounts;
	}

	@Override
	public Trip createUpdateTrip(Trip trip, Account user) {
		Trip managedTrip = null;
System.err.println(trip.getId() + "   TRIP ID    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
		if (trip.getId() != 0) {
			Trip newTrip = em.find(Trip.class, trip.getId());
			newTrip.setAccount(user);
			newTrip.setName(trip.getName());
			newTrip.setNationalPark(trip.getNationalPark());
			newTrip.setTripActivities(trip.getTripActivities());
//			newTrip.setTripComments(trip.getTripComments());
			em.persist(newTrip);
			em.flush();
			return newTrip;

		} else {
System.err.println(trip.getActivities().size() + "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
			em.persist(trip);
			em.flush();
			managedTrip = getTripByName(trip.getName());
		}
		return managedTrip;
	}

	private Trip getTripByName(String name) {
		String qS = "SELECT t FROM Trip t WHERE t.name LIKE :input";
		List<Trip> trips = em.createQuery(qS, Trip.class).setParameter("input", name).getResultList();
		Trip trip = trips.get(0);
		return trip;
	}

	@Override
	public boolean deleteTrip(Trip trip) {
		if (trip.getName() != null) {
			Trip managedTrip = em.find(Trip.class, trip.getId());
			em.remove(managedTrip);
			em.flush();
			if (managedTrip == null) {
				return true;
			}
		}
		return false;
	}

	@Override
	public TripComment createUpdateTripComment(TripComment tripComment, Trip trip) {
		TripComment managedTC = null;
		if (tripComment.getId() != 0) {
			TripComment newTripComment = em.find(TripComment.class, tripComment.getId());
			newTripComment.setDescription(tripComment.getDescription());
			newTripComment.setTitle(tripComment.getTitle());
			newTripComment.setTrip(trip);
			em.persist(newTripComment);
			em.flush();
			return newTripComment;

		} else {
			em.persist(tripComment);
			em.flush();
			managedTC = getTripCommentByName(tripComment.getTitle());
		}
		return managedTC;
	}

	private TripComment getTripCommentByName(String title) {
		String qS = "SELECT tc FROM TripComment tc WHERE tc.title LIKE :input";
		List<TripComment> tripComments = em.createQuery(qS, TripComment.class).setParameter("input", title).getResultList();
		TripComment comment = tripComments.get(0);
		return comment;
	}

	@Override
	public boolean deleteTripComment(TripComment tripComment) {
		if (tripComment.getTrip() != null) {
			TripComment managedComment = em.find(TripComment.class, tripComment.getId());
			em.remove(managedComment);
			em.flush();
			if (managedComment == null) {
				return true;
			}
		}
		return false;
	}

	@Override
	public Trip getTripById(int id) {
		return em.find(Trip.class, id);
	}

	@Override
	public TripComment getTripCommentById(int id) {
		return em.find(TripComment.class, id);
	}

	@Override
	public List<Trip> getTripsByUserId(int userId) {
//		String qS = "SELECT a.trips FROM Account a WHERE a.id = :input";
		Account account = em.find(Account.class, userId);
		List<Trip> trips = account.getTrips();
		return trips;
	}

	@Override
	public List<TripComment> getTripCommentsByTripId(int tripId) {
//		String qS = "SELECT t.tripComments FROM Trip t WHERE t.id = :input";
		return em.find(Trip.class, tripId).getTripComments();
	}

	@Override
	public Activity getActivityById(int activityId) {
		return em.find(Activity.class, activityId);
	}

	@Override
	public List<Activity> getActivitiesByTripId(int tripId) {
		Trip trip = em.find(Trip.class, tripId);
		List<Activity> tripActivities = trip.getActivities();
		return tripActivities;
	}

	@Override
	public Activity getActivityByName(String name) {
		String qS = "SELECT a FROM Activity a WHERE a.name LIKE :input";
		List<Activity> activities = em.createQuery(qS, Activity.class).setParameter("input", name).getResultList();
		return activities.get(0);
	}

	@Override
	public List<Activity> sortActivities(List<Activity> unsorted) {
		List<String> activityNames = new ArrayList<>();
		List<Activity> sortedActivities = new ArrayList<>();
		for (Activity activity : unsorted) {
			activityNames.add(activity.getName());
		}
		Collections.sort(activityNames);
		for (String name : activityNames) {
			sortedActivities.add(getActivityByName(name));
		}
		return sortedActivities;
	}

	@Override
	public boolean removeTripActivities(Trip trip) {
		List<TripActivity> tripActivities = trip.getTripActivities();
		if(tripActivities != null && tripActivities.size() > 0) {
			for (TripActivity tripActivity : tripActivities) {
				em.remove(tripActivity);
				em.flush();
			}
			if (tripActivities.size() == 0){
				return true;
			}
		}
		return false;
	}
	
	
}
