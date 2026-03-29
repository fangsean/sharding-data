package com.datastream.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.datastream.entity.SourceData;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 源数据服务接口
 */
public interface SourceDataService extends IService<SourceData> {
    
    /**
     * 根据 ID 获取源数据
     * @param id 主键 ID
     * @return 源数据
     */
    SourceData getById(Long id);
    
    /**
     * 保存源数据（自动路由到对应分表）
     * @param data 源数据
     * @return 是否成功
     */
    boolean save(SourceData data);
    
    /**
     * 根据时间范围查询
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @return 数据列表
     */
    List<SourceData> listByTimeRange(LocalDateTime startTime, LocalDateTime endTime);
    
    /**
     * 根据用户编码和时间范围查询
     * @param userCode 用户编码
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @return 数据列表
     */
    List<SourceData> listByUserCodeAndTimeRange(String userCode, LocalDateTime startTime, LocalDateTime endTime);
}
