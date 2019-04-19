/* Garoon DDL */

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

/* ########################################################################## */

/* GRN2-4460 start */
UPDATE IGNORE
    `tab_cb_profiledata___system`
SET
    col_module = 'grn.netmeeting.system'
WHERE
    col_module = 'grn.vcube.system';

UPDATE IGNORE
    `tab_cb_profiledata___system`
SET
    col_name = 'netmeeting_meeting_system_url'
WHERE
    col_module = 'grn.netmeeting.system'
    AND 
    col_name = 'vcube_meeting_system_url';

DELETE FROM
    tab_cb_profiledata___system 
WHERE
    col_module = 'grn.netmeeting.system'
    AND 
    col_name = 'vcube_meeting_system_url';


UPDATE IGNORE
    `tab_cb_profiledata___system`
SET
    col_name = 'netmeeting_login_id'
WHERE
    col_module = 'grn.netmeeting.system'
    AND 
    col_name = 'vcube_login_id';

DELETE FROM
    tab_cb_profiledata___system 
WHERE
    col_module = 'grn.netmeeting.system'
    AND 
    col_name = 'vcube_login_id';


UPDATE IGNORE
    `tab_cb_profiledata___system`
SET
    col_name = 'netmeeting_login_password'
WHERE
    col_module = 'grn.netmeeting.system'
    AND 
    col_name = 'vcube_login_password';

DELETE FROM
    tab_cb_profiledata___system 
WHERE
    col_module = 'grn.netmeeting.system'
    AND 
    col_name = 'vcube_login_password';

/* GRN2-4460 end */

/* ########################################################################## */

/* 
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='1.6.2';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;

/* Finalization */
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
