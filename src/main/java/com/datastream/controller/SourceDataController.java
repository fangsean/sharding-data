package com.datastream.controller;

import com.alibaba.csp.sentinel.annotation.SentinelResource;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.mapper.Mapper;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.datastream.entity.SourceData;
import com.datastream.service.SourceDataService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * 源数据控制器
 */
@RestController
@RequestMapping("/sourceData")
@Slf4j
@RequiredArgsConstructor
public class SourceDataController {

    private final SourceDataService sourceDataService;

    /**
     * 根据 ID 查询
     */
    @GetMapping("/{id}")
    @SentinelResource(value = "getSourceDataById", blockHandler = "handleBlock")
    public Map<String, Object> getById(@PathVariable Long id) {
        log.info("查询源数据，id: {}", id);
        SourceData data = sourceDataService.getById(id);
        return buildResponse(data);
    }

    /**
     * 根据 ID 查询
     */
    @GetMapping("/{day}/{id}")
    @SentinelResource(value = "getSourceDataByDayId", blockHandler = "handleBlock")
    public List<SourceData> getById(@PathVariable String day, @PathVariable Long id) {
        log.info("查询源数据，day: {}, id: {}", day, id);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        LocalDate date = LocalDate.parse(day, formatter);
        LocalDateTime dateTime = date.atStartOfDay(); // 2024-01-01 00:00:00
        LambdaQueryWrapper<SourceData> sourceDataWrapper = new LambdaQueryWrapper<>(SourceData.class);
        sourceDataWrapper
                .between(SourceData::getBusinessTime, dateTime, date.atTime(LocalTime.MAX)) // 2024-01-01 12:00:00
                .eq(SourceData::getId, id);
        return sourceDataService.list(sourceDataWrapper);
    }

    /**
     * 保存数据（自动路由到对应分表）
     */
    @PostMapping
    @SentinelResource(value = "saveSourceData", blockHandler = "handleBlock")
    public Map<String, Object> save(@RequestBody SourceData data) {
        log.info("保存源数据：{}", data);
        
        // 设置默认值
        if (data.getBusinessTime() == null) {
            data.setBusinessTime(LocalDateTime.now());
        }
        
        boolean result = sourceDataService.save(data);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result);
        response.put("id", data.getId());
        return response;
    }

    /**
     * 批量插入测试数据
     */
    @PostMapping("/batch")
    public Map<String, Object> batchInsert(@RequestParam int count) {
        log.info("批量插入测试数据，count: {}", count);
        
        String[] userCodes = {"USER_0001", "USER_0002", "USER_0003", "USER_0004", "USER_0005"};
        String[] number = {"0","1", "2", "3", "4", "5", "6", "7", "8", "9"};
        Random random = new Random();
        for (int i = 0; i < count; i++) {
            SourceData data = new SourceData();
            // USER_00013546 random
            data.setUserCode(userCodes[i % userCodes.length] + number[random.nextInt(10)]+number[random.nextInt(10)]+number[random.nextInt(10)]+number[random.nextInt(10)]);
            data.setUserName("用户" + (i + 1));
            data.setBusinessTime(LocalDateTime.now().minusYears(2).minusMonths(3).minusDays(i%29));
            data.setAmount(new BigDecimal("100.00").multiply(new BigDecimal(i + 1)));
            data.setStatus(i % 3);
            data.setRemark("测试数据 - " + (i + 1));
            
            sourceDataService.save(data);
        }
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("inserted", count);
        return response;
    }

    /**
     * 根据时间范围查询
     */
    @GetMapping("/range")
    @SentinelResource(value = "listByTimeRange", blockHandler = "handleBlock")
    public Map<String, Object> listByTimeRange(
            @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")@RequestParam LocalDateTime startTime,
            @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")@RequestParam LocalDateTime endTime) {
        log.info("根据时间范围查询：startTime={}, endTime={}", startTime, endTime);
        List<SourceData> list = sourceDataService.listByTimeRange(startTime, endTime);
        return buildListResponse(list);
    }

    /**
     * 根据用户编码和时间范围查询
     */
    @GetMapping("/user/{userCode}")
    @SentinelResource(value = "listByUserCode", blockHandler = "handleBlock")
    public Map<String, Object> listByUserCode(
            @PathVariable String userCode,
            @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")@RequestParam LocalDateTime startTime,
            @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")@RequestParam LocalDateTime endTime) {
        log.info("根据用户编码和时间范围查询：userCode={}, startTime={}, endTime={}", userCode, startTime, endTime);
        List<SourceData> list = sourceDataService.listByUserCodeAndTimeRange(userCode, startTime, endTime);
        return buildListResponse(list);
    }

    /**
     * 健康检查
     */
    @GetMapping("/health")
    public String health() {
        return "OK";
    }

    /**
     * Sentinel 限流处理方法
     */
    public Map<String, Object> handleBlock(Exception ex) {
        log.warn("请求被限流", ex);
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("message", "请求过于频繁，请稍后再试");
        return response;
    }

    private Map<String, Object> buildResponse(SourceData data) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", data != null);
        response.put("data", data);
        return response;
    }

    private Map<String, Object> buildListResponse(List<SourceData> list) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", list);
        response.put("size", list != null ? list.size() : 0);
        return response;
    }
}
