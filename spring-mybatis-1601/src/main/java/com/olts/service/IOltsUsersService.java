package com.olts.service;

import java.util.List;

import com.olts.vo.OltsUsers;

public interface IOltsUsersService {
	
	public OltsUsers selectForLogin(OltsUsers oltsUsers);

	public List<OltsUsers> findAll(OltsUsers user);

	public OltsUsers findByIdCard(String idCardNo);

	public void updateUser(OltsUsers user);

	public void deleteUserByIdCard(String idCardNo);

	public void savaUser(OltsUsers user);
	
	public void savaUser2(List<OltsUsers> user);
}
