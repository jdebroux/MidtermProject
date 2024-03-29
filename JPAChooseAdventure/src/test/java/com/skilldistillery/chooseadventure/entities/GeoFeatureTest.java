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

class GeoFeatureTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private GeoFeature gf;
	
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
		gf = em.find(GeoFeature.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		gf = null;
	}

	@Test
	@DisplayName("Tests if Geo Feature entity is mapped correctly")
	void test1() {
		assertEquals("Volcanic", gf.getName());
	}
}
