package demo.service.impl;

import org.springframework.stereotype.Service;

import demo.service.HelloService;

@Service
public class HelloServiceImpl implements HelloService {
    public void sayHello(String name) {
        System.out.println("Hello to"+ name);
    }
}
