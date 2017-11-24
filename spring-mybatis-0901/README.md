
 示例0901：MyBatis 基本用法（XML配置增删改查）
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
	<!-- insert操， -->
	<!-- parameterType="user"表示该插入语句需要一个user对象作为参数 -->
	<!-- useGeneratedKeys="true"表示使用自动增长的主键 -->
	<insert id="saveUser" parameterType="user" useGeneratedKeys="true"
		keyProperty="id">
		INSERT INTO TB_USER(name,sex,age)
		VALUES(#{name},#{sex},#{age})
	</insert>

	<!-- select操作 -->
	<!-- parameterType="int"表示该查询语句需要一个int类型的参数 -->
	<!-- resultType="user"表示返回的是一个user对象 -->
	<select id="selectUser" parameterType="int" resultType="user">
		SELECT * FROM TB_USER WHERE id = #{id}
	</select>

	<!-- update操作 -->
	<!-- parameterType="user"表示该更新语句需要一个user对象作为参数 -->
	<update id="modifyUser" parameterType="user">
		UPDATE TB_USER
		SET name = #{name},sex = #{sex},age = #{age}
		WHERE id = #{id}
	</update>

	<!-- delete操作 -->
	<!-- parameterType="int"表示该查询语句需要一个int类型的参数 -->
	<delete id="removeUser" parameterType="int">
		DELETE FROM TB_USER WHERE id = #{id}
	</delete>

</mapper>
```

代码2：mybatis-config.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
  <!--  XML 配置文件包含对 MyBatis 系统的核心设置 -->
<configuration>
	<properties resource="db.properties"/>
	<!-- 指定 MyBatis 所用日志的具体实现 -->
	<settings>
		<setting name="logImpl" value="LOG4J"/>
	</settings>
	<!-- 设置别名 -->
	<typeAliases>
		<typeAlias  alias="user" type="org.fkit.domain.User"/>
	</typeAliases>
	<environments default="mysql">
	<!-- 环境配置，即连接的数据库。 -->
    <environment id="mysql">
    <!--  指定事务管理类型，type="JDBC"指直接简单使用了JDBC的提交和回滚设置 -->
      <transactionManager type="JDBC"/>
      <!--  dataSource指数据源配置，POOLED是JDBC连接对象的数据源连接池的实现。 -->
      <dataSource type="POOLED">
        <property name="driver" value="${driver}"/>
        <property name="url" value="${url}"/>
        <property name="username" value="${username}"/>
        <property name="password" value="${password}"/>
      </dataSource>
    </environment>
  </environments>
  <!-- mappers告诉了MyBatis去哪里找持久化类的映射文件 -->
  <mappers>
  	<mapper resource="org/fkit/mapper/UserMapper.xml"/>
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

代码4：InsertTest.java

```java
package org.fkit.test;

import org.apache.ibatis.session.SqlSession;
import org.fkit.domain.User;
import org.fkit.factory.FKSqlSessionFactory;

public class InsertTest {

	public static void main(String[] args) throws Exception {
		// 获得Session实例
		SqlSession session = FKSqlSessionFactory.getSqlSession();
		// 创建User对象
		User user = new User("jack", "男", 22);
		// 插入数据
		session.insert("org.fkit.mapper.UserMapper.saveUser", user);
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
DEBUG [main] - ==> Parameters: jack(String), 男(String), 22(Integer)
DEBUG [main] - <==    Updates: 1
```


代码5：SelectTest.java

```java
package org.fkit.test;

import org.apache.ibatis.session.SqlSession;
import org.fkit.domain.User;
import org.fkit.factory.FKSqlSessionFactory;

public class SelectTest {

	public static void main(String[] args) throws Exception {
		// 获得Session实例
		SqlSession session = FKSqlSessionFactory.getSqlSession();
		// 根据id查询User对象
		User user = session.selectOne("org.fkit.mapper.UserMapper.selectUser",
				1);
		System.out.println(user);
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
DEBUG [main] - ==>  Preparing: SELECT * FROM TB_USER WHERE id = ? 
DEBUG [main] - ==> Parameters: 1(Integer)
DEBUG [main] - <==      Total: 1
User [id=1, name=jack, sex=男, age=22]
```


代码6：UpadeTest.java

```java
package org.fkit.test;

import org.apache.ibatis.session.SqlSession;
import org.fkit.domain.User;
import org.fkit.factory.FKSqlSessionFactory;

public class UpadeTest {

	public static void main(String[] args) throws Exception {
		// 获得Session实例
		SqlSession session = FKSqlSessionFactory.getSqlSession();
		// 根据id查询User对象
		User user = session.selectOne("org.fkit.mapper.UserMapper.selectUser",
				1);
		// 修改User对象的属性值
		user.setName("tom");
		user.setAge(25);
		// 修改User对象
		session.update("org.fkit.mapper.UserMapper.modifyUser", user);
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
DEBUG [main] - ==>  Preparing: SELECT * FROM TB_USER WHERE id = ? 
DEBUG [main] - ==> Parameters: 1(Integer)
DEBUG [main] - <==      Total: 1
DEBUG [main] - ==>  Preparing: UPDATE TB_USER SET name = ?,sex = ?,age = ? WHERE id = ? 
DEBUG [main] - ==> Parameters: tom(String), 男(String), 25(Integer), 1(Integer)
DEBUG [main] - <==    Updates: 1
```

代码7：InsertTest.java

```java
package org.fkit.test;

import org.apache.ibatis.session.SqlSession;
import org.fkit.factory.FKSqlSessionFactory;

public class DeleteTest {

	public static void main(String[] args) throws Exception {
		// 获得Session实例
		SqlSession session = FKSqlSessionFactory.getSqlSession();
		// 删除id为1的User对象
		session.delete("org.fkit.mapper.UserMapper.removeUser", 1);
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
DEBUG [main] - ==>  Preparing: DELETE FROM TB_USER WHERE id = ? 
DEBUG [main] - ==> Parameters: 1(Integer)
DEBUG [main] - <==    Updates: 1
```