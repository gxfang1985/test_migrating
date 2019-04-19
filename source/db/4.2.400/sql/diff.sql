/* Garoon DDL */
/* GTM-529 START */
/*0. Set default value*/
INSERT INTO `tab_grn_availability_dynamic_role`(`col_ctime`, `col_dynamic_role`, `col_app`) VALUES (UNIX_TIMESTAMP(), 'Everyone', 'space,link,schedule,message,bulletin,cabinet,phonemessage,timecard,address,mail' );
/*=============== WORKFLOW ====================*/
/* 1. convert WrokFlow data*/
/* 1.1 Dynamic role*/
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` =  'space,link,schedule,message,bulletin,cabinet,phonemessage,timecard,address,mail,workflow' WHERE `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_workflow_availability_dynamic_role` WHERE `col_dynamic_role`='Everyone');
INSERT INTO `tab_grn_availability_dynamic_role`(`col_ctime`, `col_dynamic_role`, `col_app`) SELECT `col_ctime`, `col_dynamic_role`, 'workflow' AS `col_module_id` FROM `tab_grn_workflow_availability_dynamic_role` WHERE `col_dynamic_role`='LoginUser';
/* 1.2 Static role*/
INSERT INTO `tab_grn_availability_role`(`col_ctime`, `col_role`, `col_app`) SELECT `col_ctime`, `col_role`, 'workflow' AS `col_module_id` FROM `tab_grn_workflow_availability_role` WHERE `col_role` IS NOT NULL;
/* 1.3 Groupuser*/
INSERT INTO `tab_grn_availability_groupuser`(`col_ctime`, `col_groupuser`, `col_app`) SELECT `col_ctime`, `col_groupuser`, 'workflow' AS `col_module_id` FROM `tab_grn_workflow_availability_groupuser` WHERE `col_groupuser` IS NOT NULL;
/* 1.4 User*/
INSERT INTO `tab_grn_availability_user`(`col_ctime`, `col_user`, `col_app`) SELECT `col_ctime`, `col_user`, 'workflow' AS col_module_id FROM `tab_grn_workflow_availabilityuser` WHERE `col_user` IS NOT NULL;
/*=============== REPORT ====================*/
/* 2. convert Report data*/
/* 2.1 Dynamic role*/
/* 2.1.1 Convert data , which have ID like ID of App*/
/*have WorkFlow*/
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` =  'space,link,schedule,message,bulletin,cabinet,phonemessage,timecard,address,mail,workflow,report' 
WHERE `col_app` LIKE '%workflow%' AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_report_availability_dynamic_role` WHERE `col_dynamic_role`='Everyone');
/*-*/
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` = 'workflow,report' 
WHERE `col_app` LIKE '%workflow%' AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_report_availability_dynamic_role` WHERE `col_dynamic_role`='LoginUser');
/*no have WorkFlow*/
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` =  'space,link,schedule,message,bulletin,cabinet,phonemessage,timecard,address,mail,report' 
WHERE `col_app` NOT LIKE '%workflow%' AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_report_availability_dynamic_role` WHERE `col_dynamic_role`='Everyone');
/*-*/
INSERT INTO `tab_grn_availability_dynamic_role`(`col_ctime`, `col_dynamic_role`, `col_app`) SELECT `col_ctime`, `col_dynamic_role`, 'report' AS `col_module_id` FROM `tab_grn_report_availability_dynamic_role` WHERE `col_dynamic_role`='LoginUser'
AND NOT EXISTS(SELECT `col_dynamic_role` FROM `tab_grn_availability_dynamic_role` WHERE `col_dynamic_role`='LoginUser' AND `col_app` LIKE '%report%');

/* 2.2 Static role*/
/*Have Workflow*/
UPDATE `tab_grn_availability_role` SET `col_app`='workflow,report' WHERE `col_app` LIKE '%workflow%' AND `col_role` IN (SELECT `col_role` FROM `tab_grn_report_availability_role` );
/*No have Workflow*/
INSERT INTO `tab_grn_availability_role`(`col_ctime`, `col_role`, `col_app`) SELECT `col_ctime`, `col_role`, 'report' AS `col_module_id` FROM `tab_grn_report_availability_role` WHERE `col_role` IN(SELECT `col_role` FROM  `tab_grn_report_availability_role` WHERE `col_role` NOT IN(SELECT `col_role` FROM `tab_grn_availability_role`) AND `col_role` IS NOT NULL);
/* 2.3 Groupuser*/
/*Have Workflow*/
UPDATE `tab_grn_availability_groupuser` SET col_app = 'workflow,report' 
WHERE `col_app` LIKE '%workflow%' AND `col_groupuser` IN (SELECT `col_groupuser` FROM `tab_grn_report_availability_groupuser` );
/*No have Workflow*/
INSERT INTO `tab_grn_availability_groupuser`(`col_ctime`, `col_groupuser`, `col_app`) SELECT `col_ctime`, `col_groupuser`, 'report' AS `col_module_id` FROM `tab_grn_report_availability_groupuser` WHERE `col_groupuser` IN(SELECT `col_groupuser` FROM  `tab_grn_report_availability_groupuser` WHERE `col_groupuser` NOT IN(SELECT `col_groupuser` FROM `tab_grn_availability_groupuser`) AND `col_groupuser` IS NOT NULL);
/* 2.4 User */
/*Have Workflow*/
UPDATE `tab_grn_availability_user` SET `col_app` = 'workflow,report' 
WHERE `col_app` LIKE '%workflow%' AND `col_user` IN (SELECT `col_user` FROM `tab_grn_report_availabilityuser` );
/*No have Workflow*/
INSERT INTO `tab_grn_availability_user`(`col_ctime`, `col_user`, `col_app`) SELECT `col_ctime`, `col_user`, 'report' AS `col_module_id` FROM `tab_grn_report_availabilityuser` WHERE `col_user` IN(SELECT `col_user` FROM  `tab_grn_report_availabilityuser` WHERE `col_user` NOT IN(SELECT `col_user` FROM `tab_grn_availability_user`) AND `col_user` IS NOT NULL);

/*=============== 3. CELLULAR ====================*/
/* 3. convert Cellular data*/
/* 3.1 Dynamic role*/
/*have WorkFlow */
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` =  'space,link,schedule,message,bulletin,cabinet,phonemessage,timecard,address,mail,workflow,cellular' 
WHERE (`col_app` LIKE '%workflow%') AND (`col_app` NOT LIKE '%report%') AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_cellular_availability_dynamic_role` WHERE `col_dynamic_role`='Everyone');
/*-*/
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` = 'workflow,cellular' 
WHERE (`col_app` LIKE '%workflow%') AND (`col_app` NOT LIKE '%report%') AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_cellular_availability_dynamic_role` WHERE `col_dynamic_role`='LoginUser');
/*have Report */
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` =  'space,link,schedule,message,bulletin,cabinet,phonemessage,timecard,address,mail,report,cellular' 
WHERE (`col_app` LIKE '%report%') AND (`col_app` NOT LIKE '%workflow%') AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_cellular_availability_dynamic_role` WHERE `col_dynamic_role`='Everyone');
/*-*/
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` = 'report,cellular' 
WHERE (`col_app` LIKE '%report%' ) AND (`col_app` NOT LIKE '%workflow%') AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_cellular_availability_dynamic_role` WHERE `col_dynamic_role`='LoginUser');
/*have Worlflow&Report */
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` =  'space,link,schedule,message,bulletin,cabinet,phonemessage,timecard,address,mail,workflow,report,cellular' 
WHERE (`col_app` LIKE '%workflow%') AND(`col_app` LIKE '%report%') AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_cellular_availability_dynamic_role` WHERE `col_dynamic_role`='Everyone');
/*-*/
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` = 'workflow,report,cellular' 
WHERE (`col_app` LIKE '%workflow%') and (`col_app` LIKE '%report%') AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_cellular_availability_dynamic_role` WHERE `col_dynamic_role`='LoginUser');
/*no have WorkFlow & Report*/
UPDATE `tab_grn_availability_dynamic_role` SET `col_app` =  'space,link,schedule,message,bulletin,cabinet,phonemessage,timecard,address,mail,cellular' 
WHERE (`col_app` NOT LIKE '%workflow%') AND(`col_app` NOT LIKE '%report%') AND `col_dynamic_role` IN (SELECT `col_dynamic_role` FROM `tab_grn_cellular_availability_dynamic_role` WHERE `col_dynamic_role`='Everyone');
/*-*/
INSERT INTO `tab_grn_availability_dynamic_role`(`col_ctime`, `col_dynamic_role`, `col_app`) SELECT `col_ctime`, `col_dynamic_role`, 'cellular' AS `col_module_id` FROM `tab_grn_cellular_availability_dynamic_role` WHERE `col_dynamic_role`='LoginUser'
AND NOT EXISTS(SELECT `col_dynamic_role` FROM `tab_grn_availability_dynamic_role` WHERE `col_dynamic_role`='LoginUser' AND `col_app` LIKE '%cellular%');
/* 3.1 Static role*/
/*have WorkFlow */
UPDATE `tab_grn_availability_role` SET `col_app` = 'workflow,cellular' 
WHERE (`col_app` LIKE '%workflow%') AND (`col_app` NOT LIKE '%report%') AND `col_role` IN (SELECT `col_role` FROM `tab_grn_cellular_availability_role`);
/*have Report */
UPDATE `tab_grn_availability_role` SET `col_app` = 'report,cellular' 
WHERE (`col_app` LIKE '%report%') AND (`col_app` NOT LIKE '%workflow%') AND `col_role` IN (SELECT `col_role` FROM `tab_grn_cellular_availability_role`);
/*have Workflow & Report */
UPDATE `tab_grn_availability_role` SET `col_app` = 'workflow,report,cellular' 
WHERE (`col_app` LIKE '%report%') AND (`col_app` LIKE '%workflow%') AND `col_role` IN (SELECT `col_role` FROM `tab_grn_cellular_availability_role`);
/*no have WorkFlow & Report*/
INSERT INTO `tab_grn_availability_role`(`col_ctime`, `col_role`, `col_app`) SELECT `col_ctime`, `col_role`, 'cellular' AS `col_module_id` FROM `tab_grn_cellular_availability_role` WHERE `col_role` IN (SELECT `col_role` FROM  `tab_grn_cellular_availability_role` WHERE `col_role` NOT IN(SELECT `col_role` FROM `tab_grn_availability_role`) AND `col_role` IS NOT NULL);
/* 3.2 Groupuser*/
/*have WorkFlow */
UPDATE `tab_grn_availability_groupuser` SET `col_app` = 'workflow,cellular' 
WHERE (`col_app` LIKE '%workflow%') AND (`col_app` NOT LIKE '%report%') AND `col_groupuser` IN (SELECT `col_groupuser` FROM `tab_grn_cellular_availability_groupuser`);
/*have Report */
UPDATE `tab_grn_availability_groupuser` SET `col_app` = 'report,cellular' 
WHERE (`col_app` LIKE '%report%') AND (`col_app` NOT LIKE '%workflow%') AND `col_groupuser` IN (SELECT `col_groupuser` FROM `tab_grn_cellular_availability_groupuser`);
/*have Workflow & Report */
UPDATE `tab_grn_availability_groupuser` SET `col_app` = 'workflow,report,cellular' 
WHERE (`col_app` LIKE '%report%') AND (`col_app` LIKE '%workflow%') AND `col_groupuser` IN (SELECT `col_groupuser` FROM `tab_grn_cellular_availability_groupuser`);
/*no have WorkFlow & Report*/
INSERT INTO `tab_grn_availability_groupuser`(`col_ctime`, `col_groupuser`, `col_app`) SELECT `col_ctime`, `col_groupuser`, 'cellular' AS `col_module_id` FROM `tab_grn_cellular_availability_groupuser` WHERE `col_groupuser` IN (SELECT `col_groupuser` FROM  `tab_grn_cellular_availability_groupuser` WHERE `col_groupuser` NOT IN(SELECT `col_groupuser` FROM `tab_grn_availability_groupuser`) AND `col_groupuser` IS NOT NULL);

/* 3.2 User*/
/*have WorkFlow */
UPDATE `tab_grn_availability_user` SET `col_app` = 'workflow,cellular' 
WHERE (`col_app` LIKE '%workflow%') AND (`col_app` NOT LIKE '%report%') AND `col_user` IN (SELECT `col_user` FROM `tab_grn_cellular_availability_user`);
/*have Report */
UPDATE `tab_grn_availability_user` SET `col_app` = 'report,cellular' 
WHERE (`col_app` LIKE '%report%') AND (`col_app` NOT LIKE '%workflow%') AND `col_user` IN (SELECT `col_user` FROM `tab_grn_cellular_availability_user`);
/*have Workflow & Report */
UPDATE `tab_grn_availability_user` SET `col_app` = 'workflow,report,cellular' 
WHERE (`col_app` LIKE '%report%') AND (`col_app` LIKE '%workflow%') AND `col_user` IN (SELECT `col_user` FROM `tab_grn_cellular_availability_user`);
/*no have WorkFlow & Report*/
INSERT INTO `tab_grn_availability_user`(`col_ctime`, `col_user`, `col_app`) SELECT `col_ctime`, `col_user`, 'cellular' AS `col_module_id` FROM `tab_grn_cellular_availability_user` WHERE `col_user` IN (SELECT `col_user` FROM  `tab_grn_cellular_availability_user` WHERE `col_user` NOT IN(SELECT `col_user` FROM `tab_grn_availability_user`) AND `col_user` IS NOT NULL);
/* GTM-529 END*/

/* GTM-820 START */
ALTER TABLE `tab_grn_useritem` ADD COLUMN `col_search` int(11) DEFAULT NULL;
UPDATE `tab_grn_useritem` SET `col_search` = (CASE WHEN `col_type` = 'file' OR `col_type` = 'password' THEN 0 ELSE 1 END) WHERE `col_search` IS NULL;
/* GTM-820 END */

/* GTM-527 */
UPDATE `tab_grn_mail_server` SET `col_pbsmtp_wait_sec` = '0', `col_pop_before_smtp`='0';
DELETE FROM `tab_cb_profiledata___system` WHERE `col_module`='grn.common.systemmail' AND `col_name` IN ("is_pop_before_smtp","pop_before_smtp_wait", "pop3_auth", "pop3_server", "pop3_port", "pop3_ssl", "pop3_user", "pop3_pass", "pop3_timeout");
/* GTM-527 */

/* GTM-549 */
UPDATE `tab_cb_profiledata___system` SET `col_value` = 's:19:\"no-reply@cybozu.com\";' WHERE `col_key` = '0' AND `col_module` = 'grn.common.systemmail' AND `col_name` = 'mailaddress' AND `col_value` != 's:19:\"no-reply@cybozu.com\";'
 AND EXISTS(SELECT data1._id FROM (SELECT `_id` FROM `tab_cb_profiledata___system` WHERE `col_key` = '0' AND `col_module` = 'grn.common.systemmail' AND `col_name` = 'available' AND `col_value` = 'b:1;') AS data1 )
 AND EXISTS(SELECT data2._id FROM (SELECT `_id` FROM `tab_cb_profiledata___system` WHERE `col_key` = '0' AND `col_module` = 'grn.common.systemmail' AND `col_name` = 'use_builtin' AND `col_value` = 'b:1;') AS data2 );
/* GTM-549 */

/* GRB-14560 */
DELETE FROM `tab_cb_scheduleevent` WHERE `col_name` = 'grn_rss_cybozu_information';
/* GRB-14560 */

/* GTM-1016 Start */
INSERT INTO `tab_cb_profiledata___system` SET col_key = 0, col_module = 'grn.mail.system', col_name = 'automatic_mail', col_value = 'b:0;';
/* GTM-1016 End */

/* GTM-839 */
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.common.ui', 'inline_thumbnail', 's:1:\"1\";');
/* GTM-839 */

/* ########################################################################## */
/*
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='4.2.400';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;