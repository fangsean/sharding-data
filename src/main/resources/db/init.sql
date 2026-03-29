-- ============================================
-- 分库分表初始化脚本
-- 数据库：unit-01, unit-02
-- 分片策略：
--   - 分库键：user_code (HASH_MOD 2)
--   - 分表键：business_time (按月分表)
-- ============================================

-- 创建数据库 unit-01
CREATE DATABASE IF NOT EXISTS `unit-01` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `unit-01`;

-- 创建数据库 unit-02
CREATE DATABASE IF NOT EXISTS `unit-02` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `unit-02`;

-- ============================================
-- 在 unit-01 中创建 12 张月份表（2024 年）
-- ============================================

USE `unit-01`;

DROP TABLE IF EXISTS `source_data`;
CREATE TABLE `source_data` (
  `id` bigint primary key COMMENT '主键 ID',
  `business_time` datetime DEFAULT NULL COMMENT '业务时间',
  `user_code` varchar(50) DEFAULT NULL COMMENT '用户编码（去重关键字）',
  `user_name` varchar(100) DEFAULT NULL COMMENT '用户姓名',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `status` int DEFAULT NULL COMMENT '状态',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_business_time` (`business_time`),
  KEY `idx_user_code` (`user_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='源数据表';

