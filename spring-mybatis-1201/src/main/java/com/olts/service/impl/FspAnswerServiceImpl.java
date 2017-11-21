package com.olts.service.impl;



import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.olts.mapper.FspAnswerMapper;
import com.olts.mapper.FspQuestionsMapper;
import com.olts.service.IFspAnswerService;
import com.olts.vo.FspAnswer;


@Service("fspAnswerService")
public class FspAnswerServiceImpl implements IFspAnswerService{

	@Resource
	private FspAnswerMapper fspAnswerMapper;

	@Override
	public void insertAnswer(FspAnswer fspAnswer) {
		// TODO Auto-generated method stub
		this.fspAnswerMapper.insertAnswer(fspAnswer);
	}

	

}
