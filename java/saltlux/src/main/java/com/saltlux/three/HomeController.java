package com.saltlux.three;

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
	
	/*
		-내용
      		(20220214/수정자)aaaa
      		(20220216/수정자)bbbb
      	-변수정의
      		Locale:이아이는 무엇인가어디서 왔는가무엇을 받는가
      		Model:
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		model.addAttribute("data", "[ {country : 'USA', value: 2025}, {country : 'China', value: 1882} ]");
		
		return "home"; 
	}
}
