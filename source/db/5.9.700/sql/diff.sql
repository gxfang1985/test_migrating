/* Garoon DDL */
/* GTM-1789 Start */
DELETE FROM `tab_grn_authentication_login_authenticate` WHERE `col_driver_type` = 'grn.common.authentication.authenticate.reminder';
DELETE FROM `tab_grn_authentication_login_authenticate` WHERE `col_driver_type` = 'grn.common.authentication.login.reminder';
/* GTM-1789 End */
/* ########################################################################## */

/* ########################################################################## */

/*
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='5.9.700';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;
