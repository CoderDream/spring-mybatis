package com.olts.service;

import java.util.List;

import com.olts.vo.OltsCatagory;
import com.olts.vo.TechCatagory;

public interface ITechCatagoryService {
	/**
	 * 查询课程下所以知识点
	 * @param catagory
	 * @return
	 */
	public List<TechCatagory> listForTech(OltsCatagory catagory);
	/**
	 * 保存知识点
	 * @param techcatagory
	 * @return
	 */
	public int saveTech(TechCatagory techcatagory);
	/**
	 * 删除知识点
	 * @param techcatagory
	 * @return
	 */
	public int deleteTech(TechCatagory techcatagory);
	/**
	 * 更新知识点
	 * @param techcatagory
	 * @return
	 */
	public int updateTech(TechCatagory techcatagory);
}
