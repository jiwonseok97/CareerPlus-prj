package com.wa.erp.config.datasource;

import com.zaxxer.hikari.HikariDataSource;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.datasource.LazyConnectionDataSourceProxy;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

@Configuration
public class DatabaseReplicationConfig {

    @Value("${app.datasource.master.driver-class-name:${spring.datasource.driver-class-name}}")
    private String masterDriverClassName;

    @Value("${app.datasource.master.url:${spring.datasource.url}}")
    private String masterUrl;

    @Value("${app.datasource.master.username:${spring.datasource.username}}")
    private String masterUsername;

    @Value("${app.datasource.master.password:${spring.datasource.password}}")
    private String masterPassword;

    @Value("${app.datasource.slave.driver-class-name:${spring.datasource.driver-class-name}}")
    private String slaveDriverClassName;

    @Value("${app.datasource.slave.url:${spring.datasource.url}}")
    private String slaveUrl;

    @Value("${app.datasource.slave.username:${spring.datasource.username}}")
    private String slaveUsername;

    @Value("${app.datasource.slave.password:${spring.datasource.password}}")
    private String slavePassword;

    @Value("${app.datasource.route-non-transactional-to-slave:true}")
    private boolean routeNonTransactionalToSlave;

    @Bean(name = "masterDataSource")
    public DataSource masterDataSource() {
        return createDataSource(masterDriverClassName, masterUrl, masterUsername, masterPassword, "careerplus-master");
    }

    @Bean(name = "slaveDataSource")
    public DataSource slaveDataSource() {
        return createDataSource(slaveDriverClassName, slaveUrl, slaveUsername, slavePassword, "careerplus-slave");
    }

    @Bean(name = "routingDataSource")
    public DataSource routingDataSource(
            @Qualifier("masterDataSource") DataSource masterDataSource,
            @Qualifier("slaveDataSource") DataSource slaveDataSource
    ) {
        ReplicationRoutingDataSource routingDataSource = new ReplicationRoutingDataSource();
        routingDataSource.setRouteNonTransactionalToSlave(routeNonTransactionalToSlave);

        Map<Object, Object> targetDataSources = new HashMap<>();
        targetDataSources.put(DatabaseType.MASTER, masterDataSource);
        targetDataSources.put(DatabaseType.SLAVE, slaveDataSource);

        routingDataSource.setDefaultTargetDataSource(masterDataSource);
        routingDataSource.setTargetDataSources(targetDataSources);
        routingDataSource.afterPropertiesSet();
        return routingDataSource;
    }

    @Primary
    @Bean
    public DataSource dataSource(@Qualifier("routingDataSource") DataSource routingDataSource) {
        LazyConnectionDataSourceProxy proxy = new LazyConnectionDataSourceProxy(routingDataSource);
        proxy.setDefaultAutoCommit(false);
        return proxy;
    }

    private DataSource createDataSource(String driverClassName, String url, String username, String password, String poolName) {
        HikariDataSource dataSource = new HikariDataSource();
        dataSource.setDriverClassName(driverClassName);
        dataSource.setJdbcUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        dataSource.setPoolName(poolName);
        dataSource.setMaximumPoolSize(20);
        dataSource.setMinimumIdle(5);
        dataSource.setConnectionTimeout(3000);
        dataSource.setIdleTimeout(600000);
        dataSource.setMaxLifetime(1800000);
        // Do not fail application startup when DB is temporarily unavailable.
        dataSource.setInitializationFailTimeout(-1);
        return dataSource;
    }
}
