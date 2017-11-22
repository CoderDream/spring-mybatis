package zhaojin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zhaojin.dao.LoginDao;


@Service("loginService")
public class LoginService {
	@Autowired
	private LoginDao mapper;
	
	public void regis(){};
	public Map<String,Object> findInfoByUserName(Map<String,Object> p){
		return mapper.findInfoByUserName(p);
	}
	public void regis(Map<String,Object> p){
		mapper.regis(p);
	}
}
