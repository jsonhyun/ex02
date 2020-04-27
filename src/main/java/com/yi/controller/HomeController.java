package com.yi.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "replyTest", method = RequestMethod.GET)
	public String replyTest() {
		return "replyTest";
	}
	
	@RequestMapping(value = "temp1", method = RequestMethod.GET)
	public String temp1() {
		return "handlebars1";
	}
	
	@RequestMapping(value = "temp2", method = RequestMethod.GET)
	public String temp2() {
		return "handlebars2";
	}
	
	@RequestMapping(value = "temp3", method = RequestMethod.GET)
	public String temp3() {
		return "handlebars3";
	}
	
	@RequestMapping(value = "member", method = RequestMethod.GET)
	public String member() {
		return "memberAjax";
	}
	
}
