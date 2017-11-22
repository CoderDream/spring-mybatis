package zhaojin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zhaojin.dao.StudentDao;

@Service("studentService")
public class StudentService {
	@Autowired
	private StudentDao mapper;
	
	public void addStu(Map<String,Object> p){
		mapper.addStu(p);
	}
	public List<Map<String,Object>> getQuestionInfoByPaperId(Map<String,Object> p){
		return mapper.getQuestionInfoByPaperId(p);
	};
	public List<Map<String,Object>> getQuestionDetailInfoByQuestId(Map<String,Object> p){
		return mapper.getQuestionDetailInfoByQuestId(p);
	};
	public void insertIntoStudscore(Map<String,Object> p){
		mapper.insertIntoStudscore(p);
	};
	public void insertIntoStudscoredetail(Map<String,Object> p){
		mapper.insertIntoStudscoredetail(p);
	};
	public List<Map<String,Object>> getExamDoneInfo(Map<String,Object> p){
		return mapper.getExamDoneInfo(p);
	};
	public Integer getDoneExamCount(Map<String,Object> p){
		return mapper.getDoneExamCount(p);
	};
	public List<Map<String,Object>> getWrongQuestInfo(Map<String,Object> p){
		return mapper.getWrongQuestInfo(p);
	};
	public Map<String,Object> getPaperInfoAndQuestInfoByPaperdetailID(Map<String,Object> p){
		return mapper.getPaperInfoAndQuestInfoByPaperdetailID(p);
	};
	public Integer getWrongQuestCount(Map<String,Object> p){
		return mapper.getWrongQuestCount(p);
	};
}
