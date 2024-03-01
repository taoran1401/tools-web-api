/*
 Navicat Premium Data Transfer

 Source Server         : dockermysql-master
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : 120.78.144.133:3306
 Source Schema         : tools_web

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 01/03/2024 15:08:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置编码',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '说明',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配置值',
  `is_show` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否可见（预留字段，暂时没用到）',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `config_code_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='配置表';

-- ----------------------------
-- Records of config
-- ----------------------------
BEGIN;
INSERT INTO `config` VALUES (54, 'ip_white_list', 'ip白名单', '*', 0, '2023-08-16 11:31:44', '2023-08-16 11:31:44', NULL);
COMMIT;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '名称',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '描述',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='会员等级表';

-- ----------------------------
-- Table structure for tool
-- ----------------------------
DROP TABLE IF EXISTS `tool`;
CREATE TABLE `tool` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL COMMENT '名称',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '描述',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'logo',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '地址或组件路径',
  `cate_id` int NOT NULL COMMENT '分类id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工具表';

-- ----------------------------
-- Records of tool
-- ----------------------------
BEGIN;
INSERT INTO `tool` VALUES (1, '时间戳转换', '在线时间戳转换工具以及获取当前时间戳', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/Time.png', '/timetran', 2, '2023-11-30 11:54:44', '2023-11-30 11:54:44', NULL);
INSERT INTO `tool` VALUES (2, 'MD5在线加密', 'MD5在线加密,长度包含32位、16位', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/Password%20fishing.png', '/MD5', 2, '2023-11-30 11:54:44', '2023-11-30 11:54:44', NULL);
INSERT INTO `tool` VALUES (3, 'Json在线转换', '在线编辑json, 语法检查', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/json.png', '/json', 2, '2023-11-30 11:55:45', '2023-11-30 11:55:45', NULL);
INSERT INTO `tool` VALUES (4, '正则测试工具', '正则表达式测试工具, 常用正则表达式', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/reg.png', '/reg', 2, '2023-11-30 11:56:05', '2023-11-30 11:56:05', NULL);
INSERT INTO `tool` VALUES (5, 'Unicode转中文', 'Unicode和中文的相互转换', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/union.png', '/unicode', 2, '2023-11-30 11:56:21', '2023-11-30 11:56:21', NULL);
INSERT INTO `tool` VALUES (6, 'IP查询', '在线查询ip地址、ip归属地', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/IP.png', '/ip', 6, '2023-11-30 11:56:39', '2023-11-30 11:56:39', NULL);
INSERT INTO `tool` VALUES (7, '常用进制转换', '在线进制转换工具,可在2到64进制之间相互转换', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/%E8%BF%9B%E5%88%B6%E8%BD%AC%E6%8D%A2.png', '/scaletran', 4, '2023-11-30 11:56:55', '2023-11-30 11:56:55', NULL);
INSERT INTO `tool` VALUES (8, '在线图片处理', '在线图片裁剪，标注，滤镜，画等操作', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/img.png', '/signimage', 5, '2023-11-30 11:57:13', '2023-11-30 11:57:13', NULL);
INSERT INTO `tool` VALUES (9, '字数统计', '在线统计字符串的字数、段落、标点符号数量', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/ico_%E6%95%B0%E6%8D%AE%E7%BB%9F%E8%AE%A1_%E5%B7%A5%E4%BD%9C%E9%87%8F%E7%BB%9F%E8%AE%A1.png', '/wordCount', 3, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (10, '随机密码生成', '密码生成器、随机字符串生成,批量生成', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/keywords.png', '/random_password', 2, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (11, 'URL编码/解码', 'URL在线编码解码工具（UrlEncode编码 和 UrlDecode解码）', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/url.png', '/urlencode', 2, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (12, 'UUID生成器', '批量生成UUID', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/%E7%BA%BF%E6%80%A7-%E7%94%9F%E6%88%90.png', '/uuid', 2, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (13, '手持弹幕', '手持滚动弹幕', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/%E5%BC%B9%E5%B9%95.png', '/barrage', 7, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (14, 'ASCII码表', 'ASCII码表,控制代码、标准ASCII字符和非标准ASCII字符对照表', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/icon_%E7%BC%96%E7%A0%81%E5%AF%B9%E7%85%A7.png', '/ascii', 4, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (15, '单位换算', '在线重量、长度、面积、时间、角度、速度、温度、压力、热量、功率等换算', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/%E5%8D%95%E4%BD%8D%E6%8D%A2%E7%AE%97.png', '/unit', 4, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (16, '色板', '包含纯色、渐变与阶梯色和常用色彩组合', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/%E8%B0%83%E8%89%B2%E6%9D%BF.png', '/palettes', 5, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (17, '二维码生成', '在线生成带logo、透明、艺术的二维码', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/%E4%BA%8C%E7%BB%B4%E7%A0%81.png', '/qrcode', 5, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (18, '帮我决定', '选择困难，难以决定，今天吃什么，现在做什么，自定义选项都给你安排的明明白白', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/choose.png', '/decision', 7, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (19, '摩斯电码', '支持中文的摩斯电码编码解码', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/medium.png', '/morse', 3, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (20, '生成随机数', '可定制范围内进行随机数字，可用于抽奖、点名等用途', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/randomnum.png', '/random', 7, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (21, '数字转金额大写', '在线数字一键转换成人民币大写，中文大写转换数字', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/text%20recognition.png', '/numberToChinese', 7, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (22, '文本对比', '文本差异比对支持中文、英文、代码比对', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/diff.png', '/diff', 3, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (23, 'markdown编辑器', '在线创建或编辑markdown, 实时预览，导出markdown', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/file-markdown-fill.png', '/markdown', 3, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
INSERT INTO `tool` VALUES (24, '文本转图片', '把文本转换成图片，生成长图，具有超多个性文字排版', 'https://baseran2.oss-cn-shenzhen.aliyuncs.com/toools-web/icon/text_to_img.png', '/textToImg', 5, '2023-11-30 11:58:43', '2023-11-30 11:58:43', NULL);
COMMIT;

-- ----------------------------
-- Table structure for tool_cate
-- ----------------------------
DROP TABLE IF EXISTS `tool_cate`;
CREATE TABLE `tool_cate` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工具分类';

-- ----------------------------
-- Records of tool_cate
-- ----------------------------
BEGIN;
INSERT INTO `tool_cate` VALUES (2, '开发运维', '2023-11-30 11:53:34', '2023-11-30 11:53:34', NULL);
INSERT INTO `tool_cate` VALUES (3, '文本处理', '2023-11-30 11:53:41', '2023-11-30 11:53:41', NULL);
INSERT INTO `tool_cate` VALUES (4, '教育学术', '2023-11-30 11:53:52', '2023-11-30 11:53:52', NULL);
INSERT INTO `tool_cate` VALUES (5, '设计工具', '2023-11-30 11:53:58', '2023-11-30 11:53:58', NULL);
INSERT INTO `tool_cate` VALUES (6, '查询相关', '2023-11-30 11:54:04', '2023-11-30 11:54:04', NULL);
INSERT INTO `tool_cate` VALUES (7, '其他', '2023-11-30 11:54:04', '2023-11-30 11:54:04', NULL);
COMMIT;

-- ----------------------------
-- Table structure for tool_collect
-- ----------------------------
DROP TABLE IF EXISTS `tool_collect`;
CREATE TABLE `tool_collect` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户id',
  `tool_id` int NOT NULL COMMENT '工具id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工具表';

-- ----------------------------
-- Table structure for user_secret
-- ----------------------------
DROP TABLE IF EXISTS `user_secret`;
CREATE TABLE `user_secret` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'access key',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'secret key',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'token',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for user_token
-- ----------------------------
DROP TABLE IF EXISTS `user_token`;
CREATE TABLE `user_token` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户登录token',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `nick_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户昵称',
  `we_chat_code` varchar(255) DEFAULT NULL COMMENT '微信号',
  `sex` int unsigned DEFAULT '0' COMMENT '性别 0男1女',
  `salt` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码盐',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_online_time` datetime DEFAULT NULL COMMENT '最后在线时间',
  `city_code` varchar(11) DEFAULT '' COMMENT '城市编码，新增',
  `status` int NOT NULL DEFAULT '0' COMMENT '用户状态 0正常 1禁用',
  `integral` bigint NOT NULL DEFAULT '0' COMMENT '积分',
  `longitude` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '经度',
  `latitude` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '纬度',
  `lemonsqueezy_uid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'lemonsqueezy对应的用户id',
  `invite_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邀请码',
  `online_status` int DEFAULT NULL COMMENT '用户在线状态 0：离线 1：在线 2：忙碌',
  `other_invite_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '填入的别人的邀请码',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注,如封号等操作',
  `member_id` int NOT NULL DEFAULT '0' COMMENT '会员id',
  `member_expire_time` bigint DEFAULT NULL COMMENT '会员过期时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `channel_sex` (`sex`) USING BTREE,
  KEY `idx_sex_totalcurrency` (`sex`) USING BTREE,
  KEY `invite_code` (`invite_code`) USING BTREE,
  KEY `last_login_time_index` (`last_login_time`) USING BTREE,
  KEY `latitude_index` (`latitude`) USING BTREE,
  KEY `longtitude_index` (`longitude`) USING BTREE,
  KEY `online_status` (`online_status`) USING BTREE,
  KEY `other_invite_code` (`other_invite_code`) USING BTREE,
  KEY `phone` (`phone`) USING BTREE,
  KEY `sex` (`sex`,`status`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=54297 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户表 @wx';

SET FOREIGN_KEY_CHECKS = 1;
