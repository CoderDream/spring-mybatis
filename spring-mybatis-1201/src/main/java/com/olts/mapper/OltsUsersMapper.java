package com.olts.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Repository;

import com.olts.vo.OltsUsers;

@Repository
public interface OltsUsersMapper {

	public OltsUsers selectForLogin(OltsUsers oltsUsers);

	public List<OltsUsers> findAll(OltsUsers user);

	public OltsUsers findByIdCard(String idCardNo);

	public void updateUser(OltsUsers user);

	public void deleteUserByIdCard(String idCardNo);

	public void savaUser(OltsUsers user);
	
	public void savaUser2(List<OltsUsers> user);
}
