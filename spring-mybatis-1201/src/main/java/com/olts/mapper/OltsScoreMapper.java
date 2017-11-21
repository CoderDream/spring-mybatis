package com.olts.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.olts.vo.OltsScore;
import com.olts.vo.OltsUsers;

@Repository
public interface OltsScoreMapper {
	

	public List<OltsScore> selectScoreAll(String examNo);
	
	public void deleteScore(Integer userId);
	
	public void updateScore(OltsScore score);
	
	public void insertScore(OltsScore e);
}
