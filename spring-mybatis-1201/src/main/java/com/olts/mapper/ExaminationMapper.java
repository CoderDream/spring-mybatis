package com.olts.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.olts.vo.Examination;
import com.olts.vo.FspAnswer;
import com.olts.vo.FspQuestions;
import com.olts.vo.SmdQuestions;
@Repository
public interface ExaminationMapper {

	public List<Examination> selectExaminaton();

	public Examination selectExam(String examNo);
	public FspQuestions selectFspQuestion(String id);
	public SmdQuestions selectSmdQuestion(String id);
	public void updateExamination(Examination exam); 

}
