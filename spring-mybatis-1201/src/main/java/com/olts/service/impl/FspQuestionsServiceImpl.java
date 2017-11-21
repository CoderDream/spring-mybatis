package com.olts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.olts.commons.Page;
import com.olts.mapper.FspQuestionsMapper;
import com.olts.service.IFspQuestionsService;
import com.olts.vo.FspQuestions;

@Service("fspQuestionsService")
public class FspQuestionsServiceImpl implements IFspQuestionsService{

	@Resource
	private FspQuestionsMapper fspQuestionsMapper;

	
	/**
	 * 查询分页
	 */
	@Override
	public List<FspQuestions> selectFspForPage(Page<FspQuestions> page) {
		return fspQuestionsMapper.selectFspForPage(page);
	}


	/**
	 * 统计记录数
	 */
	@Override
	public Integer selectFspCount(Page<FspQuestions> page) {
		return fspQuestionsMapper.selectFspCount(page);
	}


	/**
	 * 按编号查询试题
	 */
	@Override
	public FspQuestions selectFspById(FspQuestions fspQuestions) {
		return fspQuestionsMapper.selectFspById(fspQuestions);
	}
	
	/**
	 * 更新试题
	 * @param fspQuestions
	 * @return
	 */
	public Integer updateFsp(FspQuestions fspQuestions){
		return fspQuestionsMapper.updateFsp(fspQuestions);
	}
	
	/**
	 * 删除试题
	 * @param fspQuestions
	 * @return
	 */
	public Integer deleteFsp(FspQuestions fspQuestions){
		return fspQuestionsMapper.deleteFsp(fspQuestions);
	}
	
	/**
	 * 插入试题
	 * @param fspQuestions
	 * @return
	 */
	public Integer insertFsp(FspQuestions fspQuestions){
		return fspQuestionsMapper.insertFsp(fspQuestions);
	}
}
