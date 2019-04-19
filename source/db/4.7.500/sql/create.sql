/* Garoon DDL */

/* ########################################################################## */
/* execute the create table query first */
/* ########################################################################## */

/* GTM-1136 START */
CREATE TABLE IF NOT EXISTS `tab_grn_schedule_file` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_creator` bigint(20) DEFAULT NULL,
  `col_creator_foreign_key` char(255) DEFAULT NULL,
  `col_creator_name` char(100) DEFAULT NULL,
  `col_ctime` int(11) DEFAULT NULL,
  `col_description` text,
  `col_mark` int(11) DEFAULT NULL,
  `col_max_version` int(11) NOT NULL,
  `col_modifier` bigint(20) DEFAULT NULL,
  `col_modifier_foreign_key` char(255) DEFAULT NULL,
  `col_modifier_name` char(100) DEFAULT NULL,
  `col_mtime` int(11) DEFAULT NULL,
  `col_title` char(100) DEFAULT NULL,
  `col_title_sort_key` char(255) NOT NULL,
  `col_version` int(11) NOT NULL,
  PRIMARY KEY (`_id`),
  KEY `cni_creator` (`col_creator`),
  KEY `cni_modifier` (`col_modifier`),
  KEY `idx_mark` (`col_mark`),
  KEY `idx_mtime` (`col_mtime`),
  KEY `idx_title_sort_key` (`col_title_sort_key`(191)),
  CONSTRAINT `cns_grn_schedule_file_creator` FOREIGN KEY (`col_creator`) REFERENCES `tab_cb_user` (`_id`) ON DELETE SET NULL,
  CONSTRAINT `cns_grn_schedule_file_modifier` FOREIGN KEY (`col_modifier`) REFERENCES `tab_cb_user` (`_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_schedule_filebody` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_blob` char(49) CHARACTER SET ascii DEFAULT NULL,
  `col_charset` char(100) DEFAULT NULL,
  `col_file` bigint(20) DEFAULT NULL,
  `col_hash` char(40) CHARACTER SET ascii DEFAULT NULL,
  `col_latest` int(11) NOT NULL,
  `col_mime` char(100) NOT NULL,
  `col_name` char(255) NOT NULL,
  `col_size` int(11) NOT NULL,
  `col_timestamp` int(11) NOT NULL,
  `col_version` int(11) NOT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `idx_fv` (`col_file`,`col_version`),
  KEY `cni_file` (`col_file`),
  KEY `idx_tl` (`col_timestamp`,`col_latest`),
  CONSTRAINT `cns_grn_schedule_filebody_file` FOREIGN KEY (`col_file`) REFERENCES `tab_grn_schedule_file` (`_id`) ON DELETE SET NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_schedule_filelog` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_body` bigint(20) DEFAULT NULL,
  `col_comment` text,
  `col_file` bigint(20) DEFAULT NULL,
  `col_filename` char(255) NOT NULL,
  `col_operation` int(11) DEFAULT NULL,
  `col_record_time` int(11) DEFAULT NULL,
  `col_recorder` bigint(20) DEFAULT NULL,
  `col_recorder_foreign_key` char(255) DEFAULT NULL,
  `col_recorder_name` char(100) DEFAULT NULL,
  `col_restore_version` int(11) DEFAULT NULL,
  `col_version` int(11) NOT NULL,
  PRIMARY KEY (`_id`),
  KEY `cni_body` (`col_body`),
  KEY `cni_file` (`col_file`),
  KEY `cni_recorder` (`col_recorder`),
  CONSTRAINT `cns_grn_schedule_filelog_body` FOREIGN KEY (`col_body`) REFERENCES `tab_grn_schedule_filebody` (`_id`) ON DELETE SET NULL,
  CONSTRAINT `cns_grn_schedule_filelog_file` FOREIGN KEY (`col_file`) REFERENCES `tab_grn_schedule_file` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_grn_schedule_filelog_recorder` FOREIGN KEY (`col_recorder`) REFERENCES `tab_cb_user` (`_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_schedule_filerelation` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_event` bigint(20) DEFAULT NULL,
  `col_file` bigint(20) DEFAULT NULL,
  `col_follow` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`_id`),
  KEY `cni_event` (`col_event`),
  KEY `cni_file` (`col_file`),
  KEY `cni_follow` (`col_follow`),
  CONSTRAINT `cns_grn_schedule_filerelation_event` FOREIGN KEY (`col_event`) REFERENCES `tab_grn_schedule_event` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_grn_schedule_filerelation_file` FOREIGN KEY (`col_file`) REFERENCES `tab_grn_schedule_file` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_grn_schedule_filerelation_follow` FOREIGN KEY (`col_follow`) REFERENCES `tab_grn_schedule_eventfollow` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-1136 END */