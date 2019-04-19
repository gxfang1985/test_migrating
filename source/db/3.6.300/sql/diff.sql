/* Garoon DDL */

/* ########################################################################## */

/* GTM-78 スペースにいいね機能をつける */
INSERT INTO tab_cb_profiledata___system SET
  col_key = 0,
  col_module = 'grn.common.application',
  col_name = 'favour',
  col_value = 'a:1:{s:6:\"active\";b:0;}'
  ON DUPLICATE KEY UPDATE col_value='a:1:{s:6:\"active\";b:0;}';

INSERT INTO `tab_grn_applicationname` (`col_application`, `col_locale`, `col_name`) VALUES ('favour','ja','いいね！'),('favour','en','Like'),('favour','zh','顶');
/* GTM-78 END */

/* GTM-87 START */
INSERT INTO `tab_cb_scheduleevent` (`col_arguments`, `col_command`, `col_execution`, `col_filename`, `col_module`, `col_name`, `col_type`) VALUES ('','* * * * *',0,'background_job_daemon.csp','','background_job_daemon',1);
/* GTM-87 END */

/* GTM-134 Start */
UPDATE tab_grn_useritem SET col_not_modify = '0', col_show = '1';
/* GTM-134 End */

/* GTM-96 Start */
INSERT INTO `tab_cb_profiledata___system` SET col_key = 0, col_module = 'grn.mail.system', col_name = 'screen_layout', col_value = 'a:3:{s:5:"3pane";b:1;s:5:"2pane";b:1;s:12:"default_pane";i:2;}';
/* GTM-96 End */

/* ########################################################################## */

/*
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='3.6.300';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;


