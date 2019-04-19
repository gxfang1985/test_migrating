/* Garoon DDL */


/* GRREQ-183 start */
UPDATE tab_cb_profiledata___system SET col_value = 'i:30720;' WHERE col_module = 'grn.mail.system' AND col_name LIKE 'receive_limit%' AND col_value = 'i:-1;'; 
/* GRREQ-183 end */

/* 
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='2.6.120';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;

