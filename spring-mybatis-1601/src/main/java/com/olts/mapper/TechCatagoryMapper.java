package com.olts.mapper;

import java.util.List;

import com.olts.vo.OltsCatagory;
import com.olts.vo.TechCatagory;

public interface TechCatagoryMapper {
	/**
	 * 查询课程下的所有知识点
	 * @param catagory
	 * @return
	 */
	public List<TechCatagory> selectAllTech(Integer courseId);
	/**
	 * 添加知识点
	 * @param techcatagory
	 * @return
	 */
	public int insertTech(TechCatagory techcatagory);
	/**
	 * 删除知识点
	 * @param techcatagory
	 * @return
	 */
	public int removeTech(TechCatagory techcatagory);
	/**
	 * 更新知识点名称
	 * @param techcatagory
	 * @return
	 */
	public int updateTech(TechCatagory techcatagory);
}
