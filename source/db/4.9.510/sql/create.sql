/* Garoon DDL */

/* ########################################################################## */
/* execute the create table query first */
/* ########################################################################## */

/* GTM-1447 START */
CREATE TABLE IF NOT EXISTS `tab_grn_kintone_app_relation_setting` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_page` char(100),
  `col_itemname` longtext NOT NULL,
  `col_value` longtext,
  `col_view_order` int(11) NOT NULL DEFAULT '2147483647',
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-1447 END */

/* GTM-1448 START */
CREATE TABLE IF NOT EXISTS `tab_grn_schedule_app_relations` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_user` bigint(20),
  `col_event` bigint(20) NOT NULL,
  `col_item_id` bigint(20) NOT NULL,
  `col_app_id` bigint(20) NOT NULL,
  `col_record_id` bigint(20),
  PRIMARY KEY (`_id`),
  KEY `idx_event_item_app_record` (`col_event`,`col_item_id`,`col_app_id`,`col_record_id`),
  CONSTRAINT `cns_grn_schedule_app_relations_event_id` FOREIGN KEY (`col_event`) REFERENCES `tab_grn_schedule_event` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_grn_schedule_app_relations_item_id` FOREIGN KEY (`col_item_id`) REFERENCES `tab_grn_kintone_app_relation_setting` (`_id`) ON DELETE CASCADE,
  CONSTRAINT `cns_grn_schedule_app_relations_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GTM-1448 END */