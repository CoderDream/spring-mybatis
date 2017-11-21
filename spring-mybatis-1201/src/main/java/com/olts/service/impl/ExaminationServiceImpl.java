package com.olts.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.olts.mapper.ExaminationMapper;
import com.olts.service.IExaminatonService;
import com.olts.vo.Examination;
import com.olts.vo.FspAnswer;
import com.olts.vo.FspQuestions;
import com.olts.vo.SmdQuestions;


@Service("examinationService")
public class ExaminationServiceImpl implements IExaminatonService{

	@Resource
	private ExaminationMapper examinationMapper;


	@Override
	public List<Examination> select() {
		// TODO Auto-generated method stub
		return this.examinationMapper.selectExaminaton();
	}


	@Override
	public Examination selectExam(String examNo) {
		// TODO Auto-generated method stub
		return this.examinationMapper.selectExam(examNo);
	}
	@Override
	public List<FspQuestions> selectFspQuestion(String id){
		List<FspQuestions> list=new ArrayList<FspQuestions>();
		Pattern p = Pattern.compile("[0-9\\.]+");
		Matcher sim = p.matcher(id);
		 while(sim.find()){
			 FspQuestions  fsp=this.examinationMapper.selectFspQuestion(sim.group());
			 list.add(fsp);
			   }	 
		return list;	
	}
	@Override
	public void updateExamination(Examination exam) {
		// TODO Auto-generated method stub
		this.examinationMapper.updateExamination(exam);
	}
	@Override
	public List<SmdQuestions> selectSmdQuestion(String id) {
		// TODO Auto-generated method stub
		List<SmdQuestions> list=new ArrayList<SmdQuestions>();
		Pattern p = Pattern.compile("[0-9\\.]+");
		Matcher s = p.matcher(id);
		 while(s.find()){
			 SmdQuestions  smd=this.examinationMapper.selectSmdQuestion(s.group());
			 list.add(smd);
			   }	 
		return list;	
	}


	@Override
	public FspQuestions selectFspQuestionById(String id) {
		// TODO Auto-generated method stub
		 FspQuestions  fsp=this.examinationMapper.selectFspQuestion(id);
		 return fsp;
	}


	@Override
	public SmdQuestions selectSmdQuestionById(String id) {
		// TODO Auto-generated method stub
		SmdQuestions  smd=this.examinationMapper.selectSmdQuestion(id);
		return smd;
	}


	

	
}
