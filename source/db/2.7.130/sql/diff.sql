/* Garoon DDL */
DELETE FROM tab_cb_profiledata___system WHERE col_name="sso" AND col_module="grn.phonemessage";

/* GRREQ-198 Start */
ALTER TABLE tab_grn_useritem ADD COLUMN `col_slash` bigint(20) DEFAULT NULL, ADD UNIQUE `idx_slash` (`col_slash`);
/* GRREQ-198 Start */

/* GRN2-4699 Start */
UPDATE tab_grn_workflow_item SET col_export_data=0;
/* GRN2-4699 Start */

/* 
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='2.7.130';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;


