package com.careconnect.config;


import com.careconnect.service.ParameterStoreService;
import com.zaxxer.hikari.HikariDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.bind.Bindable;
import org.springframework.boot.context.properties.bind.Binder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.ConfigurableEnvironment;

import javax.sql.DataSource;

@Configuration
public class DatabaseConfig {

    @Value("${careconnect.db.url}")
    private String jdbcUrl;

    @Value("${careconnect.db.username}")
    private String userParameter;

    @Value("${careconnect.db.password}")
    private String passwordParameter;

    private final ParameterStoreService parameterService;

    @Autowired(required = false)
    public DatabaseConfig(ParameterStoreService parameterService) {
        this.parameterService = parameterService;
    }

    /**
     * Will get the sensitive value/properties for database connection from SSM Parameter Store
     *
     * @return DataSourceProperties
     */
    @Bean
    @DependsOn("ssmClient")
    @Primary
    public DataSourceProperties dataSourceProperties() {

        DataSourceProperties properties = new DataSourceProperties();
        if(jdbcUrl.isEmpty()) {
            String url = parameterService.getSecureParameter(jdbcUrl);
            properties.setUrl(url);
        }
        else {
            properties.setUrl(jdbcUrl);
        }
        if(userParameter.isEmpty()) {
            String username = parameterService.getSecureParameter(userParameter);
            properties.setUsername(username);
        }
        else {
            properties.setUsername(userParameter);
        }
        if(passwordParameter.isEmpty()) {
            String password = parameterService.getSecureParameter(passwordParameter);
            properties.setPassword(password);
        }
        else {
            properties.setPassword(passwordParameter);
        }
        return properties;
    }

    @Bean
    @Primary
    @DependsOn("dataSourceProperties")
    public DataSource dataSource(DataSourceProperties dataSourceProperties, ConfigurableEnvironment env) {
        HikariDataSource dataSource = dataSourceProperties.initializeDataSourceBuilder()
                .type(HikariDataSource.class)
                .build();

        Binder.get(env).bind("spring.datasource.hikari", Bindable.ofInstance(dataSource));

        return dataSource;
    }

}
