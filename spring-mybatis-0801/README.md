
 示例0801：MyBatis 入门
----------


框架版本
----------
maven, spring 4.3.9

核心代码
----------
代码1：UserMapper.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- namespace指用户自定义的命名空间。 -->
<mapper namespace="org.fkit.mapper.UserMapper">

	<!-- id="save"是唯一的标示符 parameterType属性指明插入时使用的参数类型 useGeneratedKeys="true"表示使用数据库的自动增长策略 -->
	<insert id="save" parameterType="org.fkit.domain.User"
		useGeneratedKeys="true">
		INSERT INTO TB_USER(name,sex,age)
		VALUES(#{name},#{sex},#{age})
	</insert>

</mapper>
```

代码2：mybatis-config.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
<!-- XML 配置文件包含对 MyBatis 系统的核心设置 -->
<configuration>
	<!-- 指定 MyBatis 所用日志的具体实现 -->
	<settings>
		<setting name="logImpl" value="LOG4J" />
	</settings>
	<environments default="mysql">
		<!-- 环境配置，即连接的数据库。 -->
		<environment id="mysql">
			<!-- 指定事务管理类型，type="JDBC"指直接简单使用了JDBC的提交和回滚设置 -->
			<transactionManager type="JDBC" />
			<!-- dataSource指数据源配置，POOLED是JDBC连接对象的数据源连接池的实现。 -->
			<dataSource type="POOLED">
				<property name="driver" value="com.mysql.jdbc.Driver" />
				<property name="url"
					value="jdbc:mysql://127.0.0.1:3306/spring_mybatis_0801" />
				<property name="username" value="root" />
				<property name="password" value="1234" />
			</dataSource>
		</environment>
	</environments>
	<!-- mappers告诉了MyBatis去哪里找持久化类的映射文件 -->
	<mappers>
		<mapper resource="org/fkit/mapper/UserMapper.xml" />
	</mappers>
</configuration>
```

代码3：MyBatisTest.java

```java
package org.fkit.test;

import java.io.InputStream;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.fkit.domain.User;

public class MyBatisTest {

	public static void main(String[] args) throws Exception {
		// 读取mybatis-config.xml文件
		InputStream inputStream = Resources
				.getResourceAsStream("mybatis-config.xml");
		// 初始化mybatis，创建SqlSessionFactory类的实例
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder()
				.build(inputStream);
		// 创建Session实例
		SqlSession session = sqlSessionFactory.openSession();
		// 创建User对象
		User user = new User("admin", "男", 26);
		// 插入数据
		session.insert("org.fkit.mapper.UserMapper.save", user);
		// 提交事务
		session.commit();
		// 关闭Session
		session.close();
	}

}
```



控制台信息
----------
```
DEBUG [main] - ==>  Preparing: INSERT INTO TB_USER(name,sex,age) VALUES(?,?,?) 
DEBUG [main] - ==> Parameters: admin(String), 男(String), 26(Integer)
DEBUG [main] - <==    Updates: 1
```