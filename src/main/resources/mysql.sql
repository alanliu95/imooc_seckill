/*
Navicat MySQL Data Transfer
Source Server         : local
Source Server Version : 80014
Source Host           : localhost:3306
Source Database       : miaosha
Target Server Type    : MYSQL
Target Server Version : 80014
File Encoding         : 65001
Date: 2019-03-21 17:44:56
*/
drop database if exists miaosha;
CREATE database miaosha;
use miaosha;
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `goods_name` varchar(16) DEFAULT NULL COMMENT '名称',
  `goods_title` varchar(64) DEFAULT NULL COMMENT '标题',
  `goods_img` varchar(64) DEFAULT NULL COMMENT '图片',
  `goods_detail` longtext COMMENT '详情',
  `goods_price` decimal(10,2) DEFAULT '0.00' COMMENT '商品单价',
  `goods_stock` int(11) DEFAULT '0' COMMENT '库存,-1表示没有限制',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', 'iPhoneX', 'iPhoneX', '/img/iphonex.png', '123', '10000.00', '10');
INSERT INTO `goods` VALUES ('2', '华为mate10', 'mate10', '/img/meta10.png', '321', '4000.00', '10');
INSERT INTO `goods` VALUES ('3', '华为mate11', 'mate11', '/img/meta10.png', '321111', '4000.00', '10');

-- ----------------------------
-- Table structure for miaosha_goods
-- ----------------------------
DROP TABLE IF EXISTS `miaosha_goods`;
CREATE TABLE `miaosha_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '秒杀商品id',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `miaosha_price` decimal(10,2) DEFAULT '0.00' COMMENT '秒杀价',
  `stock_count` int(11) DEFAULT '0' COMMENT '库存,-1表示没有限制',
  `start_date` datetime DEFAULT NULL COMMENT '秒杀开始时间',
  `end_date` datetime DEFAULT NULL COMMENT '秒杀结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of miaosha_goods
-- ----------------------------
INSERT INTO `miaosha_goods` VALUES ('1', '1', '0.01', '9', '2019-03-19 07:21:55', '2019-03-22 16:52:09');
INSERT INTO `miaosha_goods` VALUES ('2', '2', '0.02', '10', '2019-03-19 02:52:22', '2019-03-31 16:52:25');
INSERT INTO `miaosha_goods` VALUES ('4', '3', '0.02', '9', '2019-03-19 02:52:22', '2019-03-31 16:52:25');

-- ----------------------------
-- Table structure for miaosha_order
-- ----------------------------
DROP TABLE IF EXISTS `miaosha_order`;
CREATE TABLE `miaosha_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_uid_gId` (`user_id`,`goods_id`) USING BTREE COMMENT '一个用户只能下一个订单'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of miaosha_order
-- ----------------------------
INSERT INTO `miaosha_order` VALUES ('1', '12000000999', '1', '3');
INSERT INTO `miaosha_order` VALUES ('2', '12000000999', '2', '1');

-- ----------------------------
-- Table structure for miaosha_user
-- ----------------------------
DROP TABLE IF EXISTS `miaosha_user`;
CREATE TABLE `miaosha_user` (
  `id` bigint(20) NOT NULL COMMENT '用户id, 手机号码',
  `nickname` varchar(255) NOT NULL COMMENT '用户昵称',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'MD5(MD5(password+salt)+salt)',
  `salt` varchar(10) DEFAULT NULL COMMENT '盐',
  `head` varchar(128) DEFAULT NULL COMMENT '头像, 云存储id',
  `redister_date` datetime DEFAULT NULL COMMENT '注册时间',
  `last_login_date` datetime DEFAULT NULL COMMENT '上次登录时间',
  `login_count` int(11) DEFAULT '0' COMMENT '总登录次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of miaosha_user
-- ----------------------------
INSERT INTO `miaosha_user` VALUES ('12000000999', 'testUser_999', '12185d442a0c1d523dc35d6655fefa6d', 'y95834zn39', 'head', '2019-03-21 02:17:41', null, '1');

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `delivery_addr_id` bigint(20) DEFAULT NULL COMMENT '收货地址',
  `goods_name` varchar(16) DEFAULT NULL COMMENT '商品名称',
  `goods_count` int(11) DEFAULT '0' COMMENT '商品数量',
  `goods_price` decimal(10,2) DEFAULT '0.00' COMMENT '商品单价',
  `order_channel` tinyint(4) DEFAULT '0' COMMENT '渠道,1-pc,2-android,3-ios',
  `status` tinyint(4) DEFAULT '0' COMMENT '订单状态,0-新建未支付,1-已支付,2-已发货,3-已收货,4-已退款,5-已完成',
  `create_date` datetime DEFAULT NULL COMMENT '创建订单时间',
  `pay_date` datetime DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Records of order_info
-- ----------------------------
INSERT INTO `order_info` VALUES ('1', '12000000999', '3', null, '华为mate11', '1', '0.02', '1', '0', '2019-03-21 06:46:22', null);
INSERT INTO `order_info` VALUES ('2', '12000000999', '1', null, 'iPhoneX', '1', '0.01', '1', '0', '2019-03-21 08:10:21', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'yzt');