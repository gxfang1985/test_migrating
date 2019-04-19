/* Garoon DDL */

/* ########################################################################## */

/* ########################################################################## */

/*
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='3.7.310';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;


