package demo.spider;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



import us.codecraft.webmagic.Spider;
import demo.pipeline.PositionDetailPipeline;
import demo.service.ISpiderOschinaService;
import demo.service.impl.SpiderOschinaServiceImpl;



/**
 * 	抓取开源中国招聘频道页面数据
 *  地址：https://job.oschina.net/search
 */
public class SpiderOschinaJob implements Job{
	 /**
     * 日志记录器
     */
    private static final Logger logger = LoggerFactory.getLogger(SpiderOschinaJob.class);

    //这个service应该通过注解获得，但是spring和quartz注解获取service有问题，待解决
    //@Autowired
    public ISpiderOschinaService spiderOschinaService;
    

	@Override
	public  void execute(JobExecutionContext context)
			throws JobExecutionException {
		// 开始时间
        long startDate = System.currentTimeMillis();
        //通过注解的形式获取service
//        SchedulerContext skedCtx = context.getScheduler().getContext();
//        spiderOschinaService = (ISpiderOschinaService) skedCtx.get("spiderOschinaService");
        spiderOschinaService = SpiderOschinaServiceImpl.getInstance();
		// 建立线程池
        ExecutorService pool = Executors.newFixedThreadPool(2);
        // 将执行对象放入线程池
        Runnable runnable = (Runnable)spiderOschinaService;
        pool.submit(runnable);
        // 关闭线程池
        pool.shutdown();
//        // 结束时间
        long endDate = System.currentTimeMillis();
        logger.info("共耗时："+(endDate-startDate));
		
	}
    
}
