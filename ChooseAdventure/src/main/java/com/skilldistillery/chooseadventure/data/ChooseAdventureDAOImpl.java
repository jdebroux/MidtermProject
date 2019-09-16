package com.skilldistillery.chooseadventure.data;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.chooseadventure.entities.Activity;
import com.skilldistillery.chooseadventure.entities.NationalPark;
import com.skilldistillery.chooseadventure.entities.NationalParkActivity;

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
	public Set<NationalPark> searchByActivity(String [] activities) {
		Set<NationalPark> parks = new HashSet<>();
		Set<NationalPark> filteredParks = new HashSet<>();
		int size = activities.length;
		
		
		
		
		if (activities != null && activities.length > 0) {

			StringBuilder query = new StringBuilder("select npa.nationalPark from NationalParkActivities npa "
					+ "where npa.activity like :input ");
			for (int i = 0; i < activities.length; i++) {
				query.append("AND npa.activity like :input" + i);
				
			}
			
			for (String activity : activities) {
				parks.addAll(em.createQuery(query, NationalPark.class)
						.setParameter("input", activity).getResultList());
			}
			
			
			
			for (NationalPark nationalPark : parks) {
				if(nationalPark.getActivities().contains()) {
					
				}
			}
		}
		
		else {
			filteredParks.addAll(getAllParks());
		}

		return filteredParks;

	}

	@Override
	public List<String> getAllActivityNames() {
		String query = "select a from Activity a";
		List<Activity> activities = em.createQuery(query, Activity.class).getResultList();
		List<String> activityNames = new ArrayList<>();
		for (Activity activity : activities) {
			activityNames.add(activity.getName());
		}
		return activityNames;
	}

	@Override
	public List<String> getAllStates() {
		List<String> states = new ArrayList<>();
		List<NationalPark> parks = getAllParks();
		for (NationalPark nationalPark : parks) {
			states.add(nationalPark.getLocation().getState());
		}

		return states;
	}

}
