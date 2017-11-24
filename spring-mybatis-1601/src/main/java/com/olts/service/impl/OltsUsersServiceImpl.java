package com.olts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.olts.mapper.OltsUsersMapper;
import com.olts.service.IOltsUsersService;
import com.olts.vo.OltsUsers;


@Service("oltsUsersService")
public class OltsUsersServiceImpl implements IOltsUsersService{

	//注入mapper映射器接口
	@Resource
	private OltsUsersMapper oltsUsersMapper;

	@Override
	public OltsUsers selectForLogin(OltsUsers oltsUsers) {
		return this.oltsUsersMapper.selectForLogin(oltsUsers);
	}

	@Override
	public List<OltsUsers> findAll(OltsUsers user) {
		return oltsUsersMapper.findAll(user);
	}

	@Override
	public OltsUsers findByIdCard(String idCardNo) {
		return oltsUsersMapper.findByIdCard(idCardNo);
	}

	@Override
	public void updateUser(OltsUsers user) {

		oltsUsersMapper.updateUser(user);
	}

	@Override
	public void deleteUserByIdCard(String idCardNo) {
		oltsUsersMapper.deleteUserByIdCard(idCardNo);
	}

	@Override
	public void savaUser(OltsUsers user) {
		oltsUsersMapper.savaUser(user);
	}
	
	@Override
	public void savaUser2(List<OltsUsers> userlist) {
			oltsUsersMapper.savaUser2(userlist);
		
	}
}
