package com.skilldistillery.chooseadventure.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.skilldistillery.chooseadventure.data.ChooseAdventureDAO;

@Controller
public class ChooseAdventureController {
	
	@Autowired
	private ChooseAdventureDAO dao;
	
	@RequestMapping(path= {"home.do", "/"}, method = RequestMethod.GET)
	public String index(Model model) {
		return "index";
	}
	
//	@RequestMapping(path="getFilm.do")
//	public String showFilm(@RequestParam("fid") Integer fid, Model model){
//
//		return "film/show";
//	}
}