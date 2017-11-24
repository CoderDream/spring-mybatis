package com.olts.mapper;

import java.util.List;

import com.olts.vo.OltsCatagory;


public interface OltsCatagoryMapper {
	/**
	 * 查询所有课程
	 * @return
	 */
	public List<OltsCatagory> selectFindAll();
	/**
	 * 添加课程
	 * @param catagory
	 * @return
	 */
	public int insertCatagory(OltsCatagory catagory);
	/**
	 * 删除课程
	 * @param id
	 * @return
	 */
	public int removeCatagory(Integer id);
	/**
	 * 更新课程名
	 * @param catagory
	 * @return
	 */
	public int update(OltsCatagory catagory);
	/**
	 * 查找指定课程
	 * @param id
	 * @return
	 */
	public OltsCatagory findCatagory(Integer id);
}
