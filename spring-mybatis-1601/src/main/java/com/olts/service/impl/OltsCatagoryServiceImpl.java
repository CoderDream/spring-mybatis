package com.olts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.olts.mapper.OltsCatagoryMapper;
import com.olts.service.IOltsCatagoryService;
import com.olts.vo.OltsCatagory;


@Service("oltsCatagoryService")
public class OltsCatagoryServiceImpl implements IOltsCatagoryService{

	//注入mapper映射器接口
		@Resource
		private OltsCatagoryMapper oltsCatagoryMapper;

		@Override
		public List<OltsCatagory> findListForCatagory() {
			List<OltsCatagory> list=oltsCatagoryMapper.selectFindAll();
			return list;
		}

		@Override
		public int saveCatagory(OltsCatagory catagory) {
			int row=oltsCatagoryMapper.insertCatagory(catagory);
			return row;
		}

		@Override
		public int deleteCatagory(Integer id) {
			int row=oltsCatagoryMapper.removeCatagory(id);
			return row;
		}

		@Override
		public int updateCatagory(OltsCatagory catagory) {
			int row=oltsCatagoryMapper.update(catagory);
			return row;
		}

		@Override
		public OltsCatagory findById(Integer id) {
			OltsCatagory o=oltsCatagoryMapper.findCatagory(id);
			return o;
		}
}
