package org.fkit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ModelAttribute4Controller {

	// 这时这个方法的返回值并不是表示一个视图名称，而是model属性的值，视图名称是@RequestMapping的value值。
	// Model属性名称由@ModelAttribute(value=””)指定，相当于在request中封装了username（key）=admin（value）。
	@RequestMapping(value = "/login4")
	@ModelAttribute(value = "username")
	public String login4() {
		return "admin";
	}

}
