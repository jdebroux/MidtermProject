package com.skilldistillery.chooseadventure.data;

import java.util.List;
import java.util.Set;

import com.skilldistillery.chooseadventure.entities.Account;
import com.skilldistillery.chooseadventure.entities.Activity;
import com.skilldistillery.chooseadventure.entities.NationalPark;

public interface ChooseAdventureDAO {

	public List<NationalPark> searchByState (String name);
	public List<NationalPark> getAllParks ();
	public Set<NationalPark> searchByKeyword(String keyword);
	public List<NationalPark> searchByActivity(List<Activity> activities);
	public List<Activity> getAllActivities();
	public List<String> getAllStates();
	public Account createAccount(Account user);
	public boolean isEmailUnique(String email);
	public Account getAccountByUsername(String username);
	public boolean isValidAccount(Account user);
	public boolean deleteAccount(Account user);
	public Account createUpdateAccount(Account user);
	
	
}
