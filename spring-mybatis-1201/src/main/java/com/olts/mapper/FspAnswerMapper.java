package com.olts.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.olts.vo.Examination;
import com.olts.vo.FspAnswer;
import com.olts.vo.FspQuestions;
import com.olts.vo.SmdQuestions;
@Repository
public interface FspAnswerMapper {

	public void insertAnswer(FspAnswer fspAnswer);

}
