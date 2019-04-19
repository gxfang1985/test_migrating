/* Garoon DDL */

/* ########################################################################## */

/* ########################################################################## */

/* GRREQ-71 【テーブル数削減】お気に入りのテーブルを50分割から一つのテーブルにする */
/* Create new table tab_grn_star */
CREATE TABLE IF NOT EXISTS `tab_grn_star` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_folder` bigint(20) DEFAULT NULL,
  `col_list_index` int(11) NOT NULL DEFAULT '2147483647',
  `col_module_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_mtime` int(11) DEFAULT NULL,
  `col_org_data` text,
  `col_reserve_blob1` blob,
  `col_reserve_blob2` blob,
  `col_reserve_blob3` blob,
  `col_reserve_int1` int(11) DEFAULT NULL,
  `col_reserve_int2` int(11) DEFAULT NULL,
  `col_reserve_int3` int(11) DEFAULT NULL,
  `col_reserve_text1` char(100) DEFAULT NULL,
  `col_reserve_text2` char(100) DEFAULT NULL,
  `col_reserve_text3` char(100) DEFAULT NULL,
  `col_sender_id` char(128) DEFAULT NULL,
  `col_sender_name` char(128) DEFAULT NULL,
  `col_subject` char(128) DEFAULT NULL,
  `col_timestamp` int(11) NOT NULL,
  `col_type` char(2) DEFAULT NULL,
  `col_unique_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_updater` char(128) DEFAULT NULL,
  `col_updater_name` char(128) DEFAULT NULL,
  `col_user` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `idx_user_module_unique_id` (`col_user`,`col_module_id`,`col_unique_id`),
  KEY `cni_folder` (`col_folder`),
  KEY `cni_user` (`col_user`),
  KEY `idx_ts` (`col_timestamp`),
  KEY `idx_unique_id` (`col_unique_id`),
  KEY `idx_user_module_ts` (`col_user`,`col_module_id`,`col_timestamp`),
  KEY `idx_user_sender_ts` (`col_user`,`col_sender_name`,`col_timestamp`),
  KEY `idx_user_ts_n` (`col_user`,`col_timestamp`,`_id`),
  CONSTRAINT `cns_grn_star_folder` FOREIGN KEY (`col_folder`) REFERENCES `tab_grn_star_folder` (`_id`) ON DELETE SET NULL,
  CONSTRAINT `cns_grn_star_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

/* GRREQ-73【テーブル数削減】通知一覧と確認済み通知のテーブルをまとめて50分割にする */
/* Create new table tab_grn_notification_history and tab_grn_notification_notify */
CREATE TABLE IF NOT EXISTS `tab_grn_notification_history` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_abstract` char(128) DEFAULT NULL,
  `col_abstract_b` char(128) DEFAULT NULL,
  `col_abstract_f` char(128) DEFAULT NULL,
  `col_abstract_icon` char(128) DEFAULT NULL,
  `col_abstract_url` char(255) DEFAULT NULL,
  `col_action_id` char(64) NOT NULL,
  `col_attached` int(11) DEFAULT NULL,
  `col_group_name` char(128) DEFAULT NULL,
  `col_module_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_org_data` text,
  `col_popup` int(11) DEFAULT NULL,
  `col_read` int(11) DEFAULT NULL,
  `col_reserve_blob1` blob,
  `col_reserve_blob2` blob,
  `col_reserve_blob3` blob,
  `col_reserve_int1` int(11) DEFAULT NULL,
  `col_reserve_int2` int(11) DEFAULT NULL,
  `col_reserve_int3` int(11) DEFAULT NULL,
  `col_reserve_text1` char(100) DEFAULT NULL,
  `col_reserve_text2` char(100) DEFAULT NULL,
  `col_reserve_text3` char(100) DEFAULT NULL,
  `col_sender_id` char(128) DEFAULT NULL,
  `col_sender_name` char(128) DEFAULT NULL,
  `col_sender_url` char(255) DEFAULT NULL,
  `col_status` char(128) DEFAULT NULL,
  `col_subject` char(128) DEFAULT NULL,
  `col_subject_b` char(128) DEFAULT NULL,
  `col_subject_f` char(128) DEFAULT NULL,
  `col_subject_icon` char(128) DEFAULT NULL,
  `col_subject_url` char(255) DEFAULT NULL,
  `col_timestamp` int(11) NOT NULL,
  `col_unique_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_user` bigint(20) NOT NULL,
  `col_sub_module_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_space_id` int(11) DEFAULT NULL,
  `col_space_name` varchar(255) DEFAULT NULL,
  `col_event_start_ts` int(11) DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `idx_unique_id_module_user` (`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`),
  UNIQUE KEY `idx_user_module_unique_id` (`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`),
  KEY `idx_spaceid` (`col_space_id`),
  KEY `idx_ts` (`col_timestamp`),
  KEY `idx_unique_id` (`col_unique_id`),
  KEY `idx_user_module_sender_ts` (`col_user`,`col_module_id`,`col_sender_name`,`col_timestamp`),
  KEY `idx_user_module_status_ts` (`col_user`,`col_module_id`,`col_status`,`col_timestamp`),
  KEY `idx_user_module_ts` (`col_user`,`col_module_id`,`col_timestamp`),
  KEY `idx_user_sender_ts` (`col_user`,`col_sender_name`,`col_timestamp`),
  KEY `idx_user_status_ts` (`col_user`,`col_status`,`col_timestamp`),
  KEY `idx_user_ts` (`col_user`,`col_timestamp`),
  KEY `idx_user_ts_oid` (`col_user`,`col_timestamp`,`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
CREATE TABLE IF NOT EXISTS `tab_grn_notification_notify` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_abstract` char(128) DEFAULT NULL,
  `col_abstract_b` char(128) DEFAULT NULL,
  `col_abstract_f` char(128) DEFAULT NULL,
  `col_abstract_icon` char(128) DEFAULT NULL,
  `col_abstract_url` char(255) DEFAULT NULL,
  `col_action_id` char(64) NOT NULL,
  `col_attached` int(11) DEFAULT NULL,
  `col_auto_confirm` int(11) DEFAULT NULL,
  `col_confirm_required` int(11) DEFAULT NULL,
  `col_group_name` char(128) DEFAULT NULL,
  `col_module_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_notify_relation` bigint(20) DEFAULT NULL,
  `col_org_data` text,
  `col_popup` int(11) DEFAULT NULL,
  `col_read` int(11) DEFAULT NULL,
  `col_reserve_blob1` blob,
  `col_reserve_blob2` blob,
  `col_reserve_blob3` blob,
  `col_reserve_int1` int(11) DEFAULT NULL,
  `col_reserve_int2` int(11) DEFAULT NULL,
  `col_reserve_int3` int(11) DEFAULT NULL,
  `col_reserve_text1` char(100) DEFAULT NULL,
  `col_reserve_text2` char(100) DEFAULT NULL,
  `col_reserve_text3` char(100) DEFAULT NULL,
  `col_sender_id` char(128) DEFAULT NULL,
  `col_sender_name` char(128) DEFAULT NULL,
  `col_sender_url` char(255) DEFAULT NULL,
  `col_status` char(128) DEFAULT NULL,
  `col_subject` char(128) DEFAULT NULL,
  `col_subject_b` char(128) DEFAULT NULL,
  `col_subject_f` char(128) DEFAULT NULL,
  `col_subject_icon` char(128) DEFAULT NULL,
  `col_subject_url` char(255) DEFAULT NULL,
  `col_timestamp` int(11) NOT NULL,
  `col_unique_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_user` bigint(20) NOT NULL,
  `col_sub_module_id` char(64) COLLATE utf8mb4_bin NOT NULL,
  `col_space_id` int(11) DEFAULT NULL,
  `col_space_name` varchar(255) DEFAULT NULL,
  `col_event_start_ts` int(11) DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `idx_unique_id_module_user` (`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`),
  UNIQUE KEY `idx_user_module_unique_id` (`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`),
  KEY `idx_spaceid` (`col_space_id`),
  KEY `idx_ts` (`col_timestamp`),
  KEY `idx_unique_id` (`col_unique_id`),
  KEY `idx_user_module_read_ts_n` (`col_user`,`col_module_id`,`col_read`,`col_timestamp`,`_id`),
  KEY `idx_user_module_sender_ts` (`col_user`,`col_module_id`,`col_sender_name`,`col_timestamp`),
  KEY `idx_user_module_status_ts_n` (`col_user`,`col_module_id`,`col_status`,`col_timestamp`,`_id`),
  KEY `idx_user_module_ts` (`col_user`,`col_module_id`,`col_timestamp`),
  KEY `idx_user_module_ts_n_status` (`col_user`,`col_module_id`,`col_timestamp`,`_id`,`col_status`),
  KEY `idx_user_read_ts_n` (`col_user`,`col_read`,`col_timestamp`,`_id`),
  KEY `idx_user_sender_ts` (`col_user`,`col_sender_name`,`col_timestamp`),
  KEY `idx_user_status_ts` (`col_user`,`col_status`,`col_timestamp`),
  KEY `idx_user_ts_n` (`col_user`,`col_timestamp`,`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

/* GRREQ-148 スペース：ディスカッション単位で、購読/未購読が設定できる */
CREATE TABLE IF NOT EXISTS `tab_grn_space_discussion_non_notification_user` (
  `col_discussion` bigint(20) NOT NULL,
  `col_user` bigint(20) NOT NULL,
  PRIMARY KEY(`col_discussion`, `col_user`),
  KEY `idx_discussion` (`col_discussion`),
  KEY `idx_user` (`col_user`),
  CONSTRAINT `cns_grn_space_discussion_non_notification_user_discussion` FOREIGN KEY (`col_discussion`) REFERENCES `tab_grn_space_thread` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_grn_space_discussion_non_notification_user_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

/* GRREQ-151 KUNAIのアプリ制御：管理画面 */
CREATE TABLE IF NOT EXISTS `tab_grn_kunai_availability_dynamic_role` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_dynamic_role` char(100) DEFAULT NULL,
  `col_app_status` text,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_kunai_availability_group` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_group` bigint(20) NOT NULL,
  `col_app_status` text,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `cni_group` (`col_group`),
  CONSTRAINT `cns_grn_kunai_availability_group_group` FOREIGN KEY (`col_group`) REFERENCES `tab_cb_group` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_kunai_availability_static_role` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_static_role` bigint(20) NOT NULL,
  `col_app_status` text,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `cni_static_role` (`col_static_role`),
  CONSTRAINT `cns_grn_kunai_availability_static_role_static_role` FOREIGN KEY (`col_static_role`) REFERENCES `tab_cb_role` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_kunai_availability_user` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_user` bigint(20) NOT NULL,
  `col_app_status` text,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `cni_user` (`col_user`),
  CONSTRAINT `cns_grn_kunai_availability_user_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

