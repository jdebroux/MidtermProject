package com.skilldistillery.chooseadventure.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.chooseadventure.entities.NationalPark;

@Service
@Transactional
public class ChooseAdventureDAOImpl implements ChooseAdventureDAO{

	@PersistenceContext
	private EntityManager em;

	
}
