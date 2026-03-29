package com.datastream.config;

import feign.Logger;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Feign 配置类
 */
@Configuration
public class FeignConfig {

    /**
     * 配置 Feign 日志级别
     * NONE - 不记录任何日志（默认）
     * BASIC - 仅记录请求方法、URL、响应状态码和执行时间
     * HEADERS - 记录基本信息和请求/响应头
     * FULL - 记录完整的请求和响应信息
     */
    @Bean
    public Logger.Level feignLoggerLevel() {
        return Logger.Level.FULL;
    }
}
