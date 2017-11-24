package zhaojin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zhaojin.dao.ManagerDao;

@Service("managerService")
public class ManagerService {
	@Autowired
	private ManagerDao mapper;
	public List<Map<String,Object>> getQuestionInfo(Map<String,Object> p){
		return mapper.getQuestionInfo(p);
	}
	public Integer getQuestionCount(Map<String,Object> p){
		return mapper.getQuestionCount(p);
	}
	public void addQuestion(Map<String,Object> p){
		mapper.addQuestion(p);
	}
	public void addQuestionDetail(Map<String,Object> p){
		mapper.addQuestionDetail(p);
	}
	public void delQuestion(Map<String,Object> p){
		mapper.delQuestion(p);
	}
	public void delQuestionDetail(Map<String,Object> p){
		mapper.delQuestionDetail(p);
	}
	public void delQuestionPaperDetail(Map<String,Object> p){
		mapper.delQuestionPaperDetail(p);
	}
	public List<Map<String,Object>> getAllpaperDetailIdByQusId(Map<String,Object> p){
		return mapper.getAllpaperDetailIdByQusId(p);
	}
	public void delStudScoreDetail(Map<String,Object> p){
		mapper.delStudScoreDetail(p);
	}
	public List<Map<String,Object>> getQuestionDetailInfo(Map<String,Object> p){
		return mapper.getQuestionDetailInfo(p);
	}
	public void updateQuestion(Map<String,Object> p){
		mapper.updateQuestion(p);
	};
	public void updateQuestionDetail(Map<String,Object> p){
		mapper.updateQuestionDetail(p);
	};
	public List<Map<String,Object>> getAccountInfo(Map<String,Object> p){
		return mapper.getAccountInfo(p);
	};
	public Integer getAccountCount(Map<String,Object> p){
		return mapper.getAccountCount(p);
	};

	public void delOperator(Map<String,Object> p){
		mapper.delOperator(p);
	};
	public void delStudentInfo(Map<String,Object> p){
		mapper.delStudentInfo(p);
	};
	public void addStudentInfo(Map<String,Object> p){
		mapper.addStudentInfo(p);
	};
	public void addAccount(Map<String,Object> p){
		mapper.addAccount(p);
	};
	public Map<String,Object> getUpdateAccountInfo(Map<String,Object> p){
		return mapper.getUpdateAccountInfo(p);
	};
	public Map<String,Object> getStudentInfo(Map<String,Object> p){
		return mapper.getStudentInfo(p);
	};
	public void updateOperatorInfo(Map<String,Object> p){
		mapper.updateOperatorInfo(p);
	};
	public void updateStudentInfo(Map<String,Object> p){
		mapper.updateStudentInfo(p);
	};
}
