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
	public Set<NationalPark> searchByActivity(Activity [] activities);
	public List<Activity> getAllActivities();
	public List<String> getAllStates();
	public Account createAccount(Account user);
	public boolean isEmailUnique(String email);
	public Account getAccountByEmail(String email);
	public boolean isValidAccount(Account user);
	
	
}
