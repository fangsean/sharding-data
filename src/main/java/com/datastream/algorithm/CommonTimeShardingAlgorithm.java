package com.datastream.algorithm;

import lombok.extern.slf4j.Slf4j;
import org.apache.shardingsphere.sharding.api.sharding.standard.PreciseShardingValue;
import org.apache.shardingsphere.sharding.api.sharding.standard.RangeShardingValue;
import org.apache.shardingsphere.sharding.api.sharding.standard.StandardShardingAlgorithm;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.Collection;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

/**
 * 通用时间分片算法
 * 支持年、月、日三种分片策略
 * <p>
 * 配置参数：
 * - tablePrefix: 表名前缀（默认：source_data_）
 * - strategy: 分片策略 YEAR|MONTH|DAY（默认：MONTH）
 * - shardingColumn: 分片字段（默认：business_time）
 */
@Slf4j
public class CommonTimeShardingAlgorithm implements StandardShardingAlgorithm<Comparable<?>> {

    private static final DateTimeFormatter YEAR_FORMATTER = DateTimeFormatter.ofPattern("yyyy");
    private static final DateTimeFormatter MONTH_FORMATTER = DateTimeFormatter.ofPattern("yyyyMM");
    private static final DateTimeFormatter DAY_FORMATTER = DateTimeFormatter.ofPattern("yyyyMMdd");

    /**
     * 表名前缀
     */
    private String tablePrefix;

    /**
     * 分片策略：YEAR(年), MONTH(月), DAY(日)
     */
    private String strategy;

    /**
     * 分片字段名
     */
    private String shardingColumn;

    private Properties props;

    @Override
    public void init(Properties props) {
        this.props = props;
        this.tablePrefix = props.getProperty("tablePrefix");
        this.strategy = props.getProperty("custom-strategy").toUpperCase();
        this.shardingColumn = props.getProperty("shardingColumn");

        log.info("CommonTimeShardingAlgorithm 初始化完成 - 表前缀：{}, 策略：{}, 分片字段：{}",
                tablePrefix, strategy, shardingColumn);
    }

    /**
     * 精确分片（=, IN 查询）
     */
    @Override
    public String doSharding(Collection<String> availableTargetNames, PreciseShardingValue<Comparable<?>> shardingValue) {
        Comparable<?> value = shardingValue.getValue();
        LocalDateTime time = convertToLocalDateTime(value);
        String targetTable = calculateTargetTable(time);

        log.info("精确分片 - 字段：{}, 值：{}, 策略：{}, 目标表：{}",
                shardingColumn, value, strategy, targetTable);

        return targetTable;
    }

    /**
     * 范围分片（BETWEEN, >, < 查询）
     */
    @Override
    public Collection<String> doSharding(Collection<String> availableTargetNames, RangeShardingValue<Comparable<?>> shardingValue) {
        LocalDateTime rangeStart = convertToLocalDateTime(shardingValue.getValueRange().lowerEndpoint());
        LocalDateTime rangeEnd = convertToLocalDateTime(shardingValue.getValueRange().upperEndpoint());

        log.info("范围分片 - 字段：{}, 范围：[{} ~ {}], 策略：{}",
                shardingColumn, rangeStart.format(MONTH_FORMATTER), rangeEnd.format(MONTH_FORMATTER), strategy);

        Set<String> targetTables = new HashSet<>();

        if ("DAY".equals(strategy)) {
            // 按日策略：生成范围内的所有日表
            LocalDate currentDate = rangeStart.toLocalDate();
            LocalDate endDate = rangeEnd.toLocalDate();

            while (!currentDate.isAfter(endDate)) {
                String tableName = tablePrefix + currentDate.format(DAY_FORMATTER);
                targetTables.add(tableName);
                currentDate = currentDate.plusDays(1);
            }
        } else if ("MONTH".equals(strategy)) {
            // 按月策略：生成范围内的所有月表
            YearMonth currentMonth = YearMonth.from(rangeStart);
            YearMonth endMonth = YearMonth.from(rangeEnd);

            while (!currentMonth.isAfter(endMonth)) {
                String tableName = tablePrefix + currentMonth.format(MONTH_FORMATTER);
                targetTables.add(tableName);
                currentMonth = currentMonth.plusMonths(1);
            }
        } else if ("YEAR".equals(strategy)) {
            // 按年策略：生成范围内的所有年表
            int startYear = rangeStart.getYear();
            int endYear = rangeEnd.getYear();

            for (int year = startYear; year <= endYear; year++) {
                String tableName = tablePrefix + year;
                targetTables.add(tableName);
            }
        }

        log.info("范围分片完成 - 目标表数量：{}, 表列表：{}", targetTables.size(), targetTables);
        return targetTables;
    }

    /**
     * 计算目标表名
     */
    private String calculateTargetTable(LocalDateTime time) {
        String suffix;
        switch (strategy) {
            case "YEAR":
                suffix = time.format(YEAR_FORMATTER);
                break;
            case "DAY":
                suffix = time.format(DAY_FORMATTER);
                break;
            case "MONTH":
            default:
                suffix = time.format(MONTH_FORMATTER);
                break;
        }
        return tablePrefix + suffix;
    }

    /**
     * 转换为 LocalDateTime
     */
    @SuppressWarnings("unchecked")
    private LocalDateTime convertToLocalDateTime(Comparable<?> value) {
        if (value instanceof LocalDateTime) {
            return (LocalDateTime) value;
        } else if (value instanceof LocalDate) {
            return ((LocalDate) value).atStartOfDay();
        } else if (value instanceof String) {
            // 支持字符串格式：yyyy-MM-dd HH:mm:ss 或 yyyy-MM-dd
            String strValue = (String) value;
            if (strValue.length() == 10) {
                // yyyy-MM-dd
                return LocalDate.parse(strValue, DateTimeFormatter.ISO_LOCAL_DATE).atStartOfDay();
            } else {
                // yyyy-MM-dd HH:mm:ss
                return LocalDateTime.parse(strValue, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
            }
        } else {
            throw new IllegalArgumentException("不支持的分片值类型：" + value.getClass().getName());
        }
    }

    @Override
    public String getType() {
        return "CLASS_BASED";
    }
}
