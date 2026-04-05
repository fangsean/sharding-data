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

CREATE TABLE `source_data_20240201` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240202` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240203` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240204` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240205` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240206` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240207` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240208` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240209` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240210` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240211` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240212` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240213` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240214` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240215` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240216` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240217` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240218` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240219` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240220` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240221` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240222` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240223` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240224` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240225` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240226` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240227` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240228` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240229` LIKE `source_data_20240101`;

CREATE TABLE `source_data_20240301` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240302` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240303` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240304` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240305` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240306` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240307` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240308` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240309` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240310` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240311` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240312` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240313` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240314` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240315` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240316` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240317` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240318` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240319` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240320` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240321` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240322` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240323` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240324` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240325` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240326` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240327` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240328` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240329` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240330` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20240331` LIKE `source_data_20240101`;


CREATE TABLE `source_data_20231201` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231202` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231203` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231204` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231205` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231206` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231207` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231208` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231209` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231210` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231211` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231212` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231213` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231214` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231215` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231216` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231217` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231218` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231219` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231220` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231221` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231222` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231223` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231224` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231225` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231226` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231227` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231228` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231229` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231230` LIKE `source_data_20240101`;
CREATE TABLE `source_data_20231231` LIKE `source_data_20240101`;

