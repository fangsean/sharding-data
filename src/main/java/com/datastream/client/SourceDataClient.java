package com.datastream.client;

import com.datastream.entity.SourceData;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 源数据服务 Feign 客户端（用于微服务间调用）
 * 注意：这是一个示例，实际使用时需要替换为真实的服务名
 */
@FeignClient(
    name = "source-data-service",  // 待确认：实际服务名称
    fallbackFactory = SourceDataClientFallbackFactory.class,
    configuration = {}  // 可自定义配置
)
public interface SourceDataClient {

    /**
     * 根据 ID 查询源数据
     */
    @GetMapping("/sourceData/{id}")
    Map<String, Object> getById(@PathVariable("id") Long id);

    /**
     * 保存源数据
     */
    @PostMapping("/sourceData")
    Map<String, Object> save(@RequestBody SourceData data);

    /**
     * 根据时间范围查询
     */
    @GetMapping("/sourceData/range")
    Map<String, Object> listByTimeRange(
        @RequestParam("startTime") LocalDateTime startTime,
        @RequestParam("endTime") LocalDateTime endTime
    );

    /**
     * 根据用户编码和时间范围查询
     */
    @GetMapping("/sourceData/user/{userCode}")
    Map<String, Object> listByUserCode(
        @PathVariable("userCode") String userCode,
        @RequestParam("startTime") LocalDateTime startTime,
        @RequestParam("endTime") LocalDateTime endTime
    );
}
