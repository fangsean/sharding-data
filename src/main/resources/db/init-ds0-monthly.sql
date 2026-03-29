-- ============================================
-- 分库分表初始化脚本 - 按月分表方案
-- 数据库：ds0
-- 分片策略：按月分表（12 张表）
-- ============================================

-- 创建数据库 ds0
CREATE DATABASE IF NOT EXISTS `ds0` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `ds0`;

-- 创建 2024 年 12 张月份表
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

-- 复制创建其他月份表
DROP TABLE IF EXISTS `source_data_202402`;
CREATE TABLE `source_data_202402` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202403`;
CREATE TABLE `source_data_202403` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202404`;
CREATE TABLE `source_data_202404` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202405`;
CREATE TABLE `source_data_202405` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202406`;
CREATE TABLE `source_data_202406` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202407`;
CREATE TABLE `source_data_202407` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202408`;
CREATE TABLE `source_data_202408` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202409`;
CREATE TABLE `source_data_202409` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202410`;
CREATE TABLE `source_data_202410` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202411`;
CREATE TABLE `source_data_202411` LIKE `source_data_202401`;

DROP TABLE IF EXISTS `source_data_202412`;
CREATE TABLE `source_data_202412` LIKE `source_data_202401`;

-- ============================================
-- 说明：
-- 1. 当前配置使用 MonthShardingAlgorithm 按月分表
-- 2. 实际数据节点：ds0.source_data_202401 ~ ds0.source_data_202412
-- 3. 根据 business_time 字段自动路由到对应月份表
-- ============================================
