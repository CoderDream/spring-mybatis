package util;

import java.math.BigDecimal;
import java.util.List;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 配置文件工具类<br>
 * 用来读取properties文件中的配置信息
 *
 * @author 931636882@qq.com
 * @version [版本号, 2014年11月14日]
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class ConfigurationUtils {

    /**
     * 日志记录器
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(ConfigurationUtils.class);

    private static Configuration config = null;
    static {
        try {
            // 加载配置文件，如果不止这一个配置文件，则include进去
            config = new PropertiesConfiguration("properties/spider.properties");
        } catch (ConfigurationException e) {
            LOGGER.error(e.getMessage(), e);
        }
    }

    /**
     * 
     * 功能描述: <br>
     * 获取BigDecimal类型的数据
     *
     * @version [版本号, 2014年11月14日]
     * @param key 键
     * @return
     * @since [产品/模块版本](可选)
     */
    public static BigDecimal getBigDecimal(String key) {
        return config.getBigDecimal(key);
    }

    /**
     * 
     * 功能描述: <br>
     * 获取布尔类型的数据
     *
     * @version [版本号, 2014年11月14日]
     * @param key 键
     * @return
     * @since [产品/模块版本](可选)
     */
    public static boolean getBoolean(String key) {
        return config.getBoolean(key, false);
    }

    /**
     * 
     * 功能描述: <br>
     * 获取字符串类型的数据
     *
     * @version [版本号, 2014年11月14日]
     * @param key 键
     * @return
     * @since [产品/模块版本](可选)
     */
    public static String getString(String key) {
        return config.getString(key);
    }

    /**
     * 
     * 功能描述: <br>
     * 获取整型的数据
     *
     * @version [版本号, 2014年11月14日]
     * @param key 键
     * @return
     * @since [产品/模块版本](可选)
     */
    public static int getInt(String key) {
        return config.getInt(key);
    }

    /**
     * 
     * 功能描述: <br>
     * 获取集合数据（配置文件中所有相同键的值）
     *
     * @version [版本号, 2014年11月14日]
     * @param key 键
     * @return
     * @since [产品/模块版本](可选)
     */
    public static List<Object> getList(String key) {
        List<Object> list =  config.getList(key);
        return list;
    }
}
