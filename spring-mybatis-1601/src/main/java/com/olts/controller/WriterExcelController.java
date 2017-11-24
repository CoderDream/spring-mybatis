package com.olts.controller;

import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.olts.service.IOltsUsersService;
import com.olts.vo.OltsUsers;

@Controller
@RequestMapping("/file")
public class WriterExcelController {

	@Resource
	IOltsUsersService oltsUsersService;
	
	/**
	 * 从数据库到excel表
	 * @param user
	 * @return
	 */
	@RequestMapping("/dowload.do")
	public String fileUser(OltsUsers user, CommonsMultipartFile file, 
				HttpServletResponse response){
		List<OltsUsers> userList= oltsUsersService.findAll(user);
		try {
			byte[] buf = file.getBytes();
			// 创建工作本
			Workbook wb = new HSSFWorkbook(new POIFSFileSystem(new ByteArrayInputStream(buf)));
			Sheet sheet = wb.getSheetAt(0);
			int rowIdx = 0;
			
			for (OltsUsers u : userList) {
				//新建一行
				Row row = sheet.createRow(rowIdx++);
				Cell cell = null;
				cell = row.createCell(0);
				CellStyle style = cell.getCellStyle();
				style.setAlignment(CellStyle.ALIGN_CENTER);
				cell.setCellStyle(style); //设置单元格的样式
				cell.setCellValue(u.getId());
				
				cell = row.createCell(1);
				cell.setCellValue(u.getStuNo());
				
				cell = row.createCell(2);
				cell.setCellValue(u.getIdCardNo());
				
				cell = row.createCell(3);
				cell.setCellValue(u.getUserName());
				
				cell = row.createCell(4);
				cell.setCellValue(u.getPassWord());
				
				cell = row.createCell(5);
				cell.setCellValue(u.getMobile());
				
				//日期类型以字符串形式写入
				//cell.setCellValue(sdf.format(u.getBirthday()));
			}
			//写入文件
			response.reset();
			String fileName = new String(file.getFileItem().getName().getBytes(),"iso-8859-1");
			//设置下载文件的头部信息， 以附件的形式下载filename为客户端弹出现的下载框中的默认文件名
			response.setHeader("Content-Disposition", "attachment; filename="+fileName );  
			response.setContentType("application/msexcel; charset=utf-8");  //application/octet-stream表示*.rar文件
			
			wb.write(response.getOutputStream());
			System.out.println("--------------完成------------------------");
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "pages/user/importExcel_input";
	}
	
	/**
	 * 从Exel表到数据库
	 * @return
	 */
	@RequestMapping(value="/upload.do",method=RequestMethod.POST)
	public String upload(@RequestParam("file") CommonsMultipartFile file,HttpServletRequest request){
		
		List<OltsUsers> userlist= new ArrayList<OltsUsers>();
		//记录数据库已经有的用户数
		int num=0;
		try {
			byte[] buf = file.getBytes();
			// 创建工作本
			Workbook wb = new HSSFWorkbook(new POIFSFileSystem(new ByteArrayInputStream(buf)));
			//得到第一个工作表
			Sheet sheet = wb.getSheet("list");
			//得到工作表中的行数
			int numberOfRows = sheet.getPhysicalNumberOfRows();
			System.out.println("总行数：" + numberOfRows);
			
			//rowIdx = 1就是从第二行开始
			for (int rowIdx = 1; rowIdx < numberOfRows; rowIdx++) {
				//得到每一行
				Row row = sheet.getRow(rowIdx);
				//得到每一个单元格
				Cell cell = null;
				cell = row.getCell(0);
				Integer id = (int)cell.getNumericCellValue();
				
				cell = row.getCell(1);
				Integer stuNo=(int) cell.getNumericCellValue();
				
				cell = row.getCell(2);
				String idCardNo = cell.getStringCellValue();
				
				//第3行为姓名，不在插入的范围
				cell = row.getCell(3);
				String name = cell.getStringCellValue();
				
				cell = row.getCell(4);
				String userName = cell.getStringCellValue();
				
				cell = row.getCell(5);
				String passWord = cell.getStringCellValue();
				
				cell = row.getCell(6);
				Integer mobile = (int)cell.getNumericCellValue();
				
				cell = row.getCell(7);
				String homeTel = cell.getStringCellValue();
				
				cell = row.getCell(8);
				String homeAddr = cell.getStringCellValue();
				
				cell = row.getCell(9);
				String schAddr = cell.getStringCellValue();
				
				cell = row.getCell(10);
				Integer qq = (int)cell.getNumericCellValue();
				
				cell = row.getCell(11);
				String email = cell.getStringCellValue();
				
				cell = row.getCell(12);
				Integer userType = (int)cell.getNumericCellValue();
				
				cell = row.getCell(13);
				String gender = cell.getStringCellValue();
				//取时间
				cell = row.getCell(14);
				Date birthday = cell.getDateCellValue();
				
				cell = row.getCell(15);
				String nationPlace = cell.getStringCellValue();
				
				cell = row.getCell(16);
				String marjor = cell.getStringCellValue();
				
				cell = row.getCell(17);
				String eduBackground = cell.getStringCellValue();
				
				cell = row.getCell(18);
				String graduteSchool = cell.getStringCellValue();
				
				
				
//				System.out.println("\n=id：" + id+","+stuNo+","+idCardNo+","+name+","+userName+","+passWord
//						+","+mobile+","+homeTel+","+homeAddr+","+schAddr+","+qq+","+email+","+userType
//						+","+gender+","+birthday+","+nationPlace+","+marjor+","+eduBackground+","+graduteSchool);
				//封装成类时，注意数据类型
				String _stuNo= stuNo.toString();
				String _mobile=mobile.toString();
				String _qq=qq.toString();

				OltsUsers user=new OltsUsers(id, _stuNo, idCardNo, userName, passWord, 
						_mobile, homeTel, homeAddr, schAddr, _qq, email, userType, gender, 
						birthday, nationPlace, marjor, eduBackground, graduteSchool);

				System.out.println("========="+user);
			
				//存到列表
				userlist.add(user);
				//把用户存到数据库
				/*try {
					oltsUsersService.savaUser(user);
				} catch (Exception e) {
					num++;
					e.printStackTrace();
				}	*/			
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		} 
		//把用户存到数据库,mybatis批量插入
		oltsUsersService.savaUser2(userlist);
		
		request.setAttribute("num", num);
		return "redirect:/user/findAll.do";
		
	}
}
