package test;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.olts.service.IOltsScoreService;
import com.olts.service.ITechCatagoryService;
import com.olts.vo.OltsScore;
import com.olts.vo.TechCatagory;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:applicationContext.xml" })
public class OltsCatagoryServiceImplTest {

	@Resource
	ITechCatagoryService service;

	@Resource
	private IOltsScoreService iOltsScoreService;

	// @Test
	public void testSaveForCatagory() {
		TechCatagory techcatagory = new TechCatagory(25, "qqq", null);
		service.updateTech(techcatagory);
	}

	@Test
	public void testxxx() {
		OltsScore e = new OltsScore();
		e.setUserId(2);
		e.setExamNo("XHDX25111104");
		e.setScore(99.0);
		System.out.println("\n测试中结果=========================" + e);
		// insert操作
		iOltsScoreService.insertScore(e);
	}

}
