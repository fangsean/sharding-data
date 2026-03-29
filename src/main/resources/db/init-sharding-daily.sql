-- ============================================
-- ShardingSphere 5.5.0 分库分表初始化脚本
-- source_data 表按日分片（yyyyMMdd）
-- ============================================

-- 创建数据库 unit-01
CREATE DATABASE IF NOT EXISTS `unit-01` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `unit-01`;

-- ============================================
-- 创建 source_data 日分片表（示例：2024 年部分日期）
-- ============================================

-- 2024 年 1 月 1 日表
DROP TABLE IF EXISTS `source_data_20240101`;
CREATE TABLE `source_data_20240101` (
  `id` bigint NOT NULL COMMENT '主键 ID',
  `business_time` datetime DEFAULT NULL COMMENT '业务时间',
  `user_code` varchar(50) DEFAULT NULL COMMENT '用户编码',
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
-- 创建广播表（所有库表结构一致，不拆分）
-- ============================================

-- 城市表（广播表）
DROP TABLE IF EXISTS `t_city`;
CREATE TABLE `t_city` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `city_code` varchar(20) NOT NULL COMMENT '城市编码',
  `city_name` varchar(100) NOT NULL COMMENT '城市名称',
  `province` varchar(50) DEFAULT NULL COMMENT '省份',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_city_code` (`city_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='城市表（广播表）';

-- 配置表（广播表）
DROP TABLE IF EXISTS `config_table`;
CREATE TABLE `config_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `config_key` varchar(100) NOT NULL COMMENT '配置键',
  `config_value` text COMMENT '配置值',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='配置表（广播表）';

-- 字典表（广播表）
DROP TABLE IF EXISTS `dict_table`;
CREATE TABLE `dict_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dict_type` varchar(50) NOT NULL COMMENT '字典类型',
  `dict_code` varchar(50) NOT NULL COMMENT '字典编码',
  `dict_name` varchar(100) NOT NULL COMMENT '字典名称',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_dict` (`dict_type`, `dict_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典表（广播表）';

-- ============================================
-- 插入测试数据
-- ============================================

-- 插入城市数据
INSERT INTO `t_city` (`city_code`, `city_name`, `province`) VALUES 
('BJ001', '北京市', '北京市'),
('SH001', '上海市', '上海市'),
('GZ001', '广州市', '广东省'),
('SZ001', '深圳市', '广东省');

-- 插入配置数据
INSERT INTO `config_table` (`config_key`, `config_value`, `description`) VALUES
('system.version', '1.0.0', '系统版本'),
('system.maintenance', 'false', '是否维护模式');

-- 插入字典数据
INSERT INTO `dict_table` (`dict_type`, `dict_code`, `dict_name`, `sort_order`) VALUES
('STATUS', '0', '禁用', 1),
('STATUS', '1', '启用', 2);

-- ============================================
-- 说明：
-- 1. 实际生产环境需要定期执行 DDL 自动创建未来日期的表
--    例如：每天凌晨创建 T+7 天的表
-- 2. 广播表（t_city, config_table, dict_table）在所有库中同步
-- 3. source_data 表根据 business_time 自动路由到对应的日表
-- ============================================

CREATE TABLE `source_data_20240113` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240114` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240115` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240116` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240117` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240118` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240119` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240120` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240121` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240122` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240123` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240124` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240125` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240126` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240127` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240128` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240129` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240130` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240131` LIKE `source_data_20240101`;
