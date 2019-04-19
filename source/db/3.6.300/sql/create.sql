/* Garoon DDL */

/* ########################################################################## */
/* execute the create table query first */
/* ########################################################################## */

/* GTM-87 START  */
CREATE TABLE IF NOT EXISTS `tab_grn_background_job` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_message` mediumtext NOT NULL,
  `col_job_name` varchar(255) NOT NULL,
  `col_ctime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `col_ptime` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`_id`),
  KEY `_tab_grn_background_job_ctime` (`col_ctime`),
  KEY `_tab_grn_background_job_ptime` (`col_ptime`),
  KEY `_tab_grn_background_job_name` (`col_job_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/* GTM-87 END */

/* GTM-78 スペースにいいね機能をつける */
CREATE TABLE IF NOT EXISTS `tab_grn_favour` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_favourer_id` bigint(20) NOT NULL,
  `col_favourer_name` char(128) DEFAULT NULL,
  `col_module_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_sub_module_id` char(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `col_timestamp` int(11) NOT NULL,
  `col_type` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_value` char(64) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`_id`),
  KEY `idx_module_type_value` (`col_module_id`,`col_sub_module_id`,`col_type`,`col_value`),
  CONSTRAINT `cns_grn_favour_user` FOREIGN KEY (`col_favourer_id`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_favour_notify` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_abstract` char(128) DEFAULT NULL,
  `col_favourer_id` char(128) NOT NULL,
  `col_favourer_name` char(128) DEFAULT NULL,
  `col_module_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_org_data` text,
  `col_read` int(11) DEFAULT NULL,
  `col_sub_module_id` char(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `col_timestamp` int(11) NOT NULL,
  `col_type` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_user` bigint(20) NOT NULL,
  `col_value` char(64) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `idx_favourer_type_value_module_sub_module` (`col_favourer_id`,`col_type`,`col_value`,`col_module_id`,`col_sub_module_id`),
  KEY `idx_ts` (`col_timestamp`),
  KEY `idx_type_value` (`col_type`,`col_value`),
  KEY `idx_type_value_module_sub_module` (`col_type`,`col_value`,`col_module_id`,`col_sub_module_id`),
  KEY `idx_user_module_read_ts_n` (`col_user`,`col_module_id`,`col_read`,`col_timestamp`,`_id`),
  KEY `idx_user_module_favourer_ts` (`col_user`,`col_module_id`,`col_favourer_name`,`col_timestamp`),
  KEY `idx_user_module_sub_module_type_value` (`col_user`,`col_module_id`,`col_sub_module_id`,`col_type`,`col_value`),
  KEY `idx_user_module_ts` (`col_user`,`col_module_id`,`col_timestamp`),
  KEY `idx_user_read_ts_n` (`col_user`,`col_read`,`col_timestamp`,`_id`),
  KEY `idx_user_favourer_ts` (`col_user`,`col_favourer_name`,`col_timestamp`),
  KEY `idx_user_ts_n` (`col_user`,`col_timestamp`,`_id`),
  CONSTRAINT `cns_grn_favour_notify_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-78 END */

/* GTM-99 */
CREATE TABLE IF NOT EXISTS `tab_grn_mail_incremental_search` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_display_name` char(128) COLLATE utf8mb4_bin NOT NULL DEFAULT "",
  `col_email` char(255) NOT NULL,
  `col_update_time` int(11) NOT NULL DEFAULT 0,
  `col_user_id`  bigint(20) NOT NULL,
  `col_hash` binary(64) NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE (`col_user_id`, `col_hash`),
  KEY `idx_name_email` (`col_display_name`, `col_email`),
  CONSTRAINT `cns_grn_mail_incremental_search_user` FOREIGN KEY (`col_user_id`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-99 END */

/* GTM-109 START */
CREATE TABLE IF NOT EXISTS `tab_grn_cabinet_filedisplayorder` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_folder` bigint(20) DEFAULT NULL,
  `col_order` text,
  PRIMARY KEY (`_id`),
  KEY `cni_folder` (`col_folder`),
  CONSTRAINT `cns_grn_cabinet_filedisplayorder_folder` FOREIGN KEY (`col_folder`) REFERENCES `tab_grn_cabinet_folderentity` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-109 END */

/* GTM-93 */
CREATE TABLE IF NOT EXISTS `tab_grn_space_discussion_notification_user` (
  `col_discussion` bigint(20) NOT NULL,
  `col_user` bigint(20) NOT NULL,
  PRIMARY KEY(`col_discussion`, `col_user`),
  KEY `idx_discussion` (`col_discussion`),
  KEY `idx_user` (`col_user`),
  CONSTRAINT `cns_grn_space_discussion_notification_user_discussion` FOREIGN KEY (`col_discussion`) REFERENCES `tab_grn_space_thread` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_grn_space_discussion_notification_user_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-93 END */
