package com.skilldistillery.chooseadventure.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class TripCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private TripComment tc;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("AdventurePU");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		tc = em.find(TripComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		tc = null;
	}

	@Test
	@DisplayName("Tests if Trip Comment entity is mapped correctly")
	void test1() {
		assertEquals("Wind Cave Extravaganza", tc.getTitle());
		assertEquals("Wind Cave", tc.getTrip().getNationalPark().getName());
	}
}
