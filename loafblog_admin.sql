/*
 Navicat Premium Data Transfer

 Source Server         : linuxMysql
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : 192.168.145.132:3306
 Source Schema         : loafblog_admin

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 15/11/2021 19:37:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', '0 0/30 * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', NULL, 'io.renren.modules.job.utils.ScheduleJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002E696F2E72656E72656E2E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017BA3B938707874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000174000672656E72656E74000CE58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
INSERT INTO `QRTZ_LOCKS` VALUES ('RenrenScheduler', 'STATE_ACCESS');
INSERT INTO `QRTZ_LOCKS` VALUES ('RenrenScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('RenrenScheduler', 'LAPTOP-VD12OFDK1636129183612', 1636129986312, 15000);

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_TRIGGERS` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', 'TASK_1', 'DEFAULT', NULL, 1636131600000, 1636129800000, 5, 'WAITING', 'CRON', 1630568433000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002E696F2E72656E72656E2E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017BA3B938707874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000174000672656E72656E74000CE58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);

-- ----------------------------
-- Table structure for fastdfsFile
-- ----------------------------
DROP TABLE IF EXISTS `fastdfsFile`;
CREATE TABLE `fastdfsFile`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件url',
  `fastName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'fastdfs存储文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fastdfsFile
-- ----------------------------
INSERT INTO `fastdfsFile` VALUES (1, 'http://8.129.122.160/group1/M00/00/00/CIF6oGE_dN2ADOHiAAEDWfTo4ag298.jpg', 'group1/M00/00/00/CIF6oGE_dN2ADOHiAAEDWfTo4ag298.jpg');
INSERT INTO `fastdfsFile` VALUES (2, 'http://8.129.122.160/group1/M00/00/00/CIF6oGFAUv6ASk-KAATtAHQRY6U689.jpg', 'group1/M00/00/00/CIF6oGFAUv6ASk-KAATtAHQRY6U689.jpg');
INSERT INTO `fastdfsFile` VALUES (3, 'http://8.129.122.160/group1/M00/00/00/CIF6oGFAVIiAD8r7AACqDFSqxjk493.png', 'group1/M00/00/00/CIF6oGFAVIiAD8r7AACqDFSqxjk493.png');
INSERT INTO `fastdfsFile` VALUES (4, 'http://8.129.122.160/group1/M00/00/00/CIF6oGFAV5eATtpzAABeRL3C254406.jpg', 'group1/M00/00/00/CIF6oGFAV5eATtpzAABeRL3C254406.jpg');
INSERT INTO `fastdfsFile` VALUES (5, 'http://8.129.122.160/group1/M00/00/00/CIF6oGFAWUKAUuPHAACuuDVT7jk446.jpg', 'group1/M00/00/00/CIF6oGFAWUKAUuPHAACuuDVT7jk446.jpg');

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES (1, 'testTask', 'renren', '0 0/30 * * * ?', 0, '参数测试', '2021-09-02 07:37:10');

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `job_id`(`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 452 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------
INSERT INTO `schedule_job_log` VALUES (1, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-04 10:30:00');
INSERT INTO `schedule_job_log` VALUES (2, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-04 11:00:00');
INSERT INTO `schedule_job_log` VALUES (3, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-04 11:30:00');
INSERT INTO `schedule_job_log` VALUES (4, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-04 14:00:00');
INSERT INTO `schedule_job_log` VALUES (5, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-04 14:30:00');
INSERT INTO `schedule_job_log` VALUES (6, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-04 15:00:00');
INSERT INTO `schedule_job_log` VALUES (7, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-04 22:00:00');
INSERT INTO `schedule_job_log` VALUES (8, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-05 10:00:00');
INSERT INTO `schedule_job_log` VALUES (9, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-05 10:30:00');
INSERT INTO `schedule_job_log` VALUES (10, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-05 15:30:00');
INSERT INTO `schedule_job_log` VALUES (11, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-05 17:30:00');
INSERT INTO `schedule_job_log` VALUES (12, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-05 18:00:00');
INSERT INTO `schedule_job_log` VALUES (13, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-05 18:30:00');
INSERT INTO `schedule_job_log` VALUES (14, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-05 19:00:00');
INSERT INTO `schedule_job_log` VALUES (15, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-05 19:30:00');
INSERT INTO `schedule_job_log` VALUES (16, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-05 20:00:00');
INSERT INTO `schedule_job_log` VALUES (17, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-05 20:30:00');
INSERT INTO `schedule_job_log` VALUES (18, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-05 21:00:00');
INSERT INTO `schedule_job_log` VALUES (19, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-05 21:30:00');
INSERT INTO `schedule_job_log` VALUES (20, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-05 22:00:00');
INSERT INTO `schedule_job_log` VALUES (21, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-05 22:30:00');
INSERT INTO `schedule_job_log` VALUES (22, 1, 'testTask', 'renren', 0, NULL, 7, '2021-09-05 23:00:00');
INSERT INTO `schedule_job_log` VALUES (23, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-06 17:00:00');
INSERT INTO `schedule_job_log` VALUES (24, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-06 17:30:00');
INSERT INTO `schedule_job_log` VALUES (25, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-06 18:00:00');
INSERT INTO `schedule_job_log` VALUES (26, 1, 'testTask', 'renren', 0, NULL, 4, '2021-09-06 18:30:00');
INSERT INTO `schedule_job_log` VALUES (27, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-06 19:00:00');
INSERT INTO `schedule_job_log` VALUES (28, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-06 19:30:00');
INSERT INTO `schedule_job_log` VALUES (29, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-06 20:00:00');
INSERT INTO `schedule_job_log` VALUES (30, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-06 20:30:00');
INSERT INTO `schedule_job_log` VALUES (31, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-06 21:30:00');
INSERT INTO `schedule_job_log` VALUES (32, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-06 22:00:00');
INSERT INTO `schedule_job_log` VALUES (33, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-06 22:30:00');
INSERT INTO `schedule_job_log` VALUES (34, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-06 23:00:00');
INSERT INTO `schedule_job_log` VALUES (35, 1, 'testTask', 'renren', 0, NULL, 4, '2021-09-07 08:30:00');
INSERT INTO `schedule_job_log` VALUES (36, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-07 09:00:00');
INSERT INTO `schedule_job_log` VALUES (37, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-07 09:30:00');
INSERT INTO `schedule_job_log` VALUES (38, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-07 10:00:00');
INSERT INTO `schedule_job_log` VALUES (39, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-07 10:30:00');
INSERT INTO `schedule_job_log` VALUES (40, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-07 11:00:00');
INSERT INTO `schedule_job_log` VALUES (41, 1, 'testTask', 'renren', 0, NULL, 9, '2021-09-07 11:30:00');
INSERT INTO `schedule_job_log` VALUES (42, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-07 12:00:00');
INSERT INTO `schedule_job_log` VALUES (43, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-07 12:30:00');
INSERT INTO `schedule_job_log` VALUES (44, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-07 13:00:00');
INSERT INTO `schedule_job_log` VALUES (45, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-07 13:30:00');
INSERT INTO `schedule_job_log` VALUES (46, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-07 14:00:00');
INSERT INTO `schedule_job_log` VALUES (47, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-07 14:30:00');
INSERT INTO `schedule_job_log` VALUES (48, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-07 15:00:00');
INSERT INTO `schedule_job_log` VALUES (49, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-07 15:30:00');
INSERT INTO `schedule_job_log` VALUES (50, 1, 'testTask', 'renren', 0, NULL, 6, '2021-09-07 16:00:00');
INSERT INTO `schedule_job_log` VALUES (51, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-07 20:00:00');
INSERT INTO `schedule_job_log` VALUES (52, 1, 'testTask', 'renren', 0, NULL, 4, '2021-09-07 20:30:00');
INSERT INTO `schedule_job_log` VALUES (53, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-07 21:00:00');
INSERT INTO `schedule_job_log` VALUES (54, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-07 21:30:00');
INSERT INTO `schedule_job_log` VALUES (55, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-07 22:00:00');
INSERT INTO `schedule_job_log` VALUES (56, 1, 'testTask', 'renren', 0, NULL, 5, '2021-09-07 22:30:00');
INSERT INTO `schedule_job_log` VALUES (57, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-08 12:30:00');
INSERT INTO `schedule_job_log` VALUES (58, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-08 13:00:00');
INSERT INTO `schedule_job_log` VALUES (59, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-08 13:30:00');
INSERT INTO `schedule_job_log` VALUES (60, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-08 14:00:00');
INSERT INTO `schedule_job_log` VALUES (61, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-08 14:30:00');
INSERT INTO `schedule_job_log` VALUES (62, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-08 21:00:00');
INSERT INTO `schedule_job_log` VALUES (63, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-08 21:30:00');
INSERT INTO `schedule_job_log` VALUES (64, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-08 22:00:00');
INSERT INTO `schedule_job_log` VALUES (65, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-08 22:30:00');
INSERT INTO `schedule_job_log` VALUES (66, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-08 23:00:00');
INSERT INTO `schedule_job_log` VALUES (67, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-08 23:30:00');
INSERT INTO `schedule_job_log` VALUES (68, 1, 'testTask', 'renren', 0, NULL, 61, '2021-09-09 00:00:00');
INSERT INTO `schedule_job_log` VALUES (69, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 09:00:00');
INSERT INTO `schedule_job_log` VALUES (70, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 09:30:00');
INSERT INTO `schedule_job_log` VALUES (71, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 10:00:00');
INSERT INTO `schedule_job_log` VALUES (72, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 10:30:00');
INSERT INTO `schedule_job_log` VALUES (73, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 11:00:00');
INSERT INTO `schedule_job_log` VALUES (74, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 11:30:00');
INSERT INTO `schedule_job_log` VALUES (75, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 12:00:00');
INSERT INTO `schedule_job_log` VALUES (76, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 12:30:00');
INSERT INTO `schedule_job_log` VALUES (77, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 13:00:00');
INSERT INTO `schedule_job_log` VALUES (78, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 13:30:00');
INSERT INTO `schedule_job_log` VALUES (79, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 14:00:00');
INSERT INTO `schedule_job_log` VALUES (80, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 14:30:00');
INSERT INTO `schedule_job_log` VALUES (81, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 15:00:00');
INSERT INTO `schedule_job_log` VALUES (82, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 15:30:00');
INSERT INTO `schedule_job_log` VALUES (83, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 16:00:00');
INSERT INTO `schedule_job_log` VALUES (84, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 16:30:00');
INSERT INTO `schedule_job_log` VALUES (85, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 17:00:00');
INSERT INTO `schedule_job_log` VALUES (86, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 17:30:00');
INSERT INTO `schedule_job_log` VALUES (87, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-09 18:00:00');
INSERT INTO `schedule_job_log` VALUES (88, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 18:30:00');
INSERT INTO `schedule_job_log` VALUES (89, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 19:00:00');
INSERT INTO `schedule_job_log` VALUES (90, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 19:30:00');
INSERT INTO `schedule_job_log` VALUES (91, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-09 20:00:00');
INSERT INTO `schedule_job_log` VALUES (92, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-09 20:30:00');
INSERT INTO `schedule_job_log` VALUES (93, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 21:00:00');
INSERT INTO `schedule_job_log` VALUES (94, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 21:30:00');
INSERT INTO `schedule_job_log` VALUES (95, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 22:00:00');
INSERT INTO `schedule_job_log` VALUES (96, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 22:30:00');
INSERT INTO `schedule_job_log` VALUES (97, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-09 23:00:00');
INSERT INTO `schedule_job_log` VALUES (98, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-09 23:30:10');
INSERT INTO `schedule_job_log` VALUES (99, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-10 09:00:00');
INSERT INTO `schedule_job_log` VALUES (100, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-10 12:00:00');
INSERT INTO `schedule_job_log` VALUES (101, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-10 15:00:00');
INSERT INTO `schedule_job_log` VALUES (102, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-10 15:30:00');
INSERT INTO `schedule_job_log` VALUES (103, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-10 16:00:00');
INSERT INTO `schedule_job_log` VALUES (104, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-10 16:30:00');
INSERT INTO `schedule_job_log` VALUES (105, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-10 17:00:00');
INSERT INTO `schedule_job_log` VALUES (106, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-10 17:30:00');
INSERT INTO `schedule_job_log` VALUES (107, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-10 18:00:00');
INSERT INTO `schedule_job_log` VALUES (108, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-10 18:30:00');
INSERT INTO `schedule_job_log` VALUES (109, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-10 19:00:00');
INSERT INTO `schedule_job_log` VALUES (110, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-10 19:30:00');
INSERT INTO `schedule_job_log` VALUES (111, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-10 20:00:00');
INSERT INTO `schedule_job_log` VALUES (112, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-10 20:30:00');
INSERT INTO `schedule_job_log` VALUES (113, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-10 21:00:00');
INSERT INTO `schedule_job_log` VALUES (114, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-10 21:30:00');
INSERT INTO `schedule_job_log` VALUES (115, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-10 22:00:00');
INSERT INTO `schedule_job_log` VALUES (116, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-10 22:30:00');
INSERT INTO `schedule_job_log` VALUES (117, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-10 23:00:00');
INSERT INTO `schedule_job_log` VALUES (118, 1, 'testTask', 'renren', 0, NULL, 12, '2021-09-10 23:30:00');
INSERT INTO `schedule_job_log` VALUES (119, 1, 'testTask', 'renren', 0, NULL, 30, '2021-09-11 00:00:00');
INSERT INTO `schedule_job_log` VALUES (120, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-11 00:30:00');
INSERT INTO `schedule_job_log` VALUES (121, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-11 09:30:00');
INSERT INTO `schedule_job_log` VALUES (122, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-11 10:00:00');
INSERT INTO `schedule_job_log` VALUES (123, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-11 10:30:00');
INSERT INTO `schedule_job_log` VALUES (124, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-11 17:30:00');
INSERT INTO `schedule_job_log` VALUES (125, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-11 18:00:00');
INSERT INTO `schedule_job_log` VALUES (126, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-11 18:30:00');
INSERT INTO `schedule_job_log` VALUES (127, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-11 19:00:00');
INSERT INTO `schedule_job_log` VALUES (128, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-11 19:30:00');
INSERT INTO `schedule_job_log` VALUES (129, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-11 20:00:00');
INSERT INTO `schedule_job_log` VALUES (130, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-11 20:30:00');
INSERT INTO `schedule_job_log` VALUES (131, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-11 21:00:00');
INSERT INTO `schedule_job_log` VALUES (132, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-11 21:30:00');
INSERT INTO `schedule_job_log` VALUES (133, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-11 22:00:00');
INSERT INTO `schedule_job_log` VALUES (134, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-11 22:30:00');
INSERT INTO `schedule_job_log` VALUES (135, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-11 23:00:00');
INSERT INTO `schedule_job_log` VALUES (136, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-11 23:30:00');
INSERT INTO `schedule_job_log` VALUES (137, 1, 'testTask', 'renren', 0, NULL, 9, '2021-09-12 00:00:00');
INSERT INTO `schedule_job_log` VALUES (138, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 10:00:00');
INSERT INTO `schedule_job_log` VALUES (139, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 10:30:00');
INSERT INTO `schedule_job_log` VALUES (140, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 13:30:00');
INSERT INTO `schedule_job_log` VALUES (141, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 14:00:00');
INSERT INTO `schedule_job_log` VALUES (142, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 14:30:00');
INSERT INTO `schedule_job_log` VALUES (143, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 15:00:00');
INSERT INTO `schedule_job_log` VALUES (144, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 15:30:00');
INSERT INTO `schedule_job_log` VALUES (145, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 16:00:00');
INSERT INTO `schedule_job_log` VALUES (146, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 16:30:00');
INSERT INTO `schedule_job_log` VALUES (147, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 17:00:00');
INSERT INTO `schedule_job_log` VALUES (148, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 17:30:00');
INSERT INTO `schedule_job_log` VALUES (149, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 18:00:00');
INSERT INTO `schedule_job_log` VALUES (150, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 18:30:00');
INSERT INTO `schedule_job_log` VALUES (151, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 19:00:00');
INSERT INTO `schedule_job_log` VALUES (152, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 19:30:00');
INSERT INTO `schedule_job_log` VALUES (153, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 20:00:00');
INSERT INTO `schedule_job_log` VALUES (154, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 20:30:00');
INSERT INTO `schedule_job_log` VALUES (155, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 21:00:00');
INSERT INTO `schedule_job_log` VALUES (156, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 21:30:00');
INSERT INTO `schedule_job_log` VALUES (157, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 22:00:00');
INSERT INTO `schedule_job_log` VALUES (158, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 22:30:00');
INSERT INTO `schedule_job_log` VALUES (159, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-12 23:00:00');
INSERT INTO `schedule_job_log` VALUES (160, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-12 23:30:00');
INSERT INTO `schedule_job_log` VALUES (161, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 08:00:00');
INSERT INTO `schedule_job_log` VALUES (162, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 08:30:00');
INSERT INTO `schedule_job_log` VALUES (163, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 09:00:00');
INSERT INTO `schedule_job_log` VALUES (164, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-13 09:30:00');
INSERT INTO `schedule_job_log` VALUES (165, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-13 10:00:00');
INSERT INTO `schedule_job_log` VALUES (166, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-13 10:30:00');
INSERT INTO `schedule_job_log` VALUES (167, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 11:00:00');
INSERT INTO `schedule_job_log` VALUES (168, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 11:30:00');
INSERT INTO `schedule_job_log` VALUES (169, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 12:00:00');
INSERT INTO `schedule_job_log` VALUES (170, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 12:30:00');
INSERT INTO `schedule_job_log` VALUES (171, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 13:00:00');
INSERT INTO `schedule_job_log` VALUES (172, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 13:30:00');
INSERT INTO `schedule_job_log` VALUES (173, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 14:00:00');
INSERT INTO `schedule_job_log` VALUES (174, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-13 14:30:00');
INSERT INTO `schedule_job_log` VALUES (175, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 15:30:00');
INSERT INTO `schedule_job_log` VALUES (176, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 21:30:00');
INSERT INTO `schedule_job_log` VALUES (177, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-13 22:00:00');
INSERT INTO `schedule_job_log` VALUES (178, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-13 22:30:00');
INSERT INTO `schedule_job_log` VALUES (179, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-13 23:00:00');
INSERT INTO `schedule_job_log` VALUES (180, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-13 23:30:00');
INSERT INTO `schedule_job_log` VALUES (181, 1, 'testTask', 'renren', 0, NULL, 75, '2021-09-14 00:00:00');
INSERT INTO `schedule_job_log` VALUES (182, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-14 08:30:00');
INSERT INTO `schedule_job_log` VALUES (183, 1, 'testTask', 'renren', 0, NULL, 8, '2021-09-14 09:00:00');
INSERT INTO `schedule_job_log` VALUES (184, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-14 09:30:00');
INSERT INTO `schedule_job_log` VALUES (185, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-14 10:00:00');
INSERT INTO `schedule_job_log` VALUES (186, 1, 'testTask', 'renren', 0, NULL, 3, '2021-09-14 10:30:00');
INSERT INTO `schedule_job_log` VALUES (187, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 11:00:00');
INSERT INTO `schedule_job_log` VALUES (188, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 15:30:00');
INSERT INTO `schedule_job_log` VALUES (189, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-14 16:00:00');
INSERT INTO `schedule_job_log` VALUES (190, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 16:30:00');
INSERT INTO `schedule_job_log` VALUES (191, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-14 17:00:00');
INSERT INTO `schedule_job_log` VALUES (192, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 17:30:00');
INSERT INTO `schedule_job_log` VALUES (193, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 18:00:00');
INSERT INTO `schedule_job_log` VALUES (194, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 18:30:00');
INSERT INTO `schedule_job_log` VALUES (195, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 19:00:00');
INSERT INTO `schedule_job_log` VALUES (196, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-14 19:30:00');
INSERT INTO `schedule_job_log` VALUES (197, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-14 20:00:00');
INSERT INTO `schedule_job_log` VALUES (198, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 20:30:00');
INSERT INTO `schedule_job_log` VALUES (199, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-14 21:00:00');
INSERT INTO `schedule_job_log` VALUES (200, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-14 21:30:00');
INSERT INTO `schedule_job_log` VALUES (201, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 22:00:00');
INSERT INTO `schedule_job_log` VALUES (202, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 22:30:00');
INSERT INTO `schedule_job_log` VALUES (203, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-14 23:00:00');
INSERT INTO `schedule_job_log` VALUES (204, 1, 'testTask', 'renren', 0, NULL, 3, '2021-09-14 23:30:00');
INSERT INTO `schedule_job_log` VALUES (205, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-15 08:00:00');
INSERT INTO `schedule_job_log` VALUES (206, 1, 'testTask', 'renren', 0, NULL, 4, '2021-09-15 08:30:00');
INSERT INTO `schedule_job_log` VALUES (207, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-15 09:00:00');
INSERT INTO `schedule_job_log` VALUES (208, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-15 09:30:00');
INSERT INTO `schedule_job_log` VALUES (209, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-15 10:00:00');
INSERT INTO `schedule_job_log` VALUES (210, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-15 10:30:00');
INSERT INTO `schedule_job_log` VALUES (211, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-15 11:00:00');
INSERT INTO `schedule_job_log` VALUES (212, 1, 'testTask', 'renren', 0, NULL, 6, '2021-09-15 21:00:00');
INSERT INTO `schedule_job_log` VALUES (213, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-15 21:30:00');
INSERT INTO `schedule_job_log` VALUES (214, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-15 22:00:00');
INSERT INTO `schedule_job_log` VALUES (215, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-15 22:30:00');
INSERT INTO `schedule_job_log` VALUES (216, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-16 08:30:00');
INSERT INTO `schedule_job_log` VALUES (217, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 09:00:00');
INSERT INTO `schedule_job_log` VALUES (218, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 09:30:00');
INSERT INTO `schedule_job_log` VALUES (219, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 10:00:00');
INSERT INTO `schedule_job_log` VALUES (220, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 10:30:00');
INSERT INTO `schedule_job_log` VALUES (221, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 11:00:00');
INSERT INTO `schedule_job_log` VALUES (222, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 11:30:00');
INSERT INTO `schedule_job_log` VALUES (223, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 12:00:00');
INSERT INTO `schedule_job_log` VALUES (224, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 12:30:00');
INSERT INTO `schedule_job_log` VALUES (225, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-16 13:00:00');
INSERT INTO `schedule_job_log` VALUES (226, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 13:30:00');
INSERT INTO `schedule_job_log` VALUES (227, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 14:00:00');
INSERT INTO `schedule_job_log` VALUES (228, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 14:30:00');
INSERT INTO `schedule_job_log` VALUES (229, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-16 15:00:00');
INSERT INTO `schedule_job_log` VALUES (230, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 15:30:00');
INSERT INTO `schedule_job_log` VALUES (231, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 16:00:00');
INSERT INTO `schedule_job_log` VALUES (232, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 16:30:00');
INSERT INTO `schedule_job_log` VALUES (233, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 17:00:00');
INSERT INTO `schedule_job_log` VALUES (234, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 17:30:00');
INSERT INTO `schedule_job_log` VALUES (235, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 18:00:00');
INSERT INTO `schedule_job_log` VALUES (236, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 18:30:00');
INSERT INTO `schedule_job_log` VALUES (237, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 19:00:00');
INSERT INTO `schedule_job_log` VALUES (238, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 19:30:00');
INSERT INTO `schedule_job_log` VALUES (239, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 20:00:00');
INSERT INTO `schedule_job_log` VALUES (240, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 20:30:00');
INSERT INTO `schedule_job_log` VALUES (241, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 21:00:00');
INSERT INTO `schedule_job_log` VALUES (242, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-16 21:30:00');
INSERT INTO `schedule_job_log` VALUES (243, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 22:00:00');
INSERT INTO `schedule_job_log` VALUES (244, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 22:30:00');
INSERT INTO `schedule_job_log` VALUES (245, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 23:00:00');
INSERT INTO `schedule_job_log` VALUES (246, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-16 23:30:00');
INSERT INTO `schedule_job_log` VALUES (247, 1, 'testTask', 'renren', 0, NULL, 58, '2021-09-17 00:00:00');
INSERT INTO `schedule_job_log` VALUES (248, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-17 07:30:00');
INSERT INTO `schedule_job_log` VALUES (249, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 08:00:00');
INSERT INTO `schedule_job_log` VALUES (250, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 08:30:00');
INSERT INTO `schedule_job_log` VALUES (251, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 09:00:00');
INSERT INTO `schedule_job_log` VALUES (252, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-17 11:00:00');
INSERT INTO `schedule_job_log` VALUES (253, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-17 13:00:00');
INSERT INTO `schedule_job_log` VALUES (254, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-17 13:30:00');
INSERT INTO `schedule_job_log` VALUES (255, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-17 14:00:00');
INSERT INTO `schedule_job_log` VALUES (256, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 14:30:00');
INSERT INTO `schedule_job_log` VALUES (257, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 15:00:00');
INSERT INTO `schedule_job_log` VALUES (258, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-17 15:30:00');
INSERT INTO `schedule_job_log` VALUES (259, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-17 16:00:00');
INSERT INTO `schedule_job_log` VALUES (260, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 16:30:00');
INSERT INTO `schedule_job_log` VALUES (261, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-17 17:00:00');
INSERT INTO `schedule_job_log` VALUES (262, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 17:30:00');
INSERT INTO `schedule_job_log` VALUES (263, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 18:00:00');
INSERT INTO `schedule_job_log` VALUES (264, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 19:30:00');
INSERT INTO `schedule_job_log` VALUES (265, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 20:00:00');
INSERT INTO `schedule_job_log` VALUES (266, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 20:30:00');
INSERT INTO `schedule_job_log` VALUES (267, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 21:00:00');
INSERT INTO `schedule_job_log` VALUES (268, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-17 21:30:00');
INSERT INTO `schedule_job_log` VALUES (269, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 22:00:00');
INSERT INTO `schedule_job_log` VALUES (270, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 22:30:00');
INSERT INTO `schedule_job_log` VALUES (271, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-17 23:00:00');
INSERT INTO `schedule_job_log` VALUES (272, 1, 'testTask', 'renren', 0, NULL, 5, '2021-09-17 23:30:00');
INSERT INTO `schedule_job_log` VALUES (273, 1, 'testTask', 'renren', 0, NULL, 10, '2021-09-18 00:00:00');
INSERT INTO `schedule_job_log` VALUES (274, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-18 00:30:00');
INSERT INTO `schedule_job_log` VALUES (275, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-18 01:00:00');
INSERT INTO `schedule_job_log` VALUES (276, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 11:00:00');
INSERT INTO `schedule_job_log` VALUES (277, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-19 11:30:00');
INSERT INTO `schedule_job_log` VALUES (278, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-19 12:00:00');
INSERT INTO `schedule_job_log` VALUES (279, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 12:30:00');
INSERT INTO `schedule_job_log` VALUES (280, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 13:00:00');
INSERT INTO `schedule_job_log` VALUES (281, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 13:30:00');
INSERT INTO `schedule_job_log` VALUES (282, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 14:00:00');
INSERT INTO `schedule_job_log` VALUES (283, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 14:30:00');
INSERT INTO `schedule_job_log` VALUES (284, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 15:00:00');
INSERT INTO `schedule_job_log` VALUES (285, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 15:30:00');
INSERT INTO `schedule_job_log` VALUES (286, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 16:00:00');
INSERT INTO `schedule_job_log` VALUES (287, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 16:30:00');
INSERT INTO `schedule_job_log` VALUES (288, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 17:00:00');
INSERT INTO `schedule_job_log` VALUES (289, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 17:30:00');
INSERT INTO `schedule_job_log` VALUES (290, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-19 18:00:00');
INSERT INTO `schedule_job_log` VALUES (291, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-19 18:30:00');
INSERT INTO `schedule_job_log` VALUES (292, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 19:00:00');
INSERT INTO `schedule_job_log` VALUES (293, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-19 19:30:00');
INSERT INTO `schedule_job_log` VALUES (294, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 20:00:00');
INSERT INTO `schedule_job_log` VALUES (295, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-19 20:30:00');
INSERT INTO `schedule_job_log` VALUES (296, 1, 'testTask', 'renren', 0, NULL, 3, '2021-09-19 21:00:00');
INSERT INTO `schedule_job_log` VALUES (297, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 21:30:00');
INSERT INTO `schedule_job_log` VALUES (298, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 22:00:00');
INSERT INTO `schedule_job_log` VALUES (299, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 22:30:00');
INSERT INTO `schedule_job_log` VALUES (300, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-19 23:00:00');
INSERT INTO `schedule_job_log` VALUES (301, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-19 23:30:00');
INSERT INTO `schedule_job_log` VALUES (302, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 09:00:00');
INSERT INTO `schedule_job_log` VALUES (303, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-20 09:30:00');
INSERT INTO `schedule_job_log` VALUES (304, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 10:00:00');
INSERT INTO `schedule_job_log` VALUES (305, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 16:30:00');
INSERT INTO `schedule_job_log` VALUES (306, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-20 17:00:00');
INSERT INTO `schedule_job_log` VALUES (307, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 17:30:00');
INSERT INTO `schedule_job_log` VALUES (308, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 18:00:00');
INSERT INTO `schedule_job_log` VALUES (309, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 18:30:00');
INSERT INTO `schedule_job_log` VALUES (310, 1, 'testTask', 'renren', 0, NULL, 3, '2021-09-20 19:00:00');
INSERT INTO `schedule_job_log` VALUES (311, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 19:30:00');
INSERT INTO `schedule_job_log` VALUES (312, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 20:00:00');
INSERT INTO `schedule_job_log` VALUES (313, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 20:30:00');
INSERT INTO `schedule_job_log` VALUES (314, 1, 'testTask', 'renren', 0, NULL, 10, '2021-09-20 21:00:00');
INSERT INTO `schedule_job_log` VALUES (315, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 21:30:00');
INSERT INTO `schedule_job_log` VALUES (316, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-20 22:00:00');
INSERT INTO `schedule_job_log` VALUES (317, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-20 22:30:00');
INSERT INTO `schedule_job_log` VALUES (318, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-20 23:00:00');
INSERT INTO `schedule_job_log` VALUES (319, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-20 23:30:00');
INSERT INTO `schedule_job_log` VALUES (320, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-21 11:30:00');
INSERT INTO `schedule_job_log` VALUES (321, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-21 12:00:00');
INSERT INTO `schedule_job_log` VALUES (322, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 12:30:00');
INSERT INTO `schedule_job_log` VALUES (323, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-21 13:00:00');
INSERT INTO `schedule_job_log` VALUES (324, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 13:30:00');
INSERT INTO `schedule_job_log` VALUES (325, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 14:00:00');
INSERT INTO `schedule_job_log` VALUES (326, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 14:30:00');
INSERT INTO `schedule_job_log` VALUES (327, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 15:00:00');
INSERT INTO `schedule_job_log` VALUES (328, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-21 15:30:00');
INSERT INTO `schedule_job_log` VALUES (329, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 16:00:00');
INSERT INTO `schedule_job_log` VALUES (330, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 16:30:00');
INSERT INTO `schedule_job_log` VALUES (331, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 17:00:00');
INSERT INTO `schedule_job_log` VALUES (332, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-21 17:30:00');
INSERT INTO `schedule_job_log` VALUES (333, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 18:00:00');
INSERT INTO `schedule_job_log` VALUES (334, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 18:30:00');
INSERT INTO `schedule_job_log` VALUES (335, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 19:00:00');
INSERT INTO `schedule_job_log` VALUES (336, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 19:30:00');
INSERT INTO `schedule_job_log` VALUES (337, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-21 20:00:00');
INSERT INTO `schedule_job_log` VALUES (338, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 20:30:00');
INSERT INTO `schedule_job_log` VALUES (339, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 21:00:00');
INSERT INTO `schedule_job_log` VALUES (340, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 21:30:00');
INSERT INTO `schedule_job_log` VALUES (341, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 22:00:00');
INSERT INTO `schedule_job_log` VALUES (342, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-21 22:30:00');
INSERT INTO `schedule_job_log` VALUES (343, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-21 23:00:00');
INSERT INTO `schedule_job_log` VALUES (344, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-21 23:30:00');
INSERT INTO `schedule_job_log` VALUES (345, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 08:00:00');
INSERT INTO `schedule_job_log` VALUES (346, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 08:30:00');
INSERT INTO `schedule_job_log` VALUES (347, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-22 09:00:00');
INSERT INTO `schedule_job_log` VALUES (348, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-22 09:30:00');
INSERT INTO `schedule_job_log` VALUES (349, 1, 'testTask', 'renren', 0, NULL, 3, '2021-09-22 10:00:00');
INSERT INTO `schedule_job_log` VALUES (350, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 10:30:00');
INSERT INTO `schedule_job_log` VALUES (351, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 11:00:00');
INSERT INTO `schedule_job_log` VALUES (352, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 11:30:00');
INSERT INTO `schedule_job_log` VALUES (353, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 12:00:00');
INSERT INTO `schedule_job_log` VALUES (354, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 12:30:00');
INSERT INTO `schedule_job_log` VALUES (355, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 13:00:00');
INSERT INTO `schedule_job_log` VALUES (356, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 13:30:00');
INSERT INTO `schedule_job_log` VALUES (357, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 14:00:00');
INSERT INTO `schedule_job_log` VALUES (358, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 14:30:00');
INSERT INTO `schedule_job_log` VALUES (359, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 15:00:00');
INSERT INTO `schedule_job_log` VALUES (360, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 15:30:00');
INSERT INTO `schedule_job_log` VALUES (361, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 16:00:00');
INSERT INTO `schedule_job_log` VALUES (362, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-22 16:30:00');
INSERT INTO `schedule_job_log` VALUES (363, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 17:00:00');
INSERT INTO `schedule_job_log` VALUES (364, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 17:30:00');
INSERT INTO `schedule_job_log` VALUES (365, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-22 18:00:00');
INSERT INTO `schedule_job_log` VALUES (366, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 18:30:00');
INSERT INTO `schedule_job_log` VALUES (367, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 19:00:00');
INSERT INTO `schedule_job_log` VALUES (368, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 19:30:00');
INSERT INTO `schedule_job_log` VALUES (369, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 20:00:00');
INSERT INTO `schedule_job_log` VALUES (370, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 20:30:00');
INSERT INTO `schedule_job_log` VALUES (371, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 21:00:00');
INSERT INTO `schedule_job_log` VALUES (372, 1, 'testTask', 'renren', 0, NULL, 3, '2021-09-22 21:30:00');
INSERT INTO `schedule_job_log` VALUES (373, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-22 22:00:00');
INSERT INTO `schedule_job_log` VALUES (374, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-22 22:30:00');
INSERT INTO `schedule_job_log` VALUES (375, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-22 23:00:00');
INSERT INTO `schedule_job_log` VALUES (376, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-22 23:30:00');
INSERT INTO `schedule_job_log` VALUES (377, 1, 'testTask', 'renren', 0, NULL, 82, '2021-09-23 00:00:00');
INSERT INTO `schedule_job_log` VALUES (378, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-23 00:30:00');
INSERT INTO `schedule_job_log` VALUES (379, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 10:00:00');
INSERT INTO `schedule_job_log` VALUES (380, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 10:30:00');
INSERT INTO `schedule_job_log` VALUES (381, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 11:00:00');
INSERT INTO `schedule_job_log` VALUES (382, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-23 11:30:00');
INSERT INTO `schedule_job_log` VALUES (383, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 12:00:00');
INSERT INTO `schedule_job_log` VALUES (384, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 12:30:00');
INSERT INTO `schedule_job_log` VALUES (385, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-23 13:00:00');
INSERT INTO `schedule_job_log` VALUES (386, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-23 13:30:00');
INSERT INTO `schedule_job_log` VALUES (387, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 14:30:00');
INSERT INTO `schedule_job_log` VALUES (388, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 15:00:00');
INSERT INTO `schedule_job_log` VALUES (389, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 15:30:00');
INSERT INTO `schedule_job_log` VALUES (390, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 16:00:00');
INSERT INTO `schedule_job_log` VALUES (391, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 16:30:00');
INSERT INTO `schedule_job_log` VALUES (392, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-23 17:00:00');
INSERT INTO `schedule_job_log` VALUES (393, 1, 'testTask', 'renren', 0, NULL, 5, '2021-09-23 17:30:00');
INSERT INTO `schedule_job_log` VALUES (394, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 18:00:00');
INSERT INTO `schedule_job_log` VALUES (395, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-23 18:30:00');
INSERT INTO `schedule_job_log` VALUES (396, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 19:00:00');
INSERT INTO `schedule_job_log` VALUES (397, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-23 19:30:00');
INSERT INTO `schedule_job_log` VALUES (398, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-23 20:00:00');
INSERT INTO `schedule_job_log` VALUES (399, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 20:30:00');
INSERT INTO `schedule_job_log` VALUES (400, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 21:00:00');
INSERT INTO `schedule_job_log` VALUES (401, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-23 21:30:00');
INSERT INTO `schedule_job_log` VALUES (402, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 22:00:00');
INSERT INTO `schedule_job_log` VALUES (403, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 22:30:00');
INSERT INTO `schedule_job_log` VALUES (404, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 23:00:00');
INSERT INTO `schedule_job_log` VALUES (405, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-23 23:30:00');
INSERT INTO `schedule_job_log` VALUES (406, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-24 09:00:00');
INSERT INTO `schedule_job_log` VALUES (407, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-25 11:30:00');
INSERT INTO `schedule_job_log` VALUES (408, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-25 12:00:00');
INSERT INTO `schedule_job_log` VALUES (409, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 12:30:00');
INSERT INTO `schedule_job_log` VALUES (410, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 13:00:00');
INSERT INTO `schedule_job_log` VALUES (411, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 13:30:00');
INSERT INTO `schedule_job_log` VALUES (412, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 14:00:00');
INSERT INTO `schedule_job_log` VALUES (413, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 14:30:00');
INSERT INTO `schedule_job_log` VALUES (414, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 15:00:00');
INSERT INTO `schedule_job_log` VALUES (415, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-25 17:00:00');
INSERT INTO `schedule_job_log` VALUES (416, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 17:30:00');
INSERT INTO `schedule_job_log` VALUES (417, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 18:00:00');
INSERT INTO `schedule_job_log` VALUES (418, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-25 18:30:00');
INSERT INTO `schedule_job_log` VALUES (419, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 19:00:00');
INSERT INTO `schedule_job_log` VALUES (420, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-25 19:30:00');
INSERT INTO `schedule_job_log` VALUES (421, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 20:00:00');
INSERT INTO `schedule_job_log` VALUES (422, 1, 'testTask', 'renren', 0, NULL, 2, '2021-09-25 20:30:00');
INSERT INTO `schedule_job_log` VALUES (423, 1, 'testTask', 'renren', 0, NULL, 3, '2021-09-25 21:00:00');
INSERT INTO `schedule_job_log` VALUES (424, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-25 21:30:00');
INSERT INTO `schedule_job_log` VALUES (425, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 22:00:00');
INSERT INTO `schedule_job_log` VALUES (426, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-25 22:30:00');
INSERT INTO `schedule_job_log` VALUES (427, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-25 23:00:00');
INSERT INTO `schedule_job_log` VALUES (428, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-25 23:30:00');
INSERT INTO `schedule_job_log` VALUES (429, 1, 'testTask', 'renren', 0, NULL, 9, '2021-09-26 00:00:00');
INSERT INTO `schedule_job_log` VALUES (430, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-27 23:30:00');
INSERT INTO `schedule_job_log` VALUES (431, 1, 'testTask', 'renren', 0, NULL, 11, '2021-09-28 00:00:00');
INSERT INTO `schedule_job_log` VALUES (432, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-28 11:00:00');
INSERT INTO `schedule_job_log` VALUES (433, 1, 'testTask', 'renren', 0, NULL, 1, '2021-09-28 11:30:00');
INSERT INTO `schedule_job_log` VALUES (434, 1, 'testTask', 'renren', 0, NULL, 0, '2021-09-28 12:00:00');
INSERT INTO `schedule_job_log` VALUES (435, 1, 'testTask', 'renren', 0, NULL, 1, '2021-10-04 15:00:00');
INSERT INTO `schedule_job_log` VALUES (436, 1, 'testTask', 'renren', 0, NULL, 2, '2021-10-04 15:30:00');
INSERT INTO `schedule_job_log` VALUES (437, 1, 'testTask', 'renren', 0, NULL, 2, '2021-10-04 16:00:00');
INSERT INTO `schedule_job_log` VALUES (438, 1, 'testTask', 'renren', 0, NULL, 0, '2021-10-04 16:30:00');
INSERT INTO `schedule_job_log` VALUES (439, 1, 'testTask', 'renren', 0, NULL, 3, '2021-10-04 17:00:00');
INSERT INTO `schedule_job_log` VALUES (440, 1, 'testTask', 'renren', 0, NULL, 0, '2021-10-04 17:30:00');
INSERT INTO `schedule_job_log` VALUES (441, 1, 'testTask', 'renren', 0, NULL, 1, '2021-10-04 18:00:00');
INSERT INTO `schedule_job_log` VALUES (442, 1, 'testTask', 'renren', 0, NULL, 1, '2021-10-04 18:30:00');
INSERT INTO `schedule_job_log` VALUES (443, 1, 'testTask', 'renren', 0, NULL, 0, '2021-10-04 19:00:00');
INSERT INTO `schedule_job_log` VALUES (444, 1, 'testTask', 'renren', 0, NULL, 0, '2021-10-16 17:00:00');
INSERT INTO `schedule_job_log` VALUES (445, 1, 'testTask', 'renren', 0, NULL, 1, '2021-10-16 17:30:00');
INSERT INTO `schedule_job_log` VALUES (446, 1, 'testTask', 'renren', 0, NULL, 1, '2021-10-16 18:30:00');
INSERT INTO `schedule_job_log` VALUES (447, 1, 'testTask', 'renren', 0, NULL, 1, '2021-10-17 17:30:00');
INSERT INTO `schedule_job_log` VALUES (448, 1, 'testTask', 'renren', 0, NULL, 0, '2021-10-17 18:00:00');
INSERT INTO `schedule_job_log` VALUES (449, 1, 'testTask', 'renren', 0, NULL, 1, '2021-10-24 17:00:00');
INSERT INTO `schedule_job_log` VALUES (450, 1, 'testTask', 'renren', 0, NULL, 1, '2021-11-02 09:00:00');
INSERT INTO `schedule_job_log` VALUES (451, 1, 'testTask', 'renren', 0, NULL, 0, '2021-11-06 00:30:00');

-- ----------------------------
-- Table structure for sys_captcha
-- ----------------------------
DROP TABLE IF EXISTS `sys_captcha`;
CREATE TABLE `sys_captcha`  (
  `uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'uuid',
  `code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '验证码',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统验证码' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_captcha
-- ----------------------------
INSERT INTO `sys_captcha` VALUES ('020c4038-5fd2-446d-80b4-92a4d81931c5', '7ac76', '2021-09-06 16:53:31');
INSERT INTO `sys_captcha` VALUES ('106429ba-e489-4da4-8392-708b33abb445', '63n5p', '2021-09-09 13:02:03');
INSERT INTO `sys_captcha` VALUES ('11f870ee-92a2-4ac2-89ce-4cbd36a8a7f8', '26gxb', '2021-09-04 21:53:30');
INSERT INTO `sys_captcha` VALUES ('17dfcd3d-0a5a-4621-8bce-57ec5bb440da', 'n75bb', '2021-09-14 09:26:38');
INSERT INTO `sys_captcha` VALUES ('2fb73f3d-bb2f-4cfa-8cd2-96f42d82b203', 'ffn4y', '2021-09-09 13:01:20');
INSERT INTO `sys_captcha` VALUES ('3759da7e-46dd-47d6-83f4-37f9be02ccb5', '2a7eb', '2021-09-14 09:35:45');
INSERT INTO `sys_captcha` VALUES ('4779c108-7cb1-4536-864c-300fc3f97028', '2g4en', '2021-09-14 09:36:44');
INSERT INTO `sys_captcha` VALUES ('4cd05267-218a-4d47-8355-0c0bb5862fd7', 'nw3pf', '2021-09-14 09:56:18');
INSERT INTO `sys_captcha` VALUES ('4fd331d1-d1a0-405e-87da-0ed270c9b73e', 'cncby', '2021-09-14 09:27:00');
INSERT INTO `sys_captcha` VALUES ('50f90185-f4c4-4de0-8777-9ac014f3e3d3', '2w2mc', '2021-09-14 09:22:46');
INSERT INTO `sys_captcha` VALUES ('697a6edb-27e5-47e7-8b28-25bea37771ca', '5y54g', '2021-09-14 09:28:40');
INSERT INTO `sys_captcha` VALUES ('79fa9633-561c-4b00-8d1c-00f378a8cf7f', 'wacep', '2021-10-04 15:08:21');
INSERT INTO `sys_captcha` VALUES ('9069b0c0-949f-4bf1-8dc7-7f25ae507cca', 'mc6ee', '2021-09-14 09:22:36');
INSERT INTO `sys_captcha` VALUES ('9343992e-0fbf-477d-8945-d6f1b40b5f47', 'pwg28', '2021-09-15 10:44:28');
INSERT INTO `sys_captcha` VALUES ('99b45103-abb3-4e87-8c10-5a303e6da883', 'fp72n', '2021-09-17 08:42:52');
INSERT INTO `sys_captcha` VALUES ('a00b6d5e-44a5-440f-89c8-1d8c6450ca50', '7n2pp', '2021-09-14 09:59:46');
INSERT INTO `sys_captcha` VALUES ('a2067abd-b4af-424d-81ea-36e4c1d88ad1', 'f5fy2', '2021-09-14 09:25:31');
INSERT INTO `sys_captcha` VALUES ('a4d606e2-f90b-4430-818c-88cfe1957999', 'mfw82', '2021-09-14 09:36:26');
INSERT INTO `sys_captcha` VALUES ('b4a75769-0317-46e6-8779-ef5ba9a61ff5', 'xyf3y', '2021-09-14 09:31:12');
INSERT INTO `sys_captcha` VALUES ('befb8713-eed2-4fc0-8091-d9d1a77767d3', '774mm', '2021-09-06 21:36:45');
INSERT INTO `sys_captcha` VALUES ('c1c1a1b2-791a-46a9-8b11-3c99282f7154', '8x6cf', '2021-09-14 09:23:03');
INSERT INTO `sys_captcha` VALUES ('c1d97dbd-a8fc-4c60-894b-c4ca107ae050', 'ebnx3', '2021-09-04 13:51:41');
INSERT INTO `sys_captcha` VALUES ('c4f5b60a-c1f5-4048-861e-0acdc1c5f20a', 'y6bd5', '2021-09-14 09:28:06');
INSERT INTO `sys_captcha` VALUES ('c572ad74-bba5-48f3-8a55-afe7905ccc9b', 'm3m5f', '2021-10-04 14:58:42');
INSERT INTO `sys_captcha` VALUES ('cfc061c8-3a01-4f33-8371-4cf472192fdc', 'wyx2d', '2021-09-14 09:22:36');
INSERT INTO `sys_captcha` VALUES ('d55cd0c7-ac64-4f6a-8a88-780da80edd35', 'b3ce4', '2021-09-14 09:33:15');
INSERT INTO `sys_captcha` VALUES ('dd407ad2-0ca6-4f70-8046-90d2d34c11a5', 'ye3ym', '2021-09-14 09:33:59');
INSERT INTO `sys_captcha` VALUES ('ecb2509b-a783-43c7-8ae9-32f3491498f8', 'xn6nc', '2021-09-14 09:56:03');
INSERT INTO `sys_captcha` VALUES ('edbe07be-7680-4cde-85ee-f20ed8c3c283', '8em68', '2021-09-14 09:32:00');
INSERT INTO `sys_captcha` VALUES ('f131e81d-4d07-4632-8790-6d042c847138', 'fncnn', '2021-09-14 09:23:20');
INSERT INTO `sys_captcha` VALUES ('ff6889de-22c8-4b68-8ef2-24d1b8e40cd7', 'a5y7e', '2021-09-14 09:56:17');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `param_key`(`param_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'CLOUD_STORAGE_CONFIG_KEY', '{\"type\":1,\"qiniuDomain\":\"http://qz7kpat7t.hn-bkt.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuAccessKey\":\"RvUTkM8iQQ6tqmWG2V6bfZ4KX--P_PFBp8isoMSI\",\"qiniuSecretKey\":\"nvJQ59dhXcU4nIuTslSBFZePT4oojydr4CMX3hvU\",\"qiniuBucketName\":\"loafblog-picture\",\"aliyunDomain\":\"\",\"aliyunPrefix\":\"\",\"aliyunEndPoint\":\"\",\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qcloudBucketName\":\"\"}', 0, '云存储配置信息');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, 'admin', '修改用户', 'io.renren.modules.sys.controller.SysUserController.update()', '[{\"userId\":1,\"username\":\"admin\",\"password\":\"9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d\",\"salt\":\"YzcmCZNvbXocrsz9dm8e\",\"email\":\"wqs@loafblog.io\",\"mobile\":\"13612345678\",\"status\":1,\"roleIdList\":[],\"createUserId\":1}]', 109, '0:0:0:0:0:0:0:1', '2021-09-04 13:47:44');
INSERT INTO `sys_log` VALUES (2, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":31,\"parentId\":0,\"name\":\"博客管理\",\"type\":0,\"icon\":\"bianji\",\"orderNum\":0}]', 7, '0:0:0:0:0:0:0:1', '2021-09-05 10:01:16');
INSERT INTO `sys_log` VALUES (3, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":32,\"parentId\":31,\"name\":\"博客管理\",\"url\":\"blog/article\",\"perms\":\"\",\"type\":1,\"icon\":\"editor\",\"orderNum\":1}]', 7, '0:0:0:0:0:0:0:1', '2021-09-05 10:03:04');
INSERT INTO `sys_log` VALUES (4, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":33,\"parentId\":31,\"name\":\"分类管理\",\"url\":\"blog/category\",\"perms\":\"\",\"type\":1,\"icon\":\"menu\",\"orderNum\":1}]', 7, '0:0:0:0:0:0:0:1', '2021-09-05 10:06:37');
INSERT INTO `sys_log` VALUES (5, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":34,\"parentId\":31,\"name\":\"标签管理\",\"url\":\"blog/tags\",\"perms\":\"\",\"type\":1,\"icon\":\"shoucang\",\"orderNum\":1}]', 6, '0:0:0:0:0:0:0:1', '2021-09-05 10:07:29');
INSERT INTO `sys_log` VALUES (6, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":35,\"parentId\":0,\"name\":\"图片管理\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"picture\",\"orderNum\":0}]', 10, '0:0:0:0:0:0:0:1', '2021-09-13 09:39:38');
INSERT INTO `sys_log` VALUES (7, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":35,\"parentId\":0,\"name\":\"图片管理\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"picture\",\"orderNum\":0}]', 9, '0:0:0:0:0:0:0:1', '2021-09-13 09:43:14');
INSERT INTO `sys_log` VALUES (8, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":36,\"parentId\":35,\"name\":\"图片管理\",\"url\":\"/picture/picture\",\"perms\":\"\",\"type\":1,\"icon\":\"pictureGroup\",\"orderNum\":1}]', 17, '0:0:0:0:0:0:0:1', '2021-09-13 09:48:02');
INSERT INTO `sys_log` VALUES (9, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":36,\"parentId\":35,\"name\":\"图片管理\",\"url\":\"/picture/picture\",\"perms\":\"\",\"type\":1,\"icon\":\"picture\",\"orderNum\":1}]', 8, '0:0:0:0:0:0:0:1', '2021-09-13 09:50:00');
INSERT INTO `sys_log` VALUES (10, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":37,\"parentId\":35,\"name\":\"私人存储\",\"url\":\"picture/privateFolder\",\"perms\":\"\",\"type\":1,\"icon\":\"role\",\"orderNum\":1}]', 13, '0:0:0:0:0:0:0:1', '2021-09-13 22:34:45');
INSERT INTO `sys_log` VALUES (11, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":38,\"parentId\":0,\"name\":\"信息设置\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"xiangqufill\",\"orderNum\":0}]', 9, '0:0:0:0:0:0:0:1', '2021-09-16 18:49:35');
INSERT INTO `sys_log` VALUES (12, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":39,\"parentId\":38,\"name\":\"友链设置\",\"url\":\"set/websiteinfo\",\"perms\":\"\",\"type\":1,\"icon\":\"geren\",\"orderNum\":1}]', 8, '0:0:0:0:0:0:0:1', '2021-09-16 18:51:01');
INSERT INTO `sys_log` VALUES (13, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":40,\"parentId\":38,\"name\":\"消息收集\",\"url\":\"set/message\",\"perms\":\"\",\"type\":1,\"icon\":\"pinglun\",\"orderNum\":1}]', 14, '0:0:0:0:0:0:0:1', '2021-09-16 20:42:33');
INSERT INTO `sys_log` VALUES (14, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":40,\"parentId\":38,\"name\":\"消息收集\",\"url\":\"set/info\",\"perms\":\"\",\"type\":1,\"icon\":\"pinglun\",\"orderNum\":1}]', 19, '0:0:0:0:0:0:0:1', '2021-09-16 20:43:03');
INSERT INTO `sys_log` VALUES (15, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":41,\"parentId\":0,\"name\":\"应用监控\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"monitor\",\"orderNum\":0}]', 10, '0:0:0:0:0:0:0:1', '2021-10-04 15:37:05');
INSERT INTO `sys_log` VALUES (16, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":42,\"parentId\":41,\"name\":\"Nacos\",\"url\":\"http://8.129.122.160:8848/nacos/\",\"perms\":\"\",\"type\":1,\"icon\":\"job\",\"orderNum\":1}]', 10, '0:0:0:0:0:0:0:1', '2021-10-04 15:38:43');
INSERT INTO `sys_log` VALUES (17, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":42,\"parentId\":41,\"name\":\"Nacos\",\"url\":\"http://8.129.122.160:8848/nacos/\",\"perms\":\"\",\"type\":1,\"icon\":\"job\",\"orderNum\":5}]', 12, '0:0:0:0:0:0:0:1', '2021-10-04 15:39:55');
INSERT INTO `sys_log` VALUES (18, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":42,\"parentId\":41,\"name\":\"Nacos\",\"url\":\"monitor/nacos\",\"perms\":\"\",\"type\":1,\"icon\":\"job\",\"orderNum\":5}]', 9, '0:0:0:0:0:0:0:1', '2021-10-04 16:03:51');
INSERT INTO `sys_log` VALUES (19, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":42,\"parentId\":41,\"name\":\"Nacos\",\"url\":\"monitor/nacos\",\"perms\":\"\",\"type\":1,\"icon\":\"job\",\"orderNum\":1}]', 19, '0:0:0:0:0:0:0:1', '2021-10-04 16:03:58');
INSERT INTO `sys_log` VALUES (20, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":43,\"parentId\":41,\"name\":\"RabbitMQ\",\"url\":\"monitor/rabbitmq\",\"perms\":\"\",\"type\":1,\"icon\":\"\",\"orderNum\":1}]', 8, '0:0:0:0:0:0:0:1', '2021-10-04 16:53:41');
INSERT INTO `sys_log` VALUES (21, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":44,\"parentId\":41,\"name\":\"Kibana\",\"url\":\"monitor/kibana\",\"perms\":\"\",\"type\":1,\"icon\":\"\",\"orderNum\":1}]', 8, '0:0:0:0:0:0:0:1', '2021-10-04 17:24:13');
INSERT INTO `sys_log` VALUES (22, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":42,\"parentId\":41,\"name\":\"Nacos\",\"url\":\"monitor/nacos\",\"perms\":\"\",\"type\":1,\"icon\":\"nacos\",\"orderNum\":1}]', 7, '0:0:0:0:0:0:0:1', '2021-10-04 17:49:51');
INSERT INTO `sys_log` VALUES (23, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":42,\"parentId\":41,\"name\":\"Nacos\",\"url\":\"monitor/nacos\",\"perms\":\"\",\"type\":1,\"icon\":\"nacos\",\"orderNum\":1}]', 6, '0:0:0:0:0:0:0:1', '2021-10-04 17:52:34');
INSERT INTO `sys_log` VALUES (24, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":43,\"parentId\":41,\"name\":\"RabbitMQ\",\"url\":\"monitor/rabbitmq\",\"perms\":\"\",\"type\":1,\"icon\":\"rabbitmq\",\"orderNum\":1}]', 7, '0:0:0:0:0:0:0:1', '2021-10-04 17:52:44');
INSERT INTO `sys_log` VALUES (25, 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":44,\"parentId\":41,\"name\":\"Kibana\",\"url\":\"monitor/kibana\",\"perms\":\"\",\"type\":1,\"icon\":\"kibana\",\"orderNum\":1}]', 8, '0:0:0:0:0:0:0:1', '2021-10-04 17:52:53');
INSERT INTO `sys_log` VALUES (26, 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":45,\"parentId\":1,\"name\":\"接口文档\",\"url\":\"sys/doc\",\"perms\":\"\",\"type\":1,\"icon\":\"config\",\"orderNum\":1}]', 11, '0:0:0:0:0:0:0:1', '2021-10-17 17:13:29');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', NULL, NULL, 0, 'system', 0);
INSERT INTO `sys_menu` VALUES (2, 1, '管理员列表', 'sys/user', NULL, 1, 'admin', 1);
INSERT INTO `sys_menu` VALUES (3, 1, '角色管理', 'sys/role', NULL, 1, 'role', 2);
INSERT INTO `sys_menu` VALUES (4, 1, '菜单管理', 'sys/menu', NULL, 1, 'menu', 3);
INSERT INTO `sys_menu` VALUES (5, 1, 'SQL监控', 'http://localhost:8080/renren-fast/druid/sql.html', NULL, 1, 'sql', 4);
INSERT INTO `sys_menu` VALUES (6, 1, '定时任务', 'job/schedule', NULL, 1, 'job', 5);
INSERT INTO `sys_menu` VALUES (7, 6, '查看', NULL, 'sys:schedule:list,sys:schedule:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (8, 6, '新增', NULL, 'sys:schedule:save', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (9, 6, '修改', NULL, 'sys:schedule:update', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (10, 6, '删除', NULL, 'sys:schedule:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (11, 6, '暂停', NULL, 'sys:schedule:pause', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (12, 6, '恢复', NULL, 'sys:schedule:resume', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (13, 6, '立即执行', NULL, 'sys:schedule:run', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (14, 6, '日志列表', NULL, 'sys:schedule:log', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (15, 2, '查看', NULL, 'sys:user:list,sys:user:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (16, 2, '新增', NULL, 'sys:user:save,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (17, 2, '修改', NULL, 'sys:user:update,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (18, 2, '删除', NULL, 'sys:user:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (19, 3, '查看', NULL, 'sys:role:list,sys:role:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (20, 3, '新增', NULL, 'sys:role:save,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (21, 3, '修改', NULL, 'sys:role:update,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (22, 3, '删除', NULL, 'sys:role:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (23, 4, '查看', NULL, 'sys:menu:list,sys:menu:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (24, 4, '新增', NULL, 'sys:menu:save,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (25, 4, '修改', NULL, 'sys:menu:update,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (26, 4, '删除', NULL, 'sys:menu:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (27, 1, '参数管理', 'sys/config', 'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', 1, 'config', 6);
INSERT INTO `sys_menu` VALUES (29, 1, '系统日志', 'sys/log', 'sys:log:list', 1, 'log', 7);
INSERT INTO `sys_menu` VALUES (30, 1, '文件上传', 'oss/oss', 'sys:oss:all', 1, 'oss', 6);
INSERT INTO `sys_menu` VALUES (31, 0, '博客管理', NULL, NULL, 0, 'bianji', 0);
INSERT INTO `sys_menu` VALUES (32, 31, '博客管理', 'blog/article', '', 1, 'editor', 1);
INSERT INTO `sys_menu` VALUES (33, 31, '分类管理', 'blog/category', '', 1, 'menu', 1);
INSERT INTO `sys_menu` VALUES (34, 31, '标签管理', 'blog/tags', '', 1, 'shoucang', 1);
INSERT INTO `sys_menu` VALUES (35, 0, '图片管理', '', '', 0, 'picture', 0);
INSERT INTO `sys_menu` VALUES (36, 35, '图片管理', 'picture/picture', '', 1, 'picture', 1);
INSERT INTO `sys_menu` VALUES (37, 35, '私人存储', 'picture/privateFolder', '', 1, 'role', 1);
INSERT INTO `sys_menu` VALUES (38, 0, '信息设置', '', '', 0, 'xiangqufill', 0);
INSERT INTO `sys_menu` VALUES (39, 38, '友链设置', 'set/websiteinfo', '', 1, 'geren', 1);
INSERT INTO `sys_menu` VALUES (40, 38, '消息收集', 'set/info', '', 1, 'pinglun', 1);
INSERT INTO `sys_menu` VALUES (41, 0, '应用监控', '', '', 0, 'monitor', 0);
INSERT INTO `sys_menu` VALUES (42, 41, 'Nacos', 'monitor/nacos', '', 1, 'nacos', 1);
INSERT INTO `sys_menu` VALUES (43, 41, 'RabbitMQ', 'monitor/rabbitmq', '', 1, 'rabbitmq', 1);
INSERT INTO `sys_menu` VALUES (44, 41, 'Kibana', 'monitor/kibana', '', 1, 'kibana', 1);
INSERT INTO `sys_menu` VALUES (45, 1, '接口文档', 'sys/doc', '', 1, 'config', 1);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件上传' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色与菜单对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d', 'YzcmCZNvbXocrsz9dm8e', 'wqs@loafblog.io', '13612345678', 1, 1, '2021-12-01 11:11:11');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与角色对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_token`;
CREATE TABLE `sys_user_token`  (
  `user_id` bigint(20) NOT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'token',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `token`(`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统用户Token' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_token
-- ----------------------------
INSERT INTO `sys_user_token` VALUES (1, '4d36e75aac82c847448771616df1772f', '2021-11-06 12:22:42', '2021-11-06 00:22:42');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, 'mark', '13612345678', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2017-03-23 22:37:41');

SET FOREIGN_KEY_CHECKS = 1;
