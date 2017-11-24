package com.olts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;



import com.olts.mapper.FspAnswerMapper;
import com.olts.mapper.ZyExaminationMapper;

import com.olts.service.IZyExaminationService;
import com.olts.vo.Examination;
import com.olts.vo.FspAnswer;
import com.olts.vo.OltsUsers;

@Service("zyExaminationService")
public class ZyExaminationServiceImpl implements IZyExaminationService {

	@Resource
	private ZyExaminationMapper zyExaminationMapper;
	
//	@Resource 
	//private FspAnswerMapper fspAnswerMapper;
	
	@Override
	public Examination selectExaminationByPrimaryKey(String examNo) {
		// TODO Auto-generated method stub
		return zyExaminationMapper.selectExaminationByPrimaryKey(examNo);
	}

	@Override
	public List<Examination> selectExaminationByValidFlag() {
		// TODO Auto-generated method stub
		return zyExaminationMapper.selectExaminationByValidFlag();
	}

	@Override
	public List<OltsUsers> selectUserAnswertByExamNo(String examNo) {
		
		return zyExaminationMapper.selectUserAnswertByExamNo(examNo);
		
	}

//	@Override
//	public List<OltsUsers> selectUserAnswertByExamNo(String examNo) {
//		// TODO Auto-generated method stub
//		return zyExaminationMapper.selectUserAnswertByExamNo(examNo);
//	}

	

	
}
