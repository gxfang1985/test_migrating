/* Garoon DDL */

/* ########################################################################## */

/* ########################################################################## */

/* GRN35-1365 */
CREATE TABLE IF NOT EXISTS `tab_grn_mail_receivedfilerelation` (
`col_blob` char(49) CHARACTER SET ascii DEFAULT NULL,
`col_file` bigint(20) NOT NULL DEFAULT '0',
`col_user` bigint(20) NOT NULL DEFAULT '0',
`col_delete` tinyint(4) DEFAULT NULL,
PRIMARY KEY (`col_file`, `col_user`),
KEY `cns_grn_mail_receivedfilerelation_user` (`col_user`),
KEY `idx_blob_delete` (`col_blob`,`col_delete`),
CONSTRAINT `cns_grn_mail_receivedfilerelation_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

/* 
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='2.5.111';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;

