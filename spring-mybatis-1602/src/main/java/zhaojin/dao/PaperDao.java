package zhaojin.dao;

import java.util.List;
import java.util.Map;

public interface PaperDao {
	public List<Map<String,Object>> getPaperInfo(Map<String,Object> p);
	public int getPaperCount(Map<String,Object> p);
	public List<Map<String,Object>> getPaperDetailInfo(Map<String,Object> p);
	
	
	public void delPaper(Map<String,Object> p);
	public void delPaperDetail(Map<String,Object> p);
	public List<Map<String,Object>> getAllpaperDetailIdByPaperId(Map<String,Object> p);
	public void delStudScoreDetailByPaperId(Map<String,Object> p);
	
	
	public void addPaperQuest(Map<String,Object> p);
	public void delPaperQuest(Map<String,Object> p);
	public void addPaper(Map<String,Object> p);
	public void addPaperDetail(Map<String,Object> p);
	
	
	public void updatePaperInfo(Map<String,Object> p);
}
