package demo.service.impl;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import us.codecraft.webmagic.Spider;
import util.ConfigurationUtils;
import demo.pipeline.PositionDetailPipeline;
import demo.service.ISpiderOschinaService;
import demo.spider.PositionDetailPageProcessor;
import demo.spider.TotalPositionPageProcessor;

@Service
public class SpiderOschinaServiceImpl implements Runnable,ISpiderOschinaService {

	/**
	 * 日志记录器
	 */
	private static final Logger logger = LoggerFactory.getLogger(SpiderOschinaServiceImpl.class);

	/**
	 * 抓取地址
	 */
	private static final String URL = ConfigurationUtils.getString("url");

	/**
	 * 总的职位数量
	 */
	public static String totalPosition;
	
	public static String totalPage;

	@Override
	public void run() {
		crawlData();
	}
	
	public static List<String> rulList = null;//每一页的请求
	// 抓取地址https://job.oschina.net/search?type=%E8%81%8C%E4%BD%8D%E6%90%9C%E7%B4%A2&key=&exp=0&edu=0&nat=1&city=%E5%85%A8%E5%9B%BD&p=1
	public void crawlData(){
		logger.info("开始抓取数据******************");
		// 步骤1：获取总条数
		String spiderUrl = MessageFormat.format(URL, 1);
		Spider.create(new TotalPositionPageProcessor()).addUrl(spiderUrl).thread(1).run();
		logger.info("总数据量："+totalPosition+"   总页数："+totalPage);
		
		if(totalPage!=null && !"".equals(totalPage) && Integer.parseInt(totalPage)>0){
			int totalPages = Integer.parseInt(totalPage);
			rulList = new ArrayList<String>();
            for (int i = 0; i < totalPages; i++) {
            		System.out.println(MessageFormat.format(URL,i + 1));
            		rulList.add(MessageFormat.format(URL,i + 1));
             }
		}
		//步骤2获取所有职位详情
		Spider.create(new PositionDetailPageProcessor()).addPipeline(new PositionDetailPipeline()).
		addUrl("https://job.oschina.net/search?type=%E8%81%8C%E4%BD%8D%E6%90%9C%E7%B4%A2&key=&exp=0&edu=0&nat=1&city=%E5%85%A8%E5%9B%BD&p=1").
		run();
		
		logger.info("抓取数据结束******************");
	}
	
	
	
	/**
	 * 获取唯一对象，本来应该通过注解获取本service，但是spring和quartz注解有问题，所以先这么弄
	 */
	private  SpiderOschinaServiceImpl(){}
	private static SpiderOschinaServiceImpl spiderService=null;  
    public static SpiderOschinaServiceImpl getInstance() {  
         if (spiderService == null) {    
        	 spiderService = new SpiderOschinaServiceImpl();  
         }    
        return spiderService;  
    }  
	
	
    public static void main(String[] args) {
    	new SpiderOschinaServiceImpl().crawlData();
	}
}
