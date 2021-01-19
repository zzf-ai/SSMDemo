## 开发工具：IDEA

## 所用技术

Maven

Spring+Mybatis+SpringMvc框架

其中Mybatis用到Mybatis逆向工程技术

Ajax

jquery

Bootstrap前端框架

Mysql8.0

## 项目结构

![image-20210119162732637](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119162732637.png)

![image-20210119162757870](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119162757870.png)

![image-20210119162846525](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119162846525.png)

## pom文件

```
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.zzf.ssm</groupId>
  <artifactId>CRUDTest</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>war</packaging>

  <name>CRUDTest Maven Webapp</name>
  <!-- FIXME change it to the project's website -->
  <url>http://www.example.com</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
  </properties>

  <dependencies>
    <!-- JSR303校验支持 -->
    <dependency>
      <groupId>org.hibernate</groupId>
      <artifactId>hibernate-validator</artifactId>
      <version>6.1.0.Final</version>
    </dependency>

    <!--LOG4日志 start  -->
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-api</artifactId>
      <version>1.6.6</version>
    </dependency>
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-log4j12</artifactId>
      <version>1.6.6</version>
    </dependency>
    <dependency>
      <groupId>log4j</groupId>
      <artifactId>log4j</artifactId>
      <version>1.2.16</version>
    </dependency>
    <!--LOG4日志 end  -->



    <!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
    <dependency>
      <groupId>com.fasterxml.jackson.core</groupId>
      <artifactId>jackson-databind</artifactId>
      <version>2.10.0</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/javax.servlet/jsp-api -->
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>jsp-api</artifactId>
      <version>2.0</version>
      <scope>provided</scope>
    </dependency>

    <!-- https://mvnrepository.com/artifact/com.github.pagehelper/pagehelper -->
    <dependency>
      <groupId>com.github.pagehelper</groupId>
      <artifactId>pagehelper</artifactId>
      <version>5.1.10</version>
    </dependency>

    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
    </dependency>
    <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <version>1.18.12</version>
    </dependency>
    <!-- Spring相关 -->

    <!-- spring-test -->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-test</artifactId>
      <version>5.2.9.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-webmvc</artifactId>
      <version>5.2.9.RELEASE</version>
    </dependency>
    <!-- spring-jdbc -->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-jdbc</artifactId>
      <version>5.2.9.RELEASE</version>
    </dependency>
    <!-- spring-aspects -->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-aspects</artifactId>
      <version>5.2.9.RELEASE</version>
    </dependency>

    <!--Mybatis相关-->
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
    <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis</artifactId>
      <version>3.4.6</version>
    </dependency>
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
    <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis-spring</artifactId>
      <version>1.3.2</version>
    </dependency>
    <!-- https://mvnrepository.com/artifact/org.mybatis.generator/mybatis-generator-core -->
    <dependency>
      <groupId>org.mybatis.generator</groupId>
      <artifactId>mybatis-generator-core</artifactId>
      <version>1.3.7</version>
    </dependency>

    <!-- c3p0 -->
    <!-- https://mvnrepository.com/artifact/com.mchange/c3p0 -->
    <dependency>
      <groupId>com.mchange</groupId>
      <artifactId>c3p0</artifactId>
      <version>0.9.5.2</version>
    </dependency>
    <!-- mysql-connector -->
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>8.0.16</version>
    </dependency>

    <!-- Servlet -->
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>4.0.1</version>
      <scope>provided</scope>
    </dependency>
    <!-- https://mvnrepository.com/artifact/javax.servlet.jsp.jstl/jstl -->
    <dependency>
      <groupId>javax.servlet.jsp.jstl</groupId>
      <artifactId>jstl</artifactId>
      <version>1.2</version>
    </dependency>

  </dependencies>

  <build>
    <finalName>CRUDTest</finalName>
    <pluginManagement><!-- lock down plugins versions to avoid using Maven defaults (may be moved to parent pom) -->
      <plugins>
        <plugin>
          <artifactId>maven-clean-plugin</artifactId>
          <version>3.1.0</version>
        </plugin>
        <!-- see http://maven.apache.org/ref/current/maven-core/default-bindings.html#Plugin_bindings_for_war_packaging -->
        <plugin>
          <artifactId>maven-resources-plugin</artifactId>
          <version>3.0.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.8.0</version>
        </plugin>
        <plugin>
          <artifactId>maven-surefire-plugin</artifactId>
          <version>2.22.1</version>
        </plugin>
        <plugin>
          <artifactId>maven-war-plugin</artifactId>
          <version>3.2.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-install-plugin</artifactId>
          <version>2.5.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-deploy-plugin</artifactId>
          <version>2.8.2</version>
        </plugin>
      </plugins>
    </pluginManagement>
  </build>
</project>
```

## SSM整合xml文件

### spring文件beans.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop" xmlns:tx="http://www.springframework.org/schema/tx"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop https://www.springframework.org/schema/aop/spring-aop.xsd http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd">
    <context:component-scan base-package="com.zzf"/>

    <!--配置数据源-->
    <context:property-placeholder location="classpath:db.properties"/>
    <bean id="pooledDataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
        <property name="jdbcUrl" value="${jdbc.jdbcUrl}"></property>
        <property name="driverClass" value="${jdbc.driverClass}"></property>
        <property name="user" value="${jdbc.user}"></property>
        <property name="password" value="${jdbc.password}"></property>
        <property name="maxPoolSize" value="${jdbc.maxPoolSize}"></property>
        <property name="minPoolSize" value="${jdbc.minPoolSize}"></property>
        <property name="initialPoolSize" value="${jdbc.initialPoolSize}"></property>
    </bean>

    <!--Mybatis整合-->
    <!-- 配置MyBatis工厂 -->
    <bean id="sqlSessionFactory"
          class="org.mybatis.spring.SqlSessionFactoryBean">
        <!-- 注入数据源 -->
        <property name="dataSource" ref="pooledDataSource"></property>
        <!-- 指定核心配置文件的位置 -->
        <property name="configLocation"
                  value="classpath:mybatis-config.xml"></property>
        <property name="mapperLocations" value="classpath:mapper/*.xml"></property>
    </bean>

    <!-- 将Mapper接口加入IOC容器 -->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <property name="basePackage" value="com.zzf.ssm.dao"></property>
    </bean>

    <!--配置一个可以执行批量的sqlSession-->
    <bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
        <constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory"></constructor-arg>
        <constructor-arg name="executorType" value="BATCH"></constructor-arg>
    </bean>

    <!-- 事务管理器，依赖于数据源 -->
    <bean id="transactionManager"
          class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="pooledDataSource"></property>
    </bean>

    <aop:config>
        <!--切入点表达式-->
        <aop:pointcut id="txPoint" expression="execution(* com.zzf.ssm.service..*(..))"/>
        <!--配置事务强-->
        <aop:advisor advice-ref="txAdvice" pointcut-ref="txPoint"/>
    </aop:config>

    <!--配置事务增强，事物如何切入-->
    <tx:advice id="txAdvice" transaction-manager="transactionManager">
        <tx:attributes>
            <tx:method name="*"/>
            <tx:method name="get*" read-only="true"/>
        </tx:attributes>
    </tx:advice>
</beans>
```

### spring-mvc.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc https://www.springframework.org/schema/mvc/spring-mvc.xsd">
    <context:component-scan base-package="com.zzf">
        <!--只扫控制器-->
        <context:exclude-filter type="annotation" expression="com.zzf.ssm.controller"/>
    </context:component-scan>

   <!-- <bean class="org.springframework.web.multipart.commons.CommonsMultipartResolver" id="multipartResolver"/>-->

    <!--视图解析器-->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver"
          id="internalResourceViewResolver">
        <!--前缀-->
        <property name="prefix" value="/WEB-INF/views/"/>
        <!--后缀-->
        <property name="suffix" value=".jsp"/>
    </bean>
    <!--两个标准配置-->
    <!--将springmvc不能处理的交给tomcat-->
    <mvc:default-servlet-handler/>
    <!--处理高级功能，如JSR303校验-->
    <mvc:annotation-driven/>
</beans>
```

### Mybatis配置文件mybatis-config.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
   <settings>
      <setting name="logImpl" value="LOG4J"/>
   </settings>
   <typeAliases>
      <!-- 别名，配置扫描包形式，别名就是类首字母小写 -->
      <package name="com.zzf.ssm.pojo" />
   </typeAliases>
   <plugins>
      <plugin interceptor="com.github.pagehelper.PageInterceptor">
         <!--分页参数合理化-->
         <property name="reasonable" value="true"/>
      </plugin>
   </plugins>
</configuration>
```

## 构建数据库

```java
CREATE TABLE `mybatis`.`tbl_emp` (
  `emp_id` INT NOT NULL AUTO_INCREMENT,
  `emp_name` VARCHAR(255) NOT NULL,
  `gender` CHAR(1) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`emp_id`));

CREATE TABLE `mybatis`.`tbl_dept` (
  `dept_id` INT NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`dept_id`));

ALTER TABLE `mybatis`.`tbl_emp` 
ADD COLUMN `d_id` INT NULL AFTER `email`,
ADD INDEX `fk_emp_dept_idx` (`d_id` ASC) VISIBLE;

ALTER TABLE `mybatis`.`tbl_emp` 
ADD CONSTRAINT `fk_emp_dept`
  FOREIGN KEY (`d_id`)
  REFERENCES `mybatis`.`tbl_dept` (`dept_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
```

## 使用Mybatis逆向工程

mbg.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>

    <context id="DB2Tables" targetRuntime="MyBatis3">
        <commentGenerator>
            <property name="suppressAllComments" value="true"/>
        </commentGenerator>
        <jdbcConnection driverClass="com.mysql.cj.jdbc.Driver"
                        connectionURL="jdbc:mysql://localhost:3306/mybatis?serverTimezone=GMT%2b8&amp;useUnicode=true&amp;characterEncoding=UTF-8&amp;useSSL=false&amp;zeroDateTimeBehavior=CONVERT_TO_NULL&amp;allowPublicKeyRetrieval=true"
                        userId="root"
                        password="123456">
        </jdbcConnection>

        <javaTypeResolver >
            <property name="forceBigDecimals" value="false" />
        </javaTypeResolver>

        <javaModelGenerator targetPackage="com.zzf.ssm.pojo"
                            targetProject=".\src\main\java">
            <property name="enableSubPackages" value="true" />
            <property name="trimStrings" value="true" />
        </javaModelGenerator>

        <sqlMapGenerator targetPackage="mapper"
                         targetProject=".\src\main\resources">
            <property name="enableSubPackages" value="true" />
        </sqlMapGenerator>

        <javaClientGenerator type="XMLMAPPER"
                             targetPackage="com.zzf.ssm.dao"
                             targetProject=".\src\main\java">
            <property name="enableSubPackages" value="true" />
        </javaClientGenerator>

        <!--指定每个表的生成策略-->
        <table tableName="tbl_emp" domainObjectName="Employee"></table>
        <table tableName="tbl_dept" domainObjectName="Department"></table>
    </context>
</generatorConfiguration>
```

```
package com.zzf.ssm.utils;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/*
 *
 *@author:zzf
 *@time:2021-01-19
 *
 */
public class Generator {
    public void generate() throws Exception {
        List<String> warnings = new ArrayList<>();
        boolean overwrite = true;
        File configFile = new File("mbg.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }

    public static void main(String[] args) {
        try{
            Generator generator=new Generator();
            generator.generate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```



### 写一个测试类插入一些数据

```
package com.zzf.ssm.test;

/*
 *
 *@author:zzf
 *@time:2021-01-16
 *
 */

import com.zzf.ssm.dao.DepartmentMapper;
import com.zzf.ssm.dao.EmployeeMapper;
import com.zzf.ssm.pojo.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:beans.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
        //插入部门
        /*departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));*/

        //批量插入
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",8));
        }
        System.out.println("批量插入完成");
    }
}
```

## 构建前端

### index.jsp

```
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:forward page="/WEB-INF/views/list.jsp"></jsp:forward>
```

list.jsp

具体见源码



## 实现的功能

分页查询

添加

删除（单个和批量）

编辑

其中添加和编辑加入了（JSR303后端校验和jquey前端校验）

## 效果展示

### 分页查询

![image-20210119163254672](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119163254672.png)

### 单个删除

![image-20210119164547371](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119164547371.png)

![image-20210119164607545](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119164607545.png)

![image-20210119164621321](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119164621321.png)

### 批量删除

![image-20210119164649973](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119164649973.png)

### 添加

![image-20210119164719489](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119164719489.png)

### 校验

![image-20210119164810304](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119164810304.png)

![image-20210119164838250](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119164838250.png)

### 编辑

![image-20210119164907043](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119164907043.png)

![image-20210119165009510](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119165009510.png)

![image-20210119165026846](C:\Users\招志锋\AppData\Roaming\Typora\typora-user-images\image-20210119165026846.png)