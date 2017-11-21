package com.olts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.olts.mapper.OltsCatagoryMapper;
import com.olts.mapper.TechCatagoryMapper;
import com.olts.service.IOltsCatagoryService;
import com.olts.service.ITechCatagoryService;
import com.olts.vo.OltsCatagory;
import com.olts.vo.TechCatagory;


@Service("techCatagoryService")
public class ITechCatagoryServiceImpl implements ITechCatagoryService{

	//注入mapper映射器接口
		@Resource
		private TechCatagoryMapper techsCatagoryMapper;

		@Override
		public List<TechCatagory> listForTech(OltsCatagory catagory) {
			List<TechCatagory> list=techsCatagoryMapper.selectAllTech(catagory.getId());
			return list;
		}

		@Override
		public int saveTech(TechCatagory techcatagory) {
			int i=techsCatagoryMapper.insertTech(techcatagory);
			return i;
		}

		@Override
		public int deleteTech(TechCatagory techcatagory) {
			int i=techsCatagoryMapper.removeTech(techcatagory);
			return i;
		}

		@Override
		public int updateTech(TechCatagory techcatagory) {
			int i=techsCatagoryMapper.updateTech(techcatagory);
			return i;
		}
}
