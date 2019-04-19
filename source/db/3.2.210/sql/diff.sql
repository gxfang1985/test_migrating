/* GRN2-4525  Start */
ALTER TABLE  tab_grn_space_todo_user
ADD col_display_name char(100) NOT NULL;
ALTER TABLE  tab_grn_space_todo_user
DROP FOREIGN  KEY cns_grn_space_todo_user_todo;
ALTER TABLE  tab_grn_space_todo_user
DROP FOREIGN  KEY cns_grn_space_todo_user_user;
ALTER TABLE  tab_grn_space_todo_user 
DROP KEY col_todo;
ALTER TABLE  tab_grn_space_todo_user
DROP PRIMARY KEY;
ALTER TABLE  tab_grn_space_todo_user
MODIFY col_user bigint(20) null;
ALTER TABLE  tab_grn_space_todo_user
ADD CONSTRAINT `cns_grn_space_todo_user_user` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE SET NULL;
ALTER TABLE  tab_grn_space_todo_user
ADD CONSTRAINT `cns_grn_space_todo_user_todo` FOREIGN KEY (`col_todo`) REFERENCES `tab_grn_space_todo` (`_id`) ON DELETE CASCADE;
ALTER TABLE tab_grn_space_todo_user ADD KEY `col_todo` (`col_todo`,`col_display_order`,`col_user`,`col_display_name`);

UPDATE tab_grn_space_todo_user, tab_cb_user 
SET tab_grn_space_todo_user.col_display_name = tab_cb_user.col_display_name
WHERE tab_grn_space_todo_user.col_user = tab_cb_user._id ;
/* GRN2-4525 End */
/*
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='3.2.210';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;