package com.olts.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;



import com.olts.vo.Examination;
import com.olts.vo.FspAnswer;
import com.olts.vo.OltsUsers;

@Repository
public interface ZyExaminationMapper {
	
	public Examination selectExaminationByPrimaryKey(String examNo);
	
	public List<Examination> selectExaminationByValidFlag();
	
	public List<OltsUsers> selectUserAnswertByExamNo(String examNo);
}
