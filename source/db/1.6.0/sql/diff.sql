/* Garoon DDL */

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

/* ########################################################################## */

ALTER TABLE `tab_grn_facility_facility` DROP COLUMN `col_vcube_guests_audience_limit`;
ALTER TABLE `tab_grn_facility_facility` CHANGE COLUMN `col_vcube_available` `col_netmeeting_available` INT(11) DEFAULT NULL;
ALTER TABLE `tab_grn_facility_facility` CHANGE COLUMN `col_vcube_guests_normal_limit` `col_netmeeting_guests_normal_limit` INT(11) DEFAULT NULL;

ALTER TABLE `tab_grn_schedule_vcube_cooperation` RENAME TO `tab_grn_schedule_netmeeting_cooperation`;
ALTER TABLE `tab_grn_schedule_vcube_invitation` RENAME TO `tab_grn_schedule_netmeeting_invitation`;

ALTER TABLE `tab_grn_schedule_netmeeting_invitation` DROP FOREIGN KEY `cns_grn_schedule_vcube_invitation_coop_id`,
    ADD CONSTRAINT `cns_grn_schedule_netmeeting_invitation_coop_id` FOREIGN KEY `cns_grn_schedule_netmeeting_invitation_coop_id` (`col_coop_id`)
        REFERENCES `tab_grn_schedule_netmeeting_cooperation` (`_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

DELETE FROM `tab_cb_profiledata___system` WHERE `col_key` = 0 AND `col_module` = 'grn.netmeeting.system' AND `col_name` = 'netmeeting_license';
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.netmeeting.system', 'netmeeting_license', 's:1:\"1\";');

/* GRN2-3924 start */
INSERT INTO
    tab_grn_space_application_local 
SELECT
    tab_grn_space_application._id, tab_cb_language_status._id, 'Discussions'
FROM
    tab_cb_language_status,
    tab_grn_space_application
WHERE
    tab_cb_language_status.col_language = 'en'
    AND
    tab_grn_space_application.col_application_code = 'jp.co.cybozu.garoon350.discussion';

INSERT INTO
    tab_grn_space_application_local 
SELECT
    tab_grn_space_application._id, tab_cb_language_status._id, 'ディスカッション'
FROM
    tab_cb_language_status,
    tab_grn_space_application
WHERE
    tab_cb_language_status.col_language = 'ja'
    AND
    tab_grn_space_application.col_application_code = 'jp.co.cybozu.garoon350.discussion';

INSERT INTO
    tab_grn_space_application_local 
SELECT
    tab_grn_space_application._id, tab_cb_language_status._id, '讨论区'
FROM
    tab_cb_language_status,
    tab_grn_space_application
WHERE
    tab_cb_language_status.col_language = 'zh'
    AND
    tab_grn_space_application.col_application_code = 'jp.co.cybozu.garoon350.discussion';


INSERT INTO
    tab_grn_space_application_local 
SELECT
    tab_grn_space_application._id, tab_cb_language_status._id, 'Shared To-Dos'
FROM
    tab_cb_language_status,
    tab_grn_space_application
WHERE
    tab_cb_language_status.col_language = 'en'
    AND
    tab_grn_space_application.col_application_code = 'jp.co.cybozu.garoon350.todo';

INSERT INTO
    tab_grn_space_application_local 
SELECT
    tab_grn_space_application._id, tab_cb_language_status._id, '共有ToDo'
FROM
    tab_cb_language_status,
    tab_grn_space_application
WHERE
    tab_cb_language_status.col_language = 'ja'
    AND
    tab_grn_space_application.col_application_code = 'jp.co.cybozu.garoon350.todo';

INSERT INTO
    tab_grn_space_application_local 
SELECT
    tab_grn_space_application._id, tab_cb_language_status._id, '共享ToDo'
FROM
    tab_cb_language_status,
    tab_grn_space_application
WHERE
    tab_cb_language_status.col_language = 'zh'
    AND
    tab_grn_space_application.col_application_code = 'jp.co.cybozu.garoon350.todo';

/* GRN2-3924 end */

/* GRN2-3796 start */

UPDATE 
    tab_grn_schedule_eventdatetime 
SET
    col_timezone     = (CASE WHEN col_timezone     = 'JST' THEN 'Asia/Tokyo' ELSE col_timezone     END ),
    col_end_timezone = (CASE WHEN col_end_timezone = 'JST' THEN 'Asia/Tokyo' ELSE col_end_timezone END )
WHERE
    col_timezone = 'JST' OR col_end_timezone = 'JST'; 

UPDATE
    tab_grn_schedule_eventdate
SET
    col_timezone     = (CASE WHEN col_timezone     = 'JST' THEN 'Asia/Tokyo' ELSE col_timezone     END),
    col_end_timezone = (CASE WHEN col_end_timezone = 'JST' THEN 'Asia/Tokyo' ELSE col_end_timezone END)
WHERE
    col_timezone = 'JST' OR col_end_timezone = 'JST'; 
    
UPDATE
    tab_grn_schedule_repeatexcept
SET
    col_timezone = 'Asia/Tokyo'
WHERE
    col_timezone = 'JST';

UPDATE
    tab_grn_schedule_repeatcondition
SET
    col_timezone = 'Asia/Tokyo'
WHERE
    col_timezone = 'JST';
    
/* GRN2-3796 end */

/* GRN2-4179 start */
UPDATE
    tab_grn_space_authority
SET
    col_authority_code = "read_detail",
    col_authority_name = "READ_DETAIL"
WHERE
    col_authority_code = "read";
    
INSERT 
    tab_grn_space_authority
SET
    col_authority_code = "read_summary",
    col_authority_name = "READ_SUMMARY";
    
INSERT
    tab_grn_space_access_control_list
SELECT
    NULL, (SELECT _id FROM tab_grn_space_authority WHERE col_authority_code="read_summary")
FROM
    tab_grn_space_access_control_list,
    tab_grn_space_authority
WHERE
    tab_grn_space_access_control_list.col_authority = tab_grn_space_authority._id
    AND
    tab_grn_space_authority.col_authority_code = "read_detail";

CREATE TABLE tmp_acl_table(
    detail_id BIGINT(20), 
    summary_id BIGINT(20)
);

INSERT INTO
    tmp_acl_table
SELECT
    read_detail_table._id AS detail_id,
    read_summary_table._id AS summary_id
FROM
    (SELECT
        acl1._id, count(*) AS detail_num
    FROM
        tab_grn_space_access_control_list AS acl1,
        tab_grn_space_access_control_list AS acl2,
        tab_grn_space_authority AS authority
    WHERE
        acl1.col_authority = authority._id
        AND 
        acl2.col_authority = authority._id
        AND
        acl1._id >= acl2._id
        AND
        authority.col_authority_code = "read_detail"
    GROUP BY
        acl1._id
    ORDER BY
        _id) AS read_detail_table,
    (SELECT
        acl1._id, count(*) AS summary_num
    FROM
        tab_grn_space_access_control_list AS acl1,
        tab_grn_space_access_control_list AS acl2,
        tab_grn_space_authority AS authority
    WHERE
        acl1.col_authority = authority._id
        AND 
        acl2.col_authority = authority._id
        AND
        acl1._id >= acl2._id
        AND
        authority.col_authority_code = "read_summary"
    GROUP BY
        acl1._id
    ORDER BY
        _id) AS read_summary_table
WHERE
    read_detail_table.detail_num = read_summary_table.summary_num;
    
INSERT
    tab_grn_space_space_acl
SELECT
    tab_grn_space_space_acl.col_space,
    tmp_acl_table.summary_id,
    tab_grn_space_space_acl.col_is_grant
FROM
    tab_grn_space_space_acl,
    tmp_acl_table
WHERE
    tab_grn_space_space_acl.col_acl = tmp_acl_table.detail_id;

INSERT
    tab_grn_space_acl_user
SELECT
    tmp_acl_table.summary_id,
    tab_grn_space_acl_user.col_user
FROM
    tab_grn_space_acl_user,
    tmp_acl_table
WHERE
    tab_grn_space_acl_user.col_acl = tmp_acl_table.detail_id;

DROP TABLE tmp_acl_table;
/* GRN2-4179 end */

/* GRN2-4201 start */
ALTER TABLE tab_grn_space_space_memo ADD (col_memo_html longtext DEFAULT NULL);
ALTER TABLE tab_grn_space_comment ADD (col_content_html longtext DEFAULT NULL);
ALTER TABLE tab_grn_space_thread ADD (col_content_html longtext DEFAULT NULL);
ALTER TABLE tab_grn_space_todo ADD (col_content_html longtext DEFAULT NULL);
/* GRN2-4201 end */


/* ########################################################################## */

/* 
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
ALTER TABLE `tab_cb_schema_version` MODIFY version varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL;
UPDATE `tab_cb_schema_version` SET `version`='1.6.0';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;

/* Finalization */
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
