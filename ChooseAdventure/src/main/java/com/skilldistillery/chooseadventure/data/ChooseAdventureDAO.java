package com.skilldistillery.chooseadventure.data;

import java.util.List;
import java.util.Set;

import com.skilldistillery.chooseadventure.entities.Account;
import com.skilldistillery.chooseadventure.entities.Activity;
import com.skilldistillery.chooseadventure.entities.NationalPark;
import com.skilldistillery.chooseadventure.entities.Trip;
import com.skilldistillery.chooseadventure.entities.TripComment;

public interface ChooseAdventureDAO {

	public List<NationalPark> searchByState (String name);
	public List<NationalPark> getAllParks ();
	public NationalPark getParkById(int id);
	public Set<NationalPark> searchByKeyword(String keyword);
	public List<NationalPark> searchByActivity(List<Activity> activities);
	public List<Activity> getAllActivities();
	public List<String> getAllStates();
	public Account createAccount(Account user);
	public boolean isEmailUnique(String email);
	public Account getAccountByUsername(String username);
	public boolean isValidAccount(Account user);
	public Account getAccountById(int id);
	public boolean deleteAccount(Account user);
	public Account createUpdateAccount(Account user);
	public Trip createUpdateTrip(Trip trip);
	public Trip getTripById(int id);
	public boolean deleteTrip(Trip trip);
	public TripComment createUpdateTripComment(TripComment tripComment);
	public TripComment getTripCommentById(int id);
	public boolean deleteTripComment (TripComment tripComment);
	
}
