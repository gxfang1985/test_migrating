/* Garoon DDL */
/* GTM-1288 Start */
TRUNCATE TABLE tab_grn_ticket_user;
ALTER TABLE tab_grn_ticket_user ENGINE = InnoDB;
/* GTM-1288 End */

/** GTM-963 remove useless authentication, login driver */
DELETE FROM `tab_grn_authentication_login_authenticate`
WHERE `col_driver_type` IN ("grn.common.authentication.authenticate.report",
                            "grn.common.authentication.authenticate.workflow");
/** GTM-963 End */
/* ########################################################################## */
/*
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='4.7.500';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;
