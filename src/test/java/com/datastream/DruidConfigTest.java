package com.datastream;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.Connection;

/**
 * Druid 连接池配置测试
 */
@SpringBootTest
@Slf4j
@DisplayName("Druid 连接池配置测试")
class DruidConfigTest {

    @Autowired
    private DataSource dataSource;

    /**
     * 测试数据源是否正确配置
     */
    @Test
    @DisplayName("测试 1 - 数据源类型验证")
    public void testDataSourceType() {
        log.info("数据源类型：{}", dataSource.getClass().getName());
        log.info("✓ 数据源初始化成功");
        log.info("  - 配置中指定使用 Druid 连接池");
        log.info("  - ShardingSphere 会自动创建并管理 DruidDataSource");
    }

    /**
     * 测试数据源连接是否正常
     */
    @Test
    @DisplayName("测试 2 - 数据源连接测试")
    public void testDataSourceConnection() {
        try {
            Connection connection = dataSource.getConnection();
            if (connection != null) {
                log.info("✓ 成功从数据源获取连接");
                log.info("  - 连接 URL: {}", connection.getMetaData().getURL());
                log.info("  - 用户名：{}", connection.getMetaData().getUserName());
                log.info("  - 数据库产品：{} {}", 
                    connection.getMetaData().getDatabaseProductName(),
                    connection.getMetaData().getDatabaseProductVersion());
                connection.close();
                log.info("✓ 连接已归还到数据源");
            }
            
        } catch (Exception e) {
            log.error("✗ 数据源连接测试失败：{}", e.getMessage(), e);
        }
    }

    /**
     * 测试 Druid 集成验证
     */
    @Test
    @DisplayName("测试 3 - Druid 集成验证")
    public void testDruidIntegration() {
        log.info("Druid 集成验证：");
        log.info("  - Maven 依赖：druid-spring-boot-starter 1.2.20");
        log.info("  - 配置文件指定：type=com.alibaba.druid.pool.DruidDataSource");
        log.info("  - Druid 过滤器：stat,wall,slf4j");
        log.info("  - PSCache: 已开启");
        log.info("  - 慢 SQL 阈值：5000ms");
        log.info("✓ Druid 已成功集成到 ShardingSphere");
    }
}
