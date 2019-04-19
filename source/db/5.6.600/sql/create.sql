/* Garoon DDL */

/* ########################################################################## */
/* execute the create table query first */
/* ########################################################################## */
/* GTM-1638(GRM-1269) START */
CREATE TABLE IF NOT EXISTS `tab_grn_schedule_event_attendance_status` (
  `col_event` bigint(20) NOT NULL,
  `col_user` bigint(20) NOT NULL,
  `col_status` tinyint(1) NOT NULL,
  `col_ctime` int(11) NOT NULL,
  `col_message` text,
  PRIMARY KEY (`col_event`,`col_user`),
  KEY `idx_event_status` (`col_event`,`col_status`),
  KEY `idx_user_status` (`col_user`,`col_status`),
  CONSTRAINT `cns_schedule_event_attendance_status_event` FOREIGN KEY (`col_event`) REFERENCES `tab_grn_schedule_event` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_schedule_event_attendance_status_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_schedule_attendance_list_access_time` (
  `col_event` bigint(20) NOT NULL,
  `col_timestamp` int(11) NOT NULL,
  PRIMARY KEY (`col_event`),
  CONSTRAINT `cns_tab_grn_schedule_attendance_list_access_time` FOREIGN KEY (`col_event`) REFERENCES `tab_grn_schedule_event` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-1638(GRM-1269) END */

/* GTM-1673(GRM-1334) START */
CREATE TABLE IF NOT EXISTS `tab_grn_schedule_event_facility_approval` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_event` bigint(20) NOT NULL,
  `col_facility` bigint(20),
  `col_facility_name` char(100)  NOT NULL,
  `col_start_datetime` int(11) NOT NULL,
  `col_end_datetime` int(11) NOT NULL,
  `col_using` tinyint(1) NOT NULL,
  `col_status` tinyint(1) NOT NULL,
  `col_approval_time` int(11) NOT NULL,
  `col_comment` text,
  `col_user` bigint(20),
  `col_user_name` char(100) NOT NULL,
  PRIMARY KEY (`_id`),
  CONSTRAINT `cns_schedule_event_facility_approval_event` FOREIGN KEY (`col_event`) REFERENCES `tab_grn_schedule_event` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_schedule_event_facility_approval_facility` FOREIGN KEY (`col_facility`) REFERENCES `tab_grn_facility_facility` (`_id`) ON DELETE SET NULL,
  CONSTRAINT `cns_schedule_event_facility_approval_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_schedule_event_facility_approval_using_purpose` (
  `col_event` bigint(20) NOT NULL,
  `col_using_purpose` text,
  PRIMARY KEY (`col_event`),
  CONSTRAINT `cns_schedule_event_facility_approval_using_purpose_event` FOREIGN KEY (`col_event`) REFERENCES `tab_grn_schedule_event` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `tab_grn_schedule_event_facility_approval_applying` (
  `col_event` bigint(20) NOT NULL,
  `col_facility` bigint(20) NOT NULL,
  `col_applying_user` bigint(20),
  `col_applying_user_name` char(100) NOT NULL,
  `col_applying_time` int(11) NOT NULL,
  PRIMARY KEY (`col_event`, `col_facility`),
  CONSTRAINT `cns_schedule_event_facility_approval_applying_event` FOREIGN KEY (`col_event`) REFERENCES `tab_grn_schedule_event` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_schedule_event_facility_approval_applying_facility` FOREIGN KEY (`col_facility`) REFERENCES `tab_grn_facility_facility` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_schedule_event_facility_approval_applying_applying_user` FOREIGN KEY (`col_applying_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-1673(GRM-1334) END */
