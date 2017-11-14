package org.fkit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *  HelloWorldController是一个基于注解的控制器,
 *  可以同时处理多个请求动作，并且无须实现任何接口。
 *  org.springframework.stereotype.Controller注解用于指示该类是一个控制器
 */
@Controller
public class HelloWorldController{
	 
	 @RequestMapping("/helloWorld")
	 public String helloWorld(Model model) {
	     model.addAttribute("message", "Hello World!");
	     return "helloWorld";
	 }

}

