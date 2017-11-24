package zhaojin.dao;

import java.util.Map;

public interface LoginDao {
	public void regis(Map<String,Object> p);
	public Map<String,Object> findInfoByUserName(Map<String,Object> p);
}
