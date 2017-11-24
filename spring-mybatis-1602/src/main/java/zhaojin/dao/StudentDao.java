package zhaojin.dao;

import java.util.List;
import java.util.Map;

public interface StudentDao {
	public void addStu(Map<String,Object> p);
	public List<Map<String,Object>> getQuestionInfoByPaperId(Map<String,Object> p);
	public List<Map<String,Object>> getQuestionDetailInfoByQuestId(Map<String,Object> p);
	public void insertIntoStudscore(Map<String,Object> p);
	public void insertIntoStudscoredetail(Map<String,Object> p);
	public List<Map<String,Object>> getExamDoneInfo(Map<String,Object> p);
	public Integer getDoneExamCount(Map<String,Object> p);
	public Integer getWrongQuestCount(Map<String,Object> p);
	public List<Map<String,Object>> getWrongQuestInfo(Map<String,Object> p);
	public Map<String,Object> getPaperInfoAndQuestInfoByPaperdetailID(Map<String,Object> p);
}
