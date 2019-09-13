package com.skilldistillery.chooseadventure.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class WildlifeTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Wildlife wildlife;
	
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
		wildlife = em.find(Wildlife.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		wildlife = null;
	}

	@Test
	@DisplayName("Tests if user entity is mapped correctly")
	void test1() {
		assertEquals("Bald Eagle", wildlife.getName());
//		fail("Not yet implemented");
	}
}
