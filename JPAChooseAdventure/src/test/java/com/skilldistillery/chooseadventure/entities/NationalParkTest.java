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

class NationalParkTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private NationalPark np;
	
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
		np = em.find(NationalPark.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		np = null;
	}

	@Test
	@DisplayName("Tests if National Park entity is mapped correctly")
	void test1() {
		assertEquals("Acadia", np.getName());
		assertEquals(44.35, np.getLocation().getLatitude());
	}
}
