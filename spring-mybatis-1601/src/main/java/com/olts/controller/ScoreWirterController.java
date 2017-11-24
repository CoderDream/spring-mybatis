package com.olts.controller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.olts.service.IOltsScoreService;
import com.olts.vo.Examination;
import com.olts.vo.OltsScore;

@Controller
@RequestMapping("/writer")
public class ScoreWirterController {
	
	@Resource
	IOltsScoreService oltsScoreService;
	@RequestMapping("/excl.do")
	public String fileUser(Examination u){
		
		List<OltsScore> userList= oltsScoreService.selectScoreAll(u.getExamNo());
		
		System.out.println("======================"+userList.size());
		for (OltsScore o : userList) {
			System.out.println(o);
		}
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		FileOutputStream fileOut = null;
		
		try {
			fileOut = new FileOutputStream("d:\\教学过程记录表.xls");
			//创建一个工作簿
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet("list");
			int rowIdx = 0;
			
			for (OltsScore l : userList) {
				//新建一行
				Row row = sheet.createRow(rowIdx++);
				Cell cell = null;
				cell = row.createCell(0);
				CellStyle style = cell.getCellStyle();
				style.setAlignment(CellStyle.ALIGN_CENTER);
				cell.setCellStyle(style); //设置单元格的样式
				cell.setCellValue(l.getId());
				
				cell = row.createCell(1);
				cell.setCellValue(l.getId());
				
				cell = row.createCell(2);
				cell.setCellValue(l.getUser().getUserName());
				
				cell = row.createCell(3);
				cell.setCellValue(l.getUser().getGender());
				
				cell = row.createCell(4);
				cell.setCellValue(l.getUser().getGraduteSchool());
				
				cell = row.createCell(5);
				cell.setCellValue(l.getUser().getMarjor());
				
				cell=row.createCell(6);
				cell.setCellValue(l.getUser().getEduBackground());
				//日期类型以字符串形式写入
				//cell.setCellValue(sdf.format(u.getBirthday()));
			}
			//写入文件
			wb.write(fileOut);
			fileOut.close();
			System.out.println("--------------完成------------------------");
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "pages/examination/export_score_list";
	}

}
