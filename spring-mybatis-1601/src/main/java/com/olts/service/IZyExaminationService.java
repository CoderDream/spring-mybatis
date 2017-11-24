package com.olts.service;

import java.util.List;

import com.olts.vo.Examination;
import com.olts.vo.FspAnswer;
import com.olts.vo.OltsUsers;

public interface IZyExaminationService {
	
	public Examination selectExaminationByPrimaryKey(String examNo);
	
	public List<Examination> selectExaminationByValidFlag();
	
	public List<OltsUsers> selectUserAnswertByExamNo(String examNo);	
}
