package demo.pipeline;

import java.util.Map;

import us.codecraft.webmagic.ResultItems;
import us.codecraft.webmagic.Task;
import us.codecraft.webmagic.pipeline.Pipeline;

public class PositionDetailPipeline implements Pipeline{

	@Override
	public void process(ResultItems resultItems, Task task) {
		System.out.println("输出结果:");
        //遍历所有结果，输出到控制台，上面例子中的"name"、"require"、"salary"、"company"都是一个key，其结果则是对应的value
        for (Map.Entry<String, Object> entry : resultItems.getAll().entrySet()) {
            System.out.println(entry.getKey() + "  -------------------->  " + entry.getValue());
        }
       
	}

}
