
 示例0902：测试 ResultMaps
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

	<!-- id="save"是唯一的标示符 -->
	<!-- parameterType属性指明插入时使用的参数类型 -->
	<!-- useGeneratedKeys="true"表示使用数据库的自动增长策略 -->
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

代码3：FKSqlSessionFactory.java

```java
package org.fkit.factory;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class FKSqlSessionFactory {

	private static SqlSessionFactory sqlSessionFactory = null;

	// 初始化创建SqlSessionFactory对象
	static {
		try {
			// 读取mybatis-config.xml文件
			InputStream inputStream = Resources
					.getResourceAsStream("mybatis-config.xml");
			sqlSessionFactory = new SqlSessionFactoryBuilder()
					.build(inputStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 获取SqlSession对象的静态方法
	public static SqlSession getSqlSession() {
		return sqlSessionFactory.openSession();
	}

	// 获取SqlSessionFactory的静态方法
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}

}

```

代码4：SelectMapTest.java

```java
package org.fkit.test;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.fkit.factory.FKSqlSessionFactory;

public class SelectMapTest {

	public static void main(String[] args) throws Exception {
		// 获得Session实例
		SqlSession session = FKSqlSessionFactory.getSqlSession();
		// 查询TB_USER表所有数据返回List集合,集合中的每个元素都是一个Map
		List<Map<String, Object>> list = session
				.selectList("org.fkit.mapper.UserMapper.selectUser");
		// 遍历List集合，打印每一个Map对象
		for (Map<String, Object> row : list) {
			System.out.println(row);
		}
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
DEBUG [main] - ==>  Preparing: SELECT * FROM TB_USER 
DEBUG [main] - ==> Parameters: 
DEBUG [main] - <==      Total: 4
{sex=男, name=jack, id=2, age=22}
{sex=女, name=rose, id=3, age=18}
{sex=男, name=tom, id=4, age=25}
{sex=女, name=mary, id=5, age=20}
```

代码5：ResultMapTest.java

```java
package org.fkit.test;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.fkit.domain.User;
import org.fkit.factory.FKSqlSessionFactory;

public class ResultMapTest {

	public static void main(String[] args) {
		// 获得Session实例
		SqlSession session = FKSqlSessionFactory.getSqlSession();
		// 查询TB_USER表所有数据返回List集合,集合中的每个元素都是一个Map
		List<User> user_list = session
				.selectList("org.fkit.mapper.UserMapper.selectUser2");
		// 遍历List集合，打印每一个Map对象
		for (User user : user_list) {
			System.out.println(user);
		}
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
DEBUG [main] - ==>  Preparing: SELECT * FROM TB_USER2 
DEBUG [main] - ==> Parameters: 
DEBUG [main] - <==      Total: 4
User [id=1, name=jack, sex=男, age=22]
User [id=2, name=rose, sex=女, age=18]
User [id=3, name=tom, sex=男, age=25]
User [id=4, name=mary, sex=女, age=20]
```

代码6：SelectStudentTest.java

```java
package org.fkit.test;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.fkit.domain.Student;
import org.fkit.factory.FKSqlSessionFactory;

public class SelectStudentTest {

	public static void main(String[] args) throws Exception {
		// 获得Session实例
		SqlSession session = FKSqlSessionFactory.getSqlSession();
		// 查询TB_USER表所有数据返回List集合,集合中的每个元素都是一个Student对象
		List<Student> student_list = session
				.selectList("org.fkit.mapper.UserMapper.selectStudent");
		// 遍历List集合，打印每一个Student对象，该对象包含关联的Clazz对象
		for (Student stu : student_list) {
			System.out.println(stu);
		}
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
DEBUG [main] - ==>  Preparing: SELECT * FROM TB_STUDENT 
DEBUG [main] - ==> Parameters: 
DEBUG [main] - ====>  Preparing: SELECT * FROM TB_CLAZZ where id = ? 
DEBUG [main] - ====> Parameters: 1(Integer)
DEBUG [main] - <====      Total: 1
DEBUG [main] - ====>  Preparing: SELECT * FROM TB_CLAZZ where id = ? 
DEBUG [main] - ====> Parameters: 2(Integer)
DEBUG [main] - <====      Total: 1
DEBUG [main] - <==      Total: 4
Student [id=1, name=jack, sex=男, age=22, clazz=Clazz [id=1, code=j1601]]
Student [id=2, name=rose, sex=女, age=18, clazz=Clazz [id=1, code=j1601]]
Student [id=3, name=tom, sex=男, age=25, clazz=Clazz [id=2, code=j1602]]
Student [id=4, name=mary, sex=女, age=20, clazz=Clazz [id=2, code=j1602]]
```


代码4：SelectClazzTest.java

```java
package org.fkit.test;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.fkit.domain.Clazz;
import org.fkit.domain.Student;
import org.fkit.factory.FKSqlSessionFactory;

public class SelectClazzTest {

	public static void main(String[] args) throws Exception {
		// 获得Session实例
		SqlSession session = FKSqlSessionFactory.getSqlSession();
		// 查询TB_CLAZZ表所有数据返回List集合,集合中的每个元素都是一个Clazz对象
		List<Clazz> clazz_list = session
				.selectList("org.fkit.mapper.UserMapper.selectClazz");
		// 遍历List集合，打印每一个Clazz对象和该Clazz关联的所有Student对象
		for (Clazz clazz : clazz_list) {
			System.out.println(clazz);
			List<Student> student_list = clazz.getStudents();
			for (Student stu : student_list) {
				System.out.println(stu.getId() + " " + stu.getName() + " "
						+ stu.getSex() + " " + stu.getAge());
			}
		}
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
DEBUG [main] - ==>  Preparing: SELECT * FROM TB_CLAZZ 
DEBUG [main] - ==> Parameters: 
DEBUG [main] - ====>  Preparing: SELECT * FROM TB_STUDENT where clazz_id = ? 
DEBUG [main] - ====> Parameters: 1(Integer)
DEBUG [main] - <====      Total: 2
DEBUG [main] - ====>  Preparing: SELECT * FROM TB_STUDENT where clazz_id = ? 
DEBUG [main] - ====> Parameters: 2(Integer)
DEBUG [main] - <====      Total: 2
DEBUG [main] - <==      Total: 2
Clazz [id=1, code=j1601]
1 jack 男 22
2 rose 女 18
Clazz [id=2, code=j1602]
3 tom 男 25
4 mary 女 20
```

