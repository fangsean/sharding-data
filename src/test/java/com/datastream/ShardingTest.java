package com.datastream;

import com.datastream.entity.SourceData;
import com.datastream.mapper.SourceDataMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * ShardingSphere 分片功能测试
 */
@SpringBootTest
@Slf4j
public class ShardingTest {

    @Autowired
    private SourceDataMapper sourceDataMapper;

    /**
     * 测试插入数据（自动路由到对应日表）
     */
    @Test
    public void testInsert() {
        log.info("========== 测试插入数据 ==========");
        
        SourceData data = new SourceData();
        data.setUserCode("USER001");
        data.setUserName("张三");
        data.setBusinessTime(LocalDateTime.of(2024, 1, 2, 10, 30, 0));
        data.setAmount(new BigDecimal("100.50"));
        data.setStatus(1);
        data.setRemark("测试分片插入");
        
        int result = sourceDataMapper.insert(data);
        log.info("插入结果：{}, id: {}", result, data.getId());
    }

    /**
     * 测试精确查询（查询特定日期的表）
     */
    @Test
    public void testPreciseQuery() {
        log.info("========== 测试精确查询 ==========");
        
        LocalDateTime businessTime = LocalDateTime.of(2024, 1, 2, 0, 0, 0);
        List<SourceData> list = sourceDataMapper.selectByTimeRange(businessTime, businessTime.plusDays(1));
        
        log.info("查询结果数量：{}", list.size());
        list.forEach(data -> log.info("数据：id={}, userCode={}, businessTime={}", 
            data.getId(), data.getUserCode(), data.getBusinessTime()));
    }

    /**
     * 测试范围查询（查询多个日期的表）
     */
    @Test
    public void testRangeQuery() {
        log.info("========== 测试范围查询 ==========");
        
        LocalDateTime startTime = LocalDateTime.of(2024, 1, 1, 0, 0, 0);
        LocalDateTime endTime = LocalDateTime.of(2024, 1, 5, 23, 59, 59);
        
        List<SourceData> list = sourceDataMapper.selectByTimeRange(startTime, endTime);
        
        log.info("查询结果数量：{}", list.size());
        list.forEach(data -> log.info("数据：id={}, userCode={}, businessTime={}", 
            data.getId(), data.getUserCode(), data.getBusinessTime()));
    }

    /**
     * 测试批量插入（跨多个日表）
     */
    @Test
    public void testBatchInsert() {
        log.info("========== 测试批量插入 ==========");
        
        for (int i = 0; i < 10; i++) {
            SourceData data = new SourceData();
            data.setUserCode("USER" + String.format("%03d", i));
            data.setUserName("用户" + i);
            data.setBusinessTime(LocalDateTime.of(2024, 1, (i % 5) + 1, 10, 0, 0));
            data.setAmount(new BigDecimal("100.00").multiply(new BigDecimal(i + 1)));
            data.setStatus(i % 3);
            data.setRemark("批量测试数据-" + i);
            
            sourceDataMapper.insert(data);
            log.info("插入数据：id={}, userCode={}, businessTime={}", 
                data.getId(), data.getUserCode(), data.getBusinessTime());
        }
    }
}
