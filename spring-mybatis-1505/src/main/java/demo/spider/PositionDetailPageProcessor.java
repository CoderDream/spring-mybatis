package demo.spider;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.processor.PageProcessor;
import demo.service.impl.SpiderOschinaServiceImpl;

//每一个连接都会进入processor方法中进行抽取
public class PositionDetailPageProcessor implements PageProcessor{

	 //抓取网站的相关配置，包括编码、抓取间隔、重试次数等
	private Site site = Site.me().setRetryTimes(3).setSleepTime(100);
	
	//列表页https://job.oschina.net/search?type=%E8%81%8C%E4%BD%8D%E6%90%9C%E7%B4%A2&key=&exp=0&edu=0&nat=1&city=%E5%85%A8%E5%9B%BD&p=1
	public static final String URL_LIST = "https://job\\.oschina\\.net/search\\?type=%E8%81%8C%E4%BD%8D%E6%90%9C%E7%B4%A2&key=&exp=0&edu=0&nat=1&city=%E5%85%A8%E5%9B%BD&p=\\d+";
	
	//详情页https://job.oschina.net/position/11317_2828767_27953
	public static final String URL_POST = "https://job\\.oschina\\.net/position/\\w+";
	
	//有一个url这个方法和pipeline里的process方法都会再执行一遍
	@Override
	public void process(Page page) {
		//列表页
		if(page.getUrl().regex(URL_LIST).match()){
			System.out.println("将第几页连接放入待抓取队列中");
			page.addTargetRequests(page.getHtml().xpath("//div[@class='layout-left title']/a/@href").all());//获取详情页地址进行结果抽取
			page.addTargetRequests(SpiderOschinaServiceImpl.rulList);//获取所有页面的连接并进行抽取
		}else{//详情页
			System.out.println("抽取详情页数据");
			page.putField("name", page.getHtml().xpath("//div[@class='col-xs-9']/h1/@title"));//职位
			page.putField("salary", page.getHtml().xpath("//div[@class='col-xs-9']/div/b/text()"));//薪资
			String require = page.getHtml().xpath("//span[@id='ex-position-skills']/a/text()").all().toString().replace(",", "/");
			page.putField("require", require.substring(1, require.length()-1));//要求
			page.putField("company", page.getHtml().xpath("//h3[@class='text-left']/strong/a/text()"));//公司
		}
	}

	
	
	
	@Override
	public Site getSite() {
		return site;
	}

}
