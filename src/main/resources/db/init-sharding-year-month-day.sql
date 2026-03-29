-- ============================================
-- 分库分表初始化脚本 - 支持年、月、日三种分片策略
-- 数据库：ds_2024, ds_2025, ds_2026
-- 分片策略：
--   - 方案一：按年分库 + 按月分表（推荐）
--   - 方案二：按日分表（适合数据量极大的场景）
-- ============================================

-- ============================================
-- 创建数据库（按年分库）
-- ============================================
CREATE DATABASE IF NOT EXISTS `ds_2024` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE DATABASE IF NOT EXISTS `ds_2025` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE DATABASE IF NOT EXISTS `ds_2026` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- ============================================
-- 在 ds_2024 中创建 12 张月份表
-- ============================================
USE `ds_2024`;

-- 2024 年 1 月表
DROP TABLE IF EXISTS `source_data_202401`;
CREATE TABLE `source_data_202401` (
  `id` bigint NOT NULL COMMENT '主键 ID',
  `business_time` datetime DEFAULT NULL COMMENT '业务时间（分片键）',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='源数据表 2024-01';

-- 2024 年 2 月表
DROP TABLE IF EXISTS `source_data_202402`;
CREATE TABLE `source_data_202402` LIKE `source_data_202401`;

-- 2024 年 3 月表
DROP TABLE IF EXISTS `source_data_202403`;
CREATE TABLE `source_data_202403` LIKE `source_data_202401`;

-- 2024 年 4 月表
DROP TABLE IF EXISTS `source_data_202404`;
CREATE TABLE `source_data_202404` LIKE `source_data_202401`;

-- 2024 年 5 月表
DROP TABLE IF EXISTS `source_data_202405`;
CREATE TABLE `source_data_202405` LIKE `source_data_202401`;

-- 2024 年 6 月表
DROP TABLE IF EXISTS `source_data_202406`;
CREATE TABLE `source_data_202406` LIKE `source_data_202401`;

-- 2024 年 7 月表
DROP TABLE IF EXISTS `source_data_202407`;
CREATE TABLE `source_data_202407` LIKE `source_data_202401`;

-- 2024 年 8 月表
DROP TABLE IF EXISTS `source_data_202408`;
CREATE TABLE `source_data_202408` LIKE `source_data_202401`;

-- 2024 年 9 月表
DROP TABLE IF EXISTS `source_data_202409`;
CREATE TABLE `source_data_202409` LIKE `source_data_202401`;

-- 2024 年 10 月表
DROP TABLE IF EXISTS `source_data_202410`;
CREATE TABLE `source_data_202410` LIKE `source_data_202401`;

-- 2024 年 11 月表
DROP TABLE IF EXISTS `source_data_202411`;
CREATE TABLE `source_data_202411` LIKE `source_data_202401`;

-- 2024 年 12 月表
DROP TABLE IF EXISTS `source_data_202412`;
CREATE TABLE `source_data_202412` LIKE `source_data_202401`;

-- ============================================
-- 在 ds_2025 中创建 12 张月份表
-- ============================================
USE `ds_2025`;

-- 2025 年各月表（复制 ds_2024 的结构）
DROP TABLE IF EXISTS `source_data_202501`;
CREATE TABLE `source_data_202501` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202502`;
CREATE TABLE `source_data_202502` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202503`;
CREATE TABLE `source_data_202503` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202504`;
CREATE TABLE `source_data_202504` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202505`;
CREATE TABLE `source_data_202505` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202506`;
CREATE TABLE `source_data_202506` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202507`;
CREATE TABLE `source_data_202507` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202508`;
CREATE TABLE `source_data_202508` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202509`;
CREATE TABLE `source_data_202509` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202510`;
CREATE TABLE `source_data_202510` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202511`;
CREATE TABLE `source_data_202511` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202512`;
CREATE TABLE `source_data_202512` LIKE `ds_2024`.`source_data_202401`;

-- ============================================
-- 在 ds_2026 中创建 12 张月份表
-- ============================================
USE `ds_2026`;

-- 2026 年各月表（复制 ds_2024 的结构）
DROP TABLE IF EXISTS `source_data_202601`;
CREATE TABLE `source_data_202601` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202602`;
CREATE TABLE `source_data_202602` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202603`;
CREATE TABLE `source_data_202603` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202604`;
CREATE TABLE `source_data_202604` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202605`;
CREATE TABLE `source_data_202605` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202606`;
CREATE TABLE `source_data_202606` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202607`;
CREATE TABLE `source_data_202607` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202608`;
CREATE TABLE `source_data_202608` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202609`;
CREATE TABLE `source_data_202609` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202610`;
CREATE TABLE `source_data_202610` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202611`;
CREATE TABLE `source_data_202611` LIKE `ds_2024`.`source_data_202401`;

DROP TABLE IF EXISTS `source_data_202612`;
CREATE TABLE `source_data_202612` LIKE `ds_2024`.`source_data_202401`;

-- ============================================
-- 按日分表演示（可选，适合数据量极大的场景）
-- 以 2024 年 1 月为例，创建 31 张日表
-- ============================================
USE `ds_2024`;

-- 2024 年 1 月 1 日表
DROP TABLE IF EXISTS `source_data_20240101`;
CREATE TABLE `source_data_20240101` (
  `id` bigint NOT NULL COMMENT '主键 ID',
  `business_time` datetime DEFAULT NULL COMMENT '业务时间（分片键）',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='源数据表 2024-01-01';

-- 2024 年 1 月 2 日表
DROP TABLE IF EXISTS `source_data_20240102`;
CREATE TABLE `source_data_20240102` LIKE `source_data_20240101`;

-- 2024 年 1 月 3 日表
DROP TABLE IF EXISTS `source_data_20240103`;
CREATE TABLE `source_data_20240103` LIKE `source_data_20240101`;

-- 2024 年 1 月 4 日表
DROP TABLE IF EXISTS `source_data_20240104`;
CREATE TABLE `source_data_20240104` LIKE `source_data_20240101`;

-- 2024 年 1 月 5 日表
DROP TABLE IF EXISTS `source_data_20240105`;
CREATE TABLE `source_data_20240105` LIKE `source_data_20240101`;

-- ============================================
-- 说明：
-- 1. 本脚本支持三种分片策略：
--    - YearShardingAlgorithm:  按年分库，表名格式 source_data_2024
--    - MonthShardingAlgorithm: 按月分表，表名格式 source_data_202401
--    - DayShardingAlgorithm:   按日分表，表名格式 source_data_20240115
--
-- 2. 推荐使用按年分库 + 按月分表的组合策略
-- 3. 按日分表适合每日数据量巨大（千万级以上）的场景
-- 4. 生产环境需要定期执行 DDL 自动创建未来月份的表
-- ============================================
