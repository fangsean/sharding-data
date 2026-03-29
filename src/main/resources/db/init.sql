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

-- 2024 年 1 月表
DROP TABLE IF EXISTS `source_data_20240101`;
CREATE TABLE `source_data_20240101` (
  `id` bigint NOT NULL COMMENT '主键 ID',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='源数据表 2024-01';

-- 2024 年 2 月表
DROP TABLE IF EXISTS `source_data_20240102`;
CREATE TABLE `source_data_20240102` LIKE `source_data_20240101`;

-- 2024 年 3 月表
DROP TABLE IF EXISTS `source_data_20240103`;
CREATE TABLE `source_data_20240103` LIKE `source_data_20240101`;

-- 2024 年 4 月表
DROP TABLE IF EXISTS `source_data_20240104`;
CREATE TABLE `source_data_20240104` LIKE `source_data_20240101`;

-- 2024 年 5 月表
DROP TABLE IF EXISTS `source_data_20240105`;
CREATE TABLE `source_data_20240105` LIKE `source_data_20240101`;

-- 2024 年 6 月表
DROP TABLE IF EXISTS `source_data_20240106`;
CREATE TABLE `source_data_20240106` LIKE `source_data_20240101`;

-- 2024 年 7 月表
DROP TABLE IF EXISTS `source_data_20240107`;
CREATE TABLE `source_data_20240107` LIKE `source_data_20240101`;

-- 2024 年 8 月表
DROP TABLE IF EXISTS `source_data_20240108`;
CREATE TABLE `source_data_20240108` LIKE `source_data_20240101`;

-- 2024 年 9 月表
DROP TABLE IF EXISTS `source_data_20240109`;
CREATE TABLE `source_data_20240109` LIKE `source_data_20240101`;

-- 2024 年 10 月表
DROP TABLE IF EXISTS `source_data_20240110`;
CREATE TABLE `source_data_20240110` LIKE `source_data_20240101`;

-- 2024 年 11 月表
DROP TABLE IF EXISTS `source_data_20240111`;
CREATE TABLE `source_data_20240111` LIKE `source_data_20240101`;

-- 2024 年 12 月表
DROP TABLE IF EXISTS `source_data_20240112`;
CREATE TABLE `source_data_20240112` LIKE `source_data_20240101`;

-- ============================================
-- 在 unit-02 中创建 12 张月份表（2024 年）
-- ============================================

USE `unit-02`;

-- 2024 年 1 月表
DROP TABLE IF EXISTS `source_data_20240101`;
CREATE TABLE `source_data_20240101` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 2 月表
DROP TABLE IF EXISTS `source_data_20240102`;
CREATE TABLE `source_data_20240102` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 3 月表
DROP TABLE IF EXISTS `source_data_20240103`;
CREATE TABLE `source_data_20240103` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 4 月表
DROP TABLE IF EXISTS `source_data_20240104`;
CREATE TABLE `source_data_20240104` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 5 月表
DROP TABLE IF EXISTS `source_data_20240105`;
CREATE TABLE `source_data_20240105` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 6 月表
DROP TABLE IF EXISTS `source_data_20240106`;
CREATE TABLE `source_data_20240106` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 7 月表
DROP TABLE IF EXISTS `source_data_20240107`;
CREATE TABLE `source_data_20240107` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 8 月表
DROP TABLE IF EXISTS `source_data_20240108`;
CREATE TABLE `source_data_20240108` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 9 月表
DROP TABLE IF EXISTS `source_data_20240109`;
CREATE TABLE `source_data_20240109` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 10 月表
DROP TABLE IF EXISTS `source_data_20240110`;
CREATE TABLE `source_data_20240110` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 11 月表
DROP TABLE IF EXISTS `source_data_20240111`;
CREATE TABLE `source_data_20240111` LIKE `unit-01`.`source_data_20240101`;

-- 2024 年 12 月表
DROP TABLE IF EXISTS `source_data_20240112`;
CREATE TABLE `source_data_20240112` LIKE `unit-01`.`source_data_20240101`;

-- ============================================
-- 说明：
-- 1. 实际生产环境需要根据业务时间范围扩展更多年份的表
--    例如：2025 年的表 source_data_202501 ~ source_data_202512
-- 2. 可以定期执行 DDL 自动创建未来月份的表
-- 3. user_code 为偶数的路由到 unit-01，奇数的路由到 unit-02
-- ============================================
