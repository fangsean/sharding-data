package com.datastream.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;

/**
 * Druid 连接池配置类
 * 配合 ShardingSphere 使用，Druid 的监控和统计功能通过配置文件启用
 * 
 * 注意：ShardingSphere 5.x 会自动读取 application-sharding.yml 中的配置
 * 并创建对应的数据源，因此不需要手动创建 DataSource Bean
 */
@Configuration
@Slf4j
public class DruidConfig {

    /**
     * 此配置类保留用于未来扩展
     * ShardingSphere 5.x 会根据 application-sharding.yml 中的配置自动创建数据源
     * 并在底层集成 Druid 的监控和统计功能
     * 
     * 如果需要自定义 Druid 的高级特性，可以在这里手动创建 DataSource Bean
     */
}
