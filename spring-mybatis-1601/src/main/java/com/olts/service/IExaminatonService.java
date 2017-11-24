package com.olts.service;


import java.util.List;

import com.olts.vo.Examination;
import com.olts.vo.FspAnswer;
import com.olts.vo.FspQuestions;
import com.olts.vo.SmdQuestions;


public interface IExaminatonService {

	
	public List<Examination> select();

	public Examination selectExam(String examNo);
	public List<FspQuestions> selectFspQuestion(String id);
	public List<SmdQuestions> selectSmdQuestion(String id);
	public void updateExamination(Examination exam);
	public FspQuestions selectFspQuestionById(String id);
	public SmdQuestions selectSmdQuestionById(String id);

	
}
