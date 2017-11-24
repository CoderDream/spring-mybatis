package com.olts.service;

import java.util.List;

import com.olts.vo.OltsScore;
import com.olts.vo.OltsUsers;

public interface IOltsScoreService {

	public List<OltsScore> selectScoreAll(String examNo);
	
	public void deleteScore(Integer userId);
	
	public void updateScore(OltsScore score);
	
	public void insertScore(OltsScore e);
}
