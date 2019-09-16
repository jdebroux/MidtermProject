package com.skilldistillery.chooseadventure.data;

import java.util.List;
import java.util.Set;

import com.skilldistillery.chooseadventure.entities.NationalPark;

public interface ChooseAdventureDAO {

	public List<NationalPark> searchByState (String name);
	public List<NationalPark> getAllParks ();
	Set<NationalPark> searchByKeyword(String keyword);
	
	
}
