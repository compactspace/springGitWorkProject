package com.spring.finall.config;

import java.util.List;

import org.apache.commons.chain.web.WebContext;
import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.QueueBuilder;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitAdmin;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.transaction.ChainedTransactionManager;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.security.web.method.annotation.AuthenticationPrincipalArgumentResolver;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//@Configuration
//→ 해당 클래스가 스프링 설정 클래스임을 나타냄.
// 내부에 @Bean 메서드 등을 정의해, 애플리케이션 컨텍스트에 수동으로 Bean을 등록할 수 있음.
@Configuration

//@EnableWebMvc
//→ XML의 <mvc:annotation-driven /> 과 동일한 역할.
// 즉, @Controller, @RequestMapping 등의 애노테이션 기반 MVC 기능을 활성화.
// 또한 RequestMappingHandlerMapping, RequestMappingHandlerAdapter 등 여러 필수 Bean을 자동 등록함.
//⚠️ 단, WebMvcConfigurer 구현 클래스에서 직접 설정(예: addArgumentResolvers)을 할 때 필요.
@EnableWebMvc

//@EnableTransactionManagement
//→ @Transactional 애노테이션을 인식하여 트랜잭션 기능을 활성화함.
// JPA, JDBC, MyBatis 등 다양한 트랜잭션 매니저를 자동 연동할 수 있음.
@EnableTransactionManagement

//@ComponentScan(basePackageClasses = WebContext.class)
//→ WebContext 클래스가 위치한 패키지를 기준으로 하위 패키지까지 스캔함.
// @Component, @Controller, @Service, @Repository 등 컴포넌트 스캔 대상 어노테이션이 붙은 클래스를 Bean으로 등록함.
//⚠️ 주의: basePackageClasses는 클래스의 "패키지 위치"를 기준으로 스캔 범위를 결정함.
@ComponentScan(basePackageClasses = WebContext.class)
//아래 어노 테이션이 없다면?? 컨트롤러에서 @Autowired가 안먹힘 펙트 체크함
//JpaReposotyiry  bean생성에도 영향 주니.. 경로 조심..
//@EnableJpaRepositories("com.spring.finall")
public class AdminConfig implements WebMvcConfigurer {

    // aws 로 연결 할거면 jdbc:mysql://13.209.16.121:3306/octfair2?allowMultiQueries=true
    // 아이디는 root 비번은 hwangkh704!

   

    @Bean
    public BasicDataSource dataSource() {
        BasicDataSource datasource = new BasicDataSource();
        datasource.setDriverClassName("org.mariadb.jdbc.Driver");
        // 홈서버 키면 
//        datasource.setUrl("jdbc:mariadb://localhost:4400/finall"); 
//        datasource.setUsername("root");
//        datasource.setPassword("5susdbwj!");
        // 홈서버가 꺼져있으면 우선 로컬로 datasource.setUrl("jdbc:mariadb://localhost:3306/finall");        
//        datasource.setUsername("root");
//        datasource.setPassword("1111");
        
        datasource.setUrl("jdbc:mariadb://localhost:3306/finall");
        datasource.setUsername("root");
        datasource.setPassword("1111");

        // ★ 핵심 설정
        datasource.setInitialSize(5);   // 최초 생성 커넥션 수
        datasource.setMaxTotal(20);     // 최대 커넥션 수 (핵심)
        datasource.setMaxIdle(10);      // 유휴 커넥션 최대
        datasource.setMinIdle(5);       // 유휴 커넥션 최소

        return datasource;
    }

    // jpa 설정
    // META-INF에서 만들었던 persistence.xml 을 가지고 메니져를 만든다.
    /*
     * @Bean public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
     * LocalContainerEntityManagerFactoryBean entityManagerFactory = new
     * LocalContainerEntityManagerFactoryBean();
     * entityManagerFactory.setDataSource(dataSource());
     * entityManagerFactory.setPersistenceUnitName("jpa-maria"); // persistence.xml의
     * 설정 정의된 이름 entityManagerFactory.setJpaVendorAdapter(new
     * HibernateJpaVendorAdapter());
     * 
     * return entityManagerFactory; }
     */

    // transactional 설정
    // 만들어진 메니져에게 트랜잭션을 세팅해준다는 정도로 이해
    @Bean
    public PlatformTransactionManager transactionManager() throws Exception {
        // 단 주의 하자. 지금 presentation.xml 에서 사용하고 있는 트랜잭션 메니져랑 동일해서 충돌이 있을 수도 있다.
        // mariadb transactional
        DataSourceTransactionManager dataSourceTransactionManager = new DataSourceTransactionManager();
        dataSourceTransactionManager.setDataSource(dataSource());

        // JPA transactional
//        JpaTransactionManager jpaTransactionManager = new JpaTransactionManager();
//        jpaTransactionManager.setEntityManagerFactory(entityManagerFactory().getObject());

        // Chained transaction manager (MyBatis X JPA)
        /*
         * ChainedTransactionManager transactionManager = new
         * ChainedTransactionManager(jpaTransactionManager,
         * dataSourceTransactionManager);
         */

        ChainedTransactionManager transactionManager = new ChainedTransactionManager(dataSourceTransactionManager);
        return transactionManager;
    }

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
        resolvers.add(new AuthenticationPrincipalArgumentResolver());
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // /images/** 요청을 C:/upload/product/ 경로와 매핑
        registry.addResourceHandler("/images/**").addResourceLocations("file:///C:/upload/product/")
                .setCachePeriod(3600); // 캐시 설정 (선택)
    }

    // RabbitMQ 관련 설정
    public static final String RESERVE_QUEUE = "reserveQueue";
    public static final String RESERVE_FAILURE_QUEUE = "reserveQueue.DLQ";
    public static final String EXCHANGE = "reserveExchange";

    // ConnectionFactory 정의
    @Bean
    public CachingConnectionFactory connectionFactory() {
        CachingConnectionFactory connectionFactory = new CachingConnectionFactory("localhost");
        connectionFactory.setUsername("guest");
        connectionFactory.setPassword("guest");
        return connectionFactory;
    }

    // RabbitTemplate 정의
    @Bean
    public RabbitTemplate rabbitTemplate() {
        return new RabbitTemplate(connectionFactory());
    }

    // RabbitAdmin 정의 (큐/익스체인지 생성용)
    @Bean
    public RabbitAdmin rabbitAdmin() {
        return new RabbitAdmin(connectionFactory());
    }

    // 실제 큐
    @Bean
    public Queue reserveQueue() {
        return QueueBuilder.durable(RESERVE_QUEUE).build();
    }

    // 실패 큐 (수동 DLQ)
    @Bean
    public Queue reserveFailureQueue() {
        return QueueBuilder.durable(RESERVE_FAILURE_QUEUE).build();
    }

    // Exchange (Direct)
    @Bean
    public DirectExchange exchange() {
        return new DirectExchange(EXCHANGE);
    }

    // 메인 큐 바인딩
    @Bean
    public Binding reserveQueueBinding() {
        return BindingBuilder.bind(reserveQueue())
                .to(exchange())
                .with(RESERVE_QUEUE);
    }

    // 실패 큐 바인딩 (Direct Exchange 사용)
    @Bean
    public Binding reserveFailureQueueBinding() {
        return BindingBuilder.bind(reserveFailureQueue())
                .to(exchange())
                .with(RESERVE_FAILURE_QUEUE);
    }

}
