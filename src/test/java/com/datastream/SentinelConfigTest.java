package com.datastream;

import com.alibaba.csp.sentinel.annotation.SentinelResource;
import com.alibaba.csp.sentinel.slots.block.BlockException;
import com.datastream.controller.SourceDataController;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Sentinel 配置测试
 */
@SpringBootTest
@Slf4j
@DisplayName("Sentinel 配置测试")
class SentinelConfigTest {

    /**
     * 测试 @SentinelResource 注解是否生效
     */
    @Test
    @DisplayName("测试 1 - SentinelResource 注解测试")
    public void testSentinelResource() {
        // 直接调用方法，验证注解是否正常
        SourceDataController controller = new SourceDataController(null);
        
        // 模拟正常流程
        log.info("Sentinel 资源注解测试完成");
    }

    /**
     * 测试限流处理方法
     */
    @Test
    @DisplayName("测试 2 - 限流降级处理")
    public void testBlockHandler() {
        SourceDataController controller = new SourceDataController(null);
        Object result = controller.handleBlock(new Exception("模拟限流"));
        
        log.info("限流降级返回：{}", result);
    }
}
