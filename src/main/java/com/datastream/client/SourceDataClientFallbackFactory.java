package com.datastream.client;

import com.datastream.entity.SourceData;
import feign.FeignException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Feign 降级工厂类
 */
@Component
@Slf4j
public class SourceDataClientFallbackFactory implements FallbackFactory<SourceDataClient> {

    @Override
    public SourceDataClient create(Throwable cause) {
        // 记录异常信息
        String errorMsg = cause instanceof FeignException 
            ? "Feign 调用失败：" + cause.getMessage()
            : "服务调用降级，原因：" + cause.getMessage();
        log.error(errorMsg, cause);
        
        return new SourceDataClient() {
            @Override
            public Map<String, Object> getById(Long id) {
                return buildFallbackResponse("查询失败，服务暂时不可用");
            }

            @Override
            public Map<String, Object> save(SourceData data) {
                return buildFallbackResponse("保存失败，服务暂时不可用");
            }

            @Override
            public Map<String, Object> listByTimeRange(LocalDateTime startTime, LocalDateTime endTime) {
                Map<String, Object> response = buildFallbackResponse("查询失败，服务暂时不可用");
                response.put("data", new ArrayList<>());
                response.put("size", 0);
                return response;
            }

            @Override
            public Map<String, Object> listByUserCode(String userCode, LocalDateTime startTime, LocalDateTime endTime) {
                Map<String, Object> response = buildFallbackResponse("查询失败，服务暂时不可用");
                response.put("data", new ArrayList<>());
                response.put("size", 0);
                return response;
            }
        };
    }

    private Map<String, Object> buildFallbackResponse(String message) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("message", message);
        return response;
    }
}
