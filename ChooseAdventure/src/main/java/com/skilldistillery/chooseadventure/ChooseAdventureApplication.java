package com.skilldistillery.chooseadventure;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EntityScan("com.skilldistillery.chooseadventure")
public class ChooseAdventureApplication {

	public static void main(String[] args) {
		SpringApplication.run(ChooseAdventureApplication.class, args);
	}

}
