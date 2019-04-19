/* Garoon DDL */
 
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
 
/* ########################################################################## */
 
 /* start GRN2-4099 GRN35-321 GRN35-322 */
INSERT INTO 
    tab_grn_report_availability_dynamic_role 
    ( col_authority_cellular, col_ctime, col_dynamic_role ) 
SELECT 
    data.col_authority_cellular, data.col_ctime, data.col_dynamic_role 
FROM 
    ( SELECT 1 AS col_authority_cellular, UNIX_TIMESTAMP() AS col_ctime, "Everyone" AS col_dynamic_role ) AS data, 
    ( SELECT COUNT(*) AS count FROM tab_grn_report_availabilityuser ) AS available_user, 
    ( SELECT COUNT(*) AS count FROM tab_grn_report_availability_groupuser ) AS available_group,
    ( SELECT COUNT(*) AS count FROM tab_grn_report_availability_role ) AS available_role,
    ( SELECT COUNT(*) AS count FROM tab_grn_report_availability_dynamic_role WHERE col_dynamic_role = "Everyone" ) AS available_dynamic_role 
WHERE 
    available_user.count = 0 
    AND 
    available_group.count = 0
    AND
    available_role.count = 0
    AND
    available_dynamic_role.count = 0;

INSERT INTO 
    tab_grn_workflow_availability_dynamic_role 
    ( col_authority_cellular, col_ctime, col_dynamic_role ) 
SELECT 
    data.col_authority_cellular, data.col_ctime, data.col_dynamic_role 
FROM 
    ( SELECT 1 AS col_authority_cellular, UNIX_TIMESTAMP() AS col_ctime, "Everyone" AS col_dynamic_role ) AS data, 
    ( SELECT COUNT(*) AS count FROM tab_grn_workflow_availabilityuser ) AS available_user, 
    ( SELECT COUNT(*) AS count FROM tab_grn_workflow_availability_groupuser ) AS available_group,
    ( SELECT COUNT(*) AS count FROM tab_grn_workflow_availability_role ) AS available_role,
    ( SELECT COUNT(*) AS count FROM tab_grn_workflow_availability_dynamic_role WHERE col_dynamic_role = "Everyone" ) AS available_dynamic_role 
WHERE 
    available_user.count = 0 
    AND 
    available_group.count = 0
    AND
    available_role.count = 0
    AND
    available_dynamic_role.count = 0;
/* end GRN2-4099 GRN35-321 GRN35-322 */
/* start GRN2-4155 GRN35-38 */
INSERT INTO 
    tab_grn_cellular_availability_dynamic_role 
    ( col_ctime, col_dynamic_role ) 
SELECT 
    data.col_ctime, data.col_dynamic_role 
FROM 
    ( SELECT UNIX_TIMESTAMP() AS col_ctime, "Everyone" AS col_dynamic_role ) AS data, 
    ( SELECT COUNT(*) AS count FROM tab_grn_cellular_availability_user ) AS available_user, 
    ( SELECT COUNT(*) AS count FROM tab_grn_cellular_availability_groupuser ) AS available_group,
    ( SELECT COUNT(*) AS count FROM tab_grn_cellular_availability_role ) AS available_role,
    ( SELECT COUNT(*) AS count FROM tab_grn_cellular_availability_dynamic_role WHERE col_dynamic_role = "Everyone" ) AS available_dynamic_role 
WHERE 
    available_user.count = 0 
    AND 
    available_group.count = 0
    AND
    available_role.count = 0
    AND
    available_dynamic_role.count = 0;
/* end GRN2-4155 GRN35-38 */

/* GRN2-4146 start */
DELETE FROM
    tab_grn_space_comment_read_status
USING
      tab_grn_space_comment_read_status
    , tab_grn_space_todo_comment AS todo_comment
WHERE
    todo_comment.col_comment = tab_grn_space_comment_read_status.col_comment
    AND
    todo_comment.col_status_code IN ('2','3','4','5');

UPDATE
    tab_grn_space_comment
SET
      col_is_logical_delete = '1'
WHERE
    tab_grn_space_comment._id IN (
        SELECT todo_comment.col_comment
        FROM tab_grn_space_todo_comment AS todo_comment
        WHERE todo_comment.col_status_code IN ('2','3','4','5')
    );

ALTER TABLE `tab_grn_space_todo_comment` DROP COLUMN `col_status_code`;
/* GRN2-4146 end */ 

/* GRN35-861 start */
CREATE TABLE tab_grn_space_member_open_status(
  col_space bigint(20)  NOT NULL,
  col_user  bigint(20)  NOT NULL,

  PRIMARY KEY(col_space, col_user),

  CONSTRAINT cns_tab_grn_space_member_open_status_space FOREIGN KEY(col_space) REFERENCES tab_grn_space_space(_id) ON DELETE CASCADE,
  CONSTRAINT cns_tab_grn_space_member_open_status_user  FOREIGN KEY(col_user)  REFERENCES tab_cb_user(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/* GRN35-861 end */
/* ########################################################################## */
 
/* 
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`=3;
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;
 
/* Finalization */
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
