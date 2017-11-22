package zhaojin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zhaojin.dao.PaperDao;

@Service("paperService")
public class PaperService {
	@Autowired
	private PaperDao mapper;
	
	public List<Map<String,Object>> getPaperInfo(Map<String,Object> p){
		return mapper.getPaperInfo(p);
	};
	public int getPaperCount(Map<String,Object> p){
		return mapper.getPaperCount(p);
	};
	public void delPaper(Map<String,Object> p){
		mapper.delPaper(p);
	};
	public void delPaperDetail(Map<String,Object> p){
		mapper.delPaperDetail(p);
	};
	public List<Map<String,Object>> getAllpaperDetailIdByPaperId(Map<String,Object> p){
		return mapper.getAllpaperDetailIdByPaperId(p);
	};
	public void delStudScoreDetailByPaperId(Map<String,Object> p){
		mapper.delStudScoreDetailByPaperId(p);
	};
	public List<Map<String,Object>> getPaperDetailInfo(Map<String,Object> p){
		return mapper.getPaperDetailInfo(p);
	};
	public void addPaperQuest(Map<String,Object> p){
		mapper.addPaperQuest(p);
	};
	public void delPaperQuest(Map<String,Object> p){
		mapper.delPaperQuest(p);
	};
	public void updatePaperInfo(Map<String,Object> p){
		mapper.updatePaperInfo(p);
	};
	public void addPaper(Map<String,Object> p){
		mapper.addPaper(p);
	};
	public void addPaperDetail(Map<String,Object> p){
		mapper.addPaperDetail(p);
	};
}
