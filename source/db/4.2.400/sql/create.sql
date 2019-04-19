/* Garoon DDL */

/* ########################################################################## */
/* execute the create table query first */
/* ########################################################################## */

/* GTM-526 START */
CREATE TABLE IF NOT EXISTS `tab_grn_portal_portallayout` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_portal` bigint(20) NOT NULL,
  `col_settings` text,
  PRIMARY KEY (`_id`),
  UNIQUE KEY (`col_portal`),
  CONSTRAINT `cns_grn_portal_portallayout_portal` FOREIGN KEY (`col_portal`) REFERENCES `tab_grn_portal_portal` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-526 END */

/* GTM-529 START  */
CREATE TABLE IF NOT EXISTS `tab_grn_availability_dynamic_role` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_dynamic_role` char(100) NOT NULL,
  `col_app` text,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_availability_role` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_role` bigint(20) NOT NULL,
  `col_app` text,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `cni_role` (`col_role`),
  CONSTRAINT `cns_grn_availability_role_role` FOREIGN KEY (`col_role`) REFERENCES `tab_cb_role` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_availability_groupuser` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_groupuser` bigint(20) NOT NULL,
  `col_app` text,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `cni_groupuser` (`col_groupuser`),
  CONSTRAINT `cns_grn_availability_groupuser_groupuser` FOREIGN KEY (`col_groupuser`) REFERENCES `tab_cb_group` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_availability_user` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_user` bigint(20) NOT NULL,
  `col_app` text,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `cni_user` (`col_user`),
  CONSTRAINT `cns_grn_availability_user_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/* GTM-529 END  */
/* GTM-544 START */
CREATE TABLE IF NOT EXISTS `tab_grn_mail_automatic_event` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_name` varchar(256) NOT NULL,
  `col_logic_type` ENUM('AND', 'OR'),
  `col_service_status` ENUM('ON','OFF'),
  `col_account` bigint(20),
  PRIMARY KEY (`_id`),
  UNIQUE KEY (`_id`, `col_account`),
  CONSTRAINT `cns_grn_mail_automatic_event_account` FOREIGN KEY (`col_account`) REFERENCES `tab_grn_mail_account` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


CREATE TABLE IF NOT EXISTS `tab_grn_mail_automatic_event_trigger_condition` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_event` bigint(20) NOT NULL,
  `col_evaluation_method` varchar(256) NOT NULL,
  `col_evaluation_object` varchar(256) NOT NULL,
  `col_match_data` varchar(256) NOT NULL,
  PRIMARY KEY (`_id`),
  KEY `idx_event` (`col_event`),
  CONSTRAINT `cns_grn_mail_automatic_event_trigger_condition_event_id` FOREIGN KEY (`col_event`) REFERENCES `tab_grn_mail_automatic_event` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


CREATE TABLE IF NOT EXISTS `tab_grn_mail_automatic_event_action` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_event` bigint(20) NOT NULL,
  `col_name` varchar(100) NOT NULL,
  `col_message` mediumtext NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY (`col_event`, `col_name`),
  KEY `idx_event` (`col_event`),
  CONSTRAINT `cns_grn_mail_automatic_event_action_event_id` FOREIGN KEY (`col_event`) REFERENCES `tab_grn_mail_automatic_event` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-544 START */
