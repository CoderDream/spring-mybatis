package org.fkit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

// Controller注解用于指示该类是一个控制器，可以同时处理多个请求动作
@Controller
public class FormController {

	// 该方法映射的请求为http://localhost:8088/spring-mybatis-0305/{formName}
	@RequestMapping(value = "/{formName}")
	public String loginForm(@PathVariable String formName) {
		// 动态跳转页面
		return formName;
	}

}
