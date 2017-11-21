package com.olts.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.olts.commons.Page;
import com.olts.vo.FspQuestions;

@Repository
public interface FspQuestionsMapper {
	
	
	/**
	 * 查询分页
	 * @param page
	 * @return
	 */
	public List<FspQuestions> selectFspForPage(Page<FspQuestions> page);
	
	/**
	 * 统计记录数
	 * @param page
	 * @return
	 */
	public Integer selectFspCount(Page<FspQuestions> page);
	
	/**
	 * 按编号查询试题
	 * @param id
	 * @param techCateId
	 * @return
	 */
	public FspQuestions selectFspById(FspQuestions fspQuestions);
	
	/**
	 * 更新试题
	 * @param fspQuestions
	 * @return
	 */
	public Integer updateFsp(FspQuestions fspQuestions);
	
	/**
	 * 删除试题
	 * @param fspQuestions
	 * @return
	 */
	public Integer deleteFsp(FspQuestions fspQuestions);
	
	/**
	 * 插入试题
	 * @param fspQuestions
	 * @return
	 */
	public Integer insertFsp(FspQuestions fspQuestions);

}
