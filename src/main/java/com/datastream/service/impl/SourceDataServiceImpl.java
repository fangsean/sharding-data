package com.datastream.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.datastream.entity.SourceData;
import com.datastream.mapper.SourceDataMapper;
import com.datastream.service.SourceDataService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 源数据服务实现类
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class SourceDataServiceImpl extends ServiceImpl<SourceDataMapper, SourceData> implements SourceDataService {

    private final SourceDataMapper sourceDataMapper;

    @Override
    public SourceData getById(Long id) {
        log.info("查询源数据，id: {}", id);
        return super.getById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(SourceData data) {
        log.info("保存源数据：userCode={}, businessTime={}", data.getUserCode(), data.getBusinessTime());
        
        // 设置默认值
        if (data.getCreateTime() == null) {
            data.setCreateTime(LocalDateTime.now());
        }
        if (data.getUpdateTime() == null) {
            data.setUpdateTime(LocalDateTime.now());
        }
        if (data.getStatus() == null) {
            data.setStatus(0);
        }
        
        boolean result = super.save(data);
        log.info("保存结果：{}, id: {}", result, data.getId());
        return result;
    }

    @Override
    public List<SourceData> listByTimeRange(LocalDateTime startTime, LocalDateTime endTime) {
        log.info("根据时间范围查询：startTime={}, endTime={}", startTime, endTime);
        
        LambdaQueryWrapper<SourceData> wrapper = new LambdaQueryWrapper<>();
        wrapper.ge(SourceData::getBusinessTime, startTime)
               .le(SourceData::getBusinessTime, endTime)
               .orderByDesc(SourceData::getBusinessTime);
        
        return this.list(wrapper);
    }

    @Override
    public List<SourceData> listByUserCodeAndTimeRange(String userCode, LocalDateTime startTime, LocalDateTime endTime) {
        log.info("根据用户编码和时间范围查询：userCode={}, startTime={}, endTime={}", userCode, startTime, endTime);
        
//        LambdaQueryWrapper<SourceData> wrapper = new LambdaQueryWrapper<>();
//        wrapper.eq(SourceData::getUserCode, userCode)
//               .ge(SourceData::getBusinessTime, startTime)
//               .le(SourceData::getBusinessTime, endTime)
//               .orderByDesc(SourceData::getBusinessTime);
//        return this.list(wrapper);
        return sourceDataMapper.selectByUserCodeAndTimeRange(userCode, startTime, endTime);
    }
}
