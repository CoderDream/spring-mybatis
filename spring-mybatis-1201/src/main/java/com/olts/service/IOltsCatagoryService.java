package com.olts.service;

import java.util.List;

import com.olts.vo.OltsCatagory;

public interface IOltsCatagoryService {
	/**
	 * 课程列表
	 * @return
	 */
	public List<OltsCatagory> findListForCatagory();
	/**
	 * 添加课程
	 * @param catagory
	 * @return
	 */
	public int saveCatagory(OltsCatagory catagory);
	/**
	 * 删除课程
	 * @param id
	 * @return
	 */
	public int deleteCatagory(Integer id);
	/**
	 * 跟新课程名
	 * @param catagory
	 * @return
	 */
	public int updateCatagory(OltsCatagory catagory);
	/**
	 * 根据编号查询课程
	 * @param id
	 * @return
	 */
	public OltsCatagory findById(Integer id);
}
