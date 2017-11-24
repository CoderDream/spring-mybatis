package zhaojin.dao;

import java.util.List;
import java.util.Map;

public interface ManagerDao {
	public List<Map<String,Object>> getQuestionInfo(Map<String,Object> p);
	public List<Map<String,Object>> getQuestionDetailInfo(Map<String,Object> p);
	public Integer getQuestionCount(Map<String,Object> p);
	public List<Map<String,Object>> getAccountInfo(Map<String,Object> p);
	public Integer getAccountCount(Map<String,Object> p);
	
	public void addQuestion(Map<String,Object> p);
	public void addQuestionDetail(Map<String,Object> p);
	
	//删除question表中的数据根据questID
	public void delQuestion(Map<String,Object> p);
	//删除questiondetail表中关联questID的数据
	public void delQuestionDetail(Map<String,Object> p);
	//删除paperdetail表中关联questID的数据
	public void delQuestionPaperDetail(Map<String,Object> p);
	//查找paperdetail中关联questID的数据
	public List<Map<String,Object>> getAllpaperDetailIdByQusId(Map<String,Object> p);
	//删除studscoredetail表中关联paperdetailID的数据
	public void delStudScoreDetail(Map<String,Object> p);
	
	public void updateQuestion(Map<String,Object> p);
	public void updateQuestionDetail(Map<String,Object> p);
	
	
	public void delOperator(Map<String,Object> p);
	public void delStudentInfo(Map<String,Object> p);
	
	public void addStudentInfo(Map<String,Object> p);
	public void addAccount(Map<String,Object> p);
	public Map<String,Object> getUpdateAccountInfo(Map<String,Object> p);
	public Map<String,Object> getStudentInfo(Map<String,Object> p);
	
	
	public void updateOperatorInfo(Map<String,Object> p);
	public void updateStudentInfo(Map<String,Object> p);
}
