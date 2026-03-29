package com.datastream.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.datastream.entity.SourceData;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 源数据 Mapper 接口
 */
@Mapper
public interface SourceDataMapper extends BaseMapper<SourceData> {

    /**
     * 根据时间范围查询
     */
    List<SourceData> selectByTimeRange(
        @Param("startTime") LocalDateTime startTime,
        @Param("endTime") LocalDateTime endTime
    );

    /**
     * 根据用户编码和时间范围查询
     */
    List<SourceData> selectByUserCodeAndTimeRange(
        @Param("userCode") String userCode,
        @Param("startTime") LocalDateTime startTime,
        @Param("endTime") LocalDateTime endTime
    );
}
