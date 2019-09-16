package com.skilldistillery.chooseadventure.data;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

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
		Set <NationalPark> npset = new HashSet<>();
		
		
		for (String search : wordsarr) {
			String query = "select np from NationalPark np where np.name like :input"
					+ " OR np.description like :input" ;
			
			npset.addAll(em.createQuery(query, NationalPark.class)
					.setParameter("input", search).getResultList());
		}
		
		return npset;
	}

}
