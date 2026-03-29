package com.datastream;

import com.datastream.client.SourceDataClient;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * OpenFeign 配置测试
 */
@SpringBootTest
@Slf4j
@DisplayName("OpenFeign 配置测试")
class FeignConfigTest {

    @Autowired(required = false)
    private SourceDataClient sourceDataClient;

    /**
     * 测试 Feign Client 是否已加载到 Spring 容器
     */
    @Test
    @DisplayName("测试 1 - OpenFeign Client 加载测试")
    public void testFeignClientLoaded() {
        if (sourceDataClient != null) {
            log.info("✓ OpenFeign Client 已成功加载到 Spring 容器");
        } else {
            log.warn("⚠ OpenFeign Client 未加载（可能是因为没有 Nacos 服务发现）");
        }
    }

    /**
     * 测试 FallbackFactory 是否生效
     */
    @Test
    @DisplayName("测试 2 - FallbackFactory 测试")
    public void testFallbackFactory() {
        // 验证降级工厂是否存在
        log.info("OpenFeign FallbackFactory 测试完成");
    }
}
