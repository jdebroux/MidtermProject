package com.skilldistillery.chooseadventure.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.chooseadventure.entities.Account;
import com.skilldistillery.chooseadventure.entities.Activity;
import com.skilldistillery.chooseadventure.entities.NationalPark;

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
	public Set<NationalPark> searchByActivity(List<Activity> activities) {
		Set<NationalPark> parks = new HashSet<>();
		Set<NationalPark> filteredParks = new HashSet<>();
		int size = activities.size();

		if (activities != null && activities.size() > 0) {
			String pname = ":act0";
			StringBuilder jpql = new StringBuilder("select np from NationalPark np where ");
			jpql.append(pname);
			jpql.append(" MEMBER OF np.activities ");

			for (int i = 1; i < activities.size(); i++) {
				pname = ":act" + i;
				jpql.append(" and ");
				jpql.append(pname);
				jpql.append(" MEMBER OF np.activities ");
			}
			System.out.println(jpql);
			Query query = em.createQuery(jpql.toString(), NationalPark.class);

			for (int i = 0; i < activities.size(); i++) {
				pname = "act" + i;
				query.setParameter(pname, activities.get(i));
			}
			filteredParks.addAll((List<NationalPark>) query.getResultList());

		}

		else {
			filteredParks.addAll(getAllParks());
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
			if(!states.contains(nationalPark.getLocation().getState())) {
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

}
