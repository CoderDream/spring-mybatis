package demo.spider;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.processor.PageProcessor;
import demo.service.impl.SpiderOschinaServiceImpl;

/**
 * PageProcessor负责解析页面，抽取有用信息，以及发现新的链接。
 * WebMagic使用Jsoup作为HTML解析工具，并基于其开发了解析XPath的工具Xsoup。
 */
public class TotalPositionPageProcessor implements PageProcessor{

	/**
     * 日志记录器
     */
    private static final Logger logger = LoggerFactory.getLogger(TotalPositionPageProcessor.class);
	
	 //抓取网站的相关配置，包括编码、抓取间隔、重试次数等
	private Site site = Site.me().setRetryTimes(3).setSleepTime(100);
	
	// process是定制爬虫逻辑的核心接口，在这里编写抽取逻辑
	@Override
	public void process(Page page) {
		 // 匹配出总条数
		String count = page.getHtml().xpath("//div[@class='layout-column article']/div/div/div[@class='layout-column']/div/text()").regex("([0-9]+)").toString();
		logger.info("总数据量为："+count);
		SpiderOschinaServiceImpl.totalPosition = count;
        //匹配出总页数
        List<String> pageCount = page.getHtml().xpath("//div[@class='pagination text-center']/ul/li/a/text()").all();
        logger.info("总页数为："+pageCount.get(pageCount.size()-2));
        SpiderOschinaServiceImpl.totalPage = pageCount.get(pageCount.size()-2);
	}

	@Override
	public Site getSite() {
		return site;
	}

}
