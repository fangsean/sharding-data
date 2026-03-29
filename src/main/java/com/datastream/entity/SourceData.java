package com.datastream.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 源数据实体类
 * 对应表：source_data_YYYYMM
 */
@Data
@TableName("source_data")
public class SourceData {

    /**
     * 主键 ID
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;
    
    /**
     * 业务时间（分片键）
     */
    private LocalDateTime businessTime;
    
    /**
     * 用户编码（去重关键字，分库键）
     */
    private String userCode;
    
    /**
     * 用户姓名
     */
    private String userName;
    
    /**
     * 金额
     */
    private BigDecimal amount;
    
    /**
     * 状态
     */
    private Integer status;
    
    /**
     * 备注
     */
    private String remark;
    
    /**
     * 创建时间
     */
    private LocalDateTime createTime;
    
    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}
