package com.ezen.spring.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@EnableTransactionManagement
@MapperScan(basePackages = {"com.ezen.spring.dao"})
@Configurable
public class RootConfig {
	
	// @Autowired : 해당 객체를 스프링 객체로 생성
	@Autowired
	ApplicationContext applicationContext;
	
	
	// DB에 관련된 설정 : 사용자가 만든 객체를 스프링이 인지하도록 설정 @Bean
	@Bean
	public DataSource dataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		// com.mysql.cj.jdbc.Driver 대신 log4jdbc 드라이버 사용
		// log4jdbc 드라이버 => DB의 흐름으로 로그로 찍어주는 드라이버.
		// springdb / springUser / mysql
		hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		hikariConfig.setJdbcUrl("jdbc:log4jdbc:mysql://localhost:3306/springdb2");
		hikariConfig.setUsername("springUser");
		hikariConfig.setPassword("mysql");
		
		// -- 여기서부터 hikari 추가 설정
		hikariConfig.setMaximumPoolSize(5);  //한번에 설정할 최대 커넥션 개수
		hikariConfig.setMinimumIdle(5);  //최소 유효 커넥션 수(mac와 같은 개수로 설정)
		
		hikariConfig.setConnectionTestQuery("SELECT now()");  //첫 연결시 test sql
		hikariConfig.setPoolName("springHikariCP");
		
		// -- 여기서부터 추가설정
		// cachePrepStmts : cache 사용 여부 설정
		hikariConfig.addDataSourceProperty("dataSource.cachePrepStmts", "true");
		// mysql 드라이버가 연결당 cache 사이즈 설정 : 250 ~ 500사이 권장
		hikariConfig.addDataSourceProperty("dataSource.prepStmtsCacheSize", "250");
		// connection당 캐싱할 prearedStatement 개수 지정 옵션 : default 250
		hikariConfig.addDataSourceProperty("dataSource.prepStmtsCacheSqlLimit", "true");  //true는 기본값 설정
		// mysql 서버에서 최신 이슈가 있으 경우 지원을 받을 것인지 설정
		hikariConfig.addDataSourceProperty("dataSource.useServerPrepStmts", "true");
		
		HikariDataSource hikariDataSource = new HikariDataSource(hikariConfig);
		return hikariDataSource;
		
	}
	
	 @Bean
	  public SqlSessionFactory sqlSessionFactory() throws Exception {
	    SqlSessionFactoryBean sqlFactoryBean = new SqlSessionFactoryBean();
	    sqlFactoryBean.setDataSource(dataSource());
	    // 내부 src/main/resources의 위치값이 필요
	    sqlFactoryBean.setMapperLocations(
	    		applicationContext.getResources("classpath:/mappers/*.xml"));  //파일단위
	    
	    // DB : _ (스네이크 표기법) / jave : 카멜표기법  reg_date(스네이크 표기) = regDate(카멜키에스)
	    sqlFactoryBean.setConfigLocation(
	    		applicationContext.getResource("classpath:/mybatisConfig.xml"));  //폴더단위
	    
	    return sqlFactoryBean.getObject();
	    
	  }
	 
	 // 트랜젝션 메니저 설정
	 @Bean
	 public DataSourceTransactionManager transactionManager() {
		 return new DataSourceTransactionManager(dataSource());                                                                                                        
	 }
	
	

}
