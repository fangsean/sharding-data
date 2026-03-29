package com.datastream.config;

import com.alibaba.csp.sentinel.annotation.aspectj.SentinelResourceAspect;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;

/**
 * Sentinel 配置类
 * 注意：SentinelResourceAspect 已通过 spring-cloud-starter-alibaba-sentinel 自动配置
 * 如需自定义配置，可在此添加 Bean
 */
@Configuration
@Slf4j
public class SentinelConfig {

    // Sentinel 已自动配置，无需手动创建 SentinelResourceAspect Bean
    // 如果需要自定义限流处理逻辑，可以在 Controller 中使用 @SentinelResource 注解

}
