package com.skilldistillery.chooseadventure.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

@Service
@Transactional
public class ChooseAdventureDAOImpl implements ChooseAdventureDAO{

	@PersistenceContext
	private EntityManager em;
	
	
}
