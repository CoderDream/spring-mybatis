package com.olts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import com.olts.mapper.OltsScoreMapper;
import com.olts.service.IOltsScoreService;
import com.olts.vo.OltsScore;
import com.olts.vo.OltsUsers;

@Service("oltsScoreService")
public class OltsScoreServiceImpl implements IOltsScoreService {
	
	@Resource
	private OltsScoreMapper oltsScoreMapper;

	

	@Override
	public void deleteScore(Integer userId) {
		this.oltsScoreMapper.deleteScore(userId);
		
	}



	@Override
	public List<OltsScore> selectScoreAll(String examNo) {
		// TODO Auto-generated method stub
		return oltsScoreMapper.selectScoreAll(examNo);
	}



	@Override
	public void updateScore(OltsScore score) {
		// TODO Auto-generated method stub
		oltsScoreMapper.updateScore(score);
	}

	//插入分数
	@Override
	public void insertScore(OltsScore e) {
		
		oltsScoreMapper.insertScore(e);
	}



	



	



	



	



	



	



	

	

	
	

}
