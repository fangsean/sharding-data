package com.datastream;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * 基于 Spring Cloud Alibaba 的微服务启动类
 */
@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
@MapperScan("com.datastream.mapper")
@EnableTransactionManagement
public class ShardingDataApplication {

    public static void main(String[] args) {
        SpringApplication.run(ShardingDataApplication.class, args);
    }
}
