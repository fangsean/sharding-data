package com.datastream.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationEnvironmentPreparedEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.stereotype.Component;

/**
 * 调试配置加载
 */
@Component
@Slf4j
public class ConfigDebugListener implements ApplicationListener<ApplicationEnvironmentPreparedEvent> {
    
    @Override
    public void onApplicationEvent(ApplicationEnvironmentPreparedEvent event) {
        ConfigurableEnvironment environment = event.getEnvironment();
        
        // 打印激活的 profile
        log.info("Active profiles: {}", environment.getActiveProfiles());
        log.info("Default profile: {}", environment.getDefaultProfiles());
        
        // 检查 ShardingSphere 配置
        String datasourceNames = environment.getProperty("spring.shardingsphere.datasource.names");
        log.info("ShardingSphere datasource.names: {}", datasourceNames);
        
        String ds0Url = environment.getProperty("spring.shardingsphere.datasource.ds0.jdbc-url");
        log.info("ShardingSphere ds0 jdbc-url: {}", ds0Url);
        
        String shardingEnabled = environment.getProperty("spring.shardingsphere.enabled");
        log.info("ShardingSphere enabled: {}", shardingEnabled);
    }
}
