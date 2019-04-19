/* Garoon Initial Data */

SET NAMES utf8;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0;

--
-- Dumping data for table `_table_info`
--

LOCK TABLES `tab_cb_language_status` WRITE;
/*!40000 ALTER TABLE `tab_cb_language_status` DISABLE KEYS */;
INSERT INTO `tab_cb_language_status` (`_id`, `col_language`, `col_status`) VALUES (4,'ja',1),(5,'en',1),(6,'zh',1),(7,'zh-tw',1);
/*!40000 ALTER TABLE `tab_cb_language_status` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_cb_profiledata___system` WRITE;
/*!40000 ALTER TABLE `tab_cb_profiledata___system` DISABLE KEYS */;
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES 
(0,'grn.common.application','space_root_category','s:33:"jp.co.cybozu.garoon350.space.root";');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.netmeeting.system', 'netmeeting_license', 's:1:\"1\";');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.common.system', 'delete_user_schedule', 'a:3:{s:5:\"start\";i:14;s:3:\"end\";i:18;s:7:\"disable\";b:0;}');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.schedule.system', 'activate_dragdrop', 's:1:"1";');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.common.ui', 'inline_thumbnail', 's:1:\"1\";');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.schedule.system', 'allow_file_attachment', 's:1:\"1\";');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.common.ui', 'mobile_view', 'i:1;');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.mail.system', 'deny_all_permission', 'b:1;');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.fts', 'schema_version', 'i:3;');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.common.system', 'permission_to_select_role', 'i:1;');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.schedule.system', 'allow_setting_group_role_to_watchers', 's:1:"1";');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.favour', 'allow_applications_respond', 'a:2:{s:7:"message";i:1;s:8:"bulletin";i:1;}');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.netmeeting.system', 'netmeeting_vcube_version', 's:1:"5";');
INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.bulletin', 'enable_confirm_authority_read_and_notification_users', 'b:1;');
/*!40000 ALTER TABLE `tab_cb_profiledata___system` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_cb_role` WRITE;
/*!40000 ALTER TABLE `tab_cb_role` DISABLE KEYS */;
INSERT INTO `tab_cb_role` (`_id`, `col_ctime`, `col_description`, `col_foreign_key`, `col_list_index`, `col_mtime`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_text1`, `col_reserve_text2`, `col_slash`) VALUES (1,UNIX_TIMESTAMP(),NULL,'Administrators',2147483647,UNIX_TIMESTAMP(),NULL,NULL,NULL,NULL,NULL,NULL,7532782697181632512);
/*!40000 ALTER TABLE `tab_cb_role` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_cb_scheduleevent` WRITE;
/*!40000 ALTER TABLE `tab_cb_scheduleevent` DISABLE KEYS */;
INSERT INTO `tab_cb_scheduleevent` (`_id`, `col_arguments`, `col_command`, `col_execution`, `col_filename`, `col_module`, `col_name`, `col_type`) VALUES (1,'',CONCAT(FLOOR(RAND()*60), ' 0,6,12,18 * * *'),0,'cleanup.csp','','cleanup',1),(2,'',CONCAT(FLOOR(RAND()*60), ' 0,6,12,18 * * *'),0,'license_notify.csp','','license_notify',1),(3,'',CONCAT(FLOOR(RAND()*60), ' 14 * * *'),0,'grn_delete_user_data.csp','','grn_delete_user_data',1),(4,'',CONCAT(FLOOR(RAND()*60), ' 0 * * *'),0,'get_weather_data.csp','','grn_cbwebsrv_weather0',1),(5,'',CONCAT(FLOOR(RAND()*60), ' 6 * * *'),0,'get_weather_data.csp','','grn_cbwebsrv_weather1',1),(6,'',CONCAT(FLOOR(RAND()*60), ' 12 * * *'),0,'get_weather_data.csp','','grn_cbwebsrv_weather2',1),(7,'',CONCAT(FLOOR(RAND()*60), ' 18 * * *'),0,'get_weather_data.csp','','grn_cbwebsrv_weather3',1),(8,'',CONCAT(FLOOR(RAND()*60), ' 7 1 12 *'),0,'get_six_kinds_of_day_data.csp','','grn_cbwebsrv_six_kinds_of_day',1),(9,'',CONCAT(FLOOR(RAND()*60), ' 0,6,12,18 * * *'),0,'grn_rss_delete_caches.csp','','grn_rss_delete_caches',1),(10,'','* * * * *',0,'background_job_daemon.csp','','background_job_daemon',1);
/*!40000 ALTER TABLE `tab_cb_scheduleevent` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_cb_user` WRITE;
/*!40000 ALTER TABLE `tab_cb_user` DISABLE KEYS */;
INSERT INTO `tab_cb_user` (`_id`, `col_birthdate`, `col_ctime`, `col_deleted`, `col_description`, `col_display_name`, `col_display_name_language`, `col_email_address`, `col_employee_number`, `col_facsimile_number`, `col_family_name`, `col_foreign_key`, `col_given_name`, `col_initials`, `col_list_index`, `col_mtime`, `col_nickname`, `col_normalized_sort_key`, `col_password`, `col_physical_address`, `col_position`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_room_number`, `col_salt`, `col_sort_key`, `col_slash`, `col_slash_password`, `col_slash_salt`, `col_telephone_number`, `col_timezone`, `col_url`, `col_valid`) VALUES (1,NULL,UNIX_TIMESTAMP(),NULL,NULL,'Administrator',5,NULL,NULL,NULL,NULL,'Administrator',NULL,NULL,2147483647,UNIX_TIMESTAMP(),'Administrator',NULL,'43f8751c6f6ec086f0a47d079baba46e635c1fd0',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'FCNo',NULL,7532782697181632512,'941C5345A68D8BE2623272EA2A08AF4E92039635421582CC752765B348A59CE6','abcd',NULL,'Asia/Tokyo',NULL,NULL);
/*!40000 ALTER TABLE `tab_cb_user` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_cb_userrolerelation` WRITE;
/*!40000 ALTER TABLE `tab_cb_userrolerelation` DISABLE KEYS */;
INSERT INTO `tab_cb_userrolerelation` (`_id`, `col_role`, `col_role_list`, `col_user`, `col_user_list`) VALUES (1,1,1,1,2147483647);
/*!40000 ALTER TABLE `tab_cb_userrolerelation` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_access_abstractdata` WRITE;
/*!40000 ALTER TABLE `tab_grn_access_abstractdata` DISABLE KEYS */;
INSERT INTO `tab_grn_access_abstractdata` (`_id`, `col_security_model`, `col_unique_key`) VALUES (1,NULL,'prtl_myportal'),(2,NULL,'addr_available');
/*!40000 ALTER TABLE `tab_grn_access_abstractdata` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_applicationname` WRITE;
/*!40000 ALTER TABLE `tab_grn_applicationname` DISABLE KEYS */;
INSERT INTO `tab_grn_applicationname` (`_id`, `col_application`, `col_locale`, `col_name`) VALUES 
(1,'portal','ja','ポータル'),
(2,'portal','en','Portal'),
(3,'portal','zh','门户'),
(4,'link','ja','リンク集'),
(5,'link','en','Bookmarks'),
(6,'link','zh','书签'),
(7,'schedule','ja','スケジュール'),
(8,'schedule','en','Scheduler'),
(9,'schedule','zh','日程安排'),
(10,'message','ja','メッセージ'),
(11,'message','en','Messages'),
(12,'message','zh','站内信'),
(13,'bulletin','ja','掲示板'),
(14,'bulletin','en','Bulletin Board'),
(15,'bulletin','zh','公告栏'),
(16,'cabinet','ja','ファイル管理'),
(17,'cabinet','en','Cabinet'),
(18,'cabinet','zh','文件管理'),
(19,'memo','ja','メモ'),
(20,'memo','en','Memo'),
(21,'memo','zh','备忘录'),
(22,'phonemessage','ja','電話メモ'),
(23,'phonemessage','en','Phone Messages'),
(24,'phonemessage','zh','电话记录'),
(25,'timecard','ja','タイムカード'),
(26,'timecard','en','Timesheet'),
(27,'timecard','zh','考勤卡'),
(28,'todo','ja','ToDoリスト'),
(29,'todo','en','To-Do List'),
(30,'todo','zh','ToDo列表'),
(31,'address','ja','アドレス帳'),
(32,'address','en','Address Book'),
(33,'address','zh','通讯录'),
(34,'mail','ja','メール'),
(35,'mail','en','E-mail'),
(36,'mail','zh','E-mail'),
(37,'workflow','ja','ワークフロー'),
(38,'workflow','en','Workflow'),
(39,'workflow','zh','Workflow'),
(40,'report','ja','マルチレポート'),
(41,'report','en','MultiReport'),
(42,'report','zh','多功能报告'),
(43,'cbwebsrv','ja','ネット連携サービス'),
(44,'cbwebsrv','en','Cybozu Online Service'),
(45,'cbwebsrv','zh','网络整合服务'),
(46,'rss','ja','RSSリーダー'),
(47,'rss','en','RSS Reader'),
(48,'rss','zh','RSS阅读器'),
(52,'presence','ja','在席確認'),
(53,'presence','en','Presence indicators'),
(54,'presence','zh','在岗确认'),
(55,'star','ja','お気に入り'),
(56,'star','en','Favorite'),
(57,'star','zh','收藏夹'),
(58,'notification','ja','通知一覧'),
(59,'notification','en','Notifications'),
(60,'notification','zh','通知列表'),
(61,'cellular','ja','ケータイ'),
(62,'cellular','en','Keitai'),
(63,'cellular','zh','手机版'),
(67,'dezielink','ja','デヂエ連携'),
(68,'dezielink','en','Dezie Connector'),
(69,'dezielink','zh','Dezie整合'),
(72,'space', 'en', 'Space'),
(73,'space', 'ja', 'スペース'),
(74,'space', 'zh', '空间'),
(75,'favour','ja','いいね！'),
(76,'favour','en','Like'),
(77,'favour','zh','顶'),
(78,'portal','zh-tw','首頁'),
(79,'link','zh-tw','書籤'),
(80,'schedule','zh-tw','排程'),
(81,'message','zh-tw','站內信'),
(82,'bulletin','zh-tw','公告欄'),
(83,'cabinet','zh-tw','文件管理'),
(84,'memo','zh-tw','備忘錄'),
(85,'phonemessage','zh-tw','電話記錄'),
(86,'timecard','zh-tw','考勤卡'),
(87,'todo','zh-tw','ToDo列表'),
(88,'address','zh-tw','通訊錄'),
(89,'mail','zh-tw','E-mail'),
(90,'workflow','zh-tw','Workflow'),
(91,'report','zh-tw','多功能報告'),
(92,'cbwebsrv','zh-tw','網路整合服務'),
(93,'rss','zh-tw','RSS閱讀器'),
(94,'presence','zh-tw','在崗確認'),
(95,'star','zh-tw','我的最愛'),
(96,'notification','zh-tw','通知列表'),
(97,'cellular','zh-tw','手機版'),
(98,'dezielink','zh-tw','Dezie整合'),
(99,'space','zh-tw','社群'),
(100,'favour','zh-tw','頂')
;
/*!40000 ALTER TABLE `tab_grn_applicationname` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_authentication_login_authenticate` WRITE;
/*!40000 ALTER TABLE `tab_grn_authentication_login_authenticate` DISABLE KEYS */;
INSERT INTO `tab_grn_authentication_login_authenticate` (`col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_display_name`, `col_driver_settings`, `col_driver_type`, `col_is_active`, `col_list_index`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_repository`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_type`) VALUES (1,'Administrator','Administrator',UNIX_TIMESTAMP(),'','a:0:{}','grn.common.authentication.authenticate.default',1,1,1,'Administrator','Administrator',UNIX_TIMESTAMP(),1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'authenticate'),(1,'Administrator','Administrator',UNIX_TIMESTAMP(),'','a:0:{}','grn.common.authentication.login.default',1,2,1,'Administrator','Administrator',UNIX_TIMESTAMP(),1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'login'),(1,'Administrator','Administrator',UNIX_TIMESTAMP(),'ケータイ認証','a:0:{}','grn.common.authentication.login.cellular',0,7,1,'Administrator','Administrator',UNIX_TIMESTAMP(),1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'login'),(1,'Administrator','Administrator',UNIX_TIMESTAMP(),'ケータイ認証','a:0:{}','grn.common.authentication.authenticate.cellular',0,8,1,'Administrator','Administrator',UNIX_TIMESTAMP(),1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'authenticate');
/*!40000 ALTER TABLE `tab_grn_authentication_login_authenticate` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_authentication_repository` WRITE;
/*!40000 ALTER TABLE `tab_grn_authentication_repository` DISABLE KEYS */;
INSERT INTO `tab_grn_authentication_repository` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_display_name`, `col_driver_settings`, `col_driver_type`, `col_list_index`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`) VALUES (1,1,'Administrator','Administrator',UNIX_TIMESTAMP(),'','a:0:{}','grn.common.authentication.repository.default',1,1,'Administrator','Administrator',UNIX_TIMESTAMP(),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tab_grn_authentication_repository` ENABLE KEYS */;
UNLOCK TABLES;

/**
 * This NULL data was used for search. 
 * This data exists in past versions. 
 * When deleting this data, 
 * you must fix GRN_BULLETIN_NULL_OBJECT_ID in source codes. 
 */
LOCK TABLES `tab_grn_bulletin_articleentity` WRITE;
/*!40000 ALTER TABLE `tab_grn_bulletin_articleentity` DISABLE KEYS */;
INSERT INTO `tab_grn_bulletin_articleentity` (`_id`, `col_can_follow`, `col_category`, `col_creator`, `col_creator_foreign_key`, `col_creator_group`, `col_creator_name`, `col_ctime`, `col_data`, `col_dirty_timestamp`, `col_end_is_datetime`, `col_end_timestamp`, `col_html`, `col_last_follow_id`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_notifier`, `col_notifier_name`, `col_ntime`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_start_is_datetime`, `col_start_timestamp`, `col_subject`, `col_manually_enter_sender`) VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tab_grn_bulletin_articleentity` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_bulletin_categoryentity` WRITE;
/*!40000 ALTER TABLE `tab_grn_bulletin_categoryentity` DISABLE KEYS */;
INSERT INTO `tab_grn_bulletin_categoryentity` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_description`, `col_force_notify`, `col_foreign_key`, `col_list_index`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_name`, `col_parent`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_security_model`) VALUES (1,NULL,NULL,'Administrator',UNIX_TIMESTAMP(),NULL,NULL,'ROOT_CATEGORY',2147483647,NULL,NULL,'Administrator',UNIX_TIMESTAMP(),'ルート',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `tab_grn_bulletin_categoryentity` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_bulletin_categoryentity_acl_dynamic_role` WRITE;
/*!40000 ALTER TABLE `tab_grn_bulletin_categoryentity_acl_dynamic_role` DISABLE KEYS */;
INSERT INTO `tab_grn_bulletin_categoryentity_acl_dynamic_role` (`_id`, `col_authority_follow`, `col_authority_read`, `col_authority_write`, `col_object`, `col_target`) VALUES (1,0,1,0,1,'LoginUser');
/*!40000 ALTER TABLE `tab_grn_bulletin_categoryentity_acl_dynamic_role` ENABLE KEYS */;
UNLOCK TABLES;

/**
 * This NULL data was used for search. 
 * This data exists in past versions. 
 * When deleting this data, 
 * you must fix GRN_BULLETIN_NULL_OBJECT_ID in source codes. 
 */
LOCK TABLES `tab_grn_bulletin_followentity` WRITE;
/*!40000 ALTER TABLE `tab_grn_bulletin_followentity` DISABLE KEYS */;
INSERT INTO `tab_grn_bulletin_followentity` (`_id`, `col_article`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_data`, `col_follow_id`, `col_html`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`) VALUES (1,1,NULL,NULL,NULL,2147483647,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tab_grn_bulletin_followentity` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_cabinet_folderentity` WRITE;
/*!40000 ALTER TABLE `tab_grn_cabinet_folderentity` DISABLE KEYS */;
INSERT INTO `tab_grn_cabinet_folderentity` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_description`, `col_force_notify`, `col_foreign_key`, `col_list_index`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_name`, `col_parent`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_security_model`) VALUES (1,NULL,NULL,'Administrator',UNIX_TIMESTAMP(),NULL,NULL,'ROOT_FOLDER',2147483647,NULL,NULL,'Administrator',UNIX_TIMESTAMP(),'ルート',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `tab_grn_cabinet_folderentity` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_cabinet_folderentity_acl_dynamic_role` WRITE;
/*!40000 ALTER TABLE `tab_grn_cabinet_folderentity_acl_dynamic_role` DISABLE KEYS */;
INSERT INTO `tab_grn_cabinet_folderentity_acl_dynamic_role` (`_id`, `col_authority_read`, `col_authority_write`, `col_object`, `col_target`) VALUES (1,1,0,1,'LoginUser');
/*!40000 ALTER TABLE `tab_grn_cabinet_folderentity_acl_dynamic_role` ENABLE KEYS */;
UNLOCK TABLES;

/**
 * Default NULL customer information.
 */
LOCK TABLES `tab_grn_customerinfo` WRITE;
/*!40000 ALTER TABLE `tab_grn_customerinfo` DISABLE KEYS */;
INSERT INTO `tab_grn_customerinfo` (`_id`, `col_company_name`, `col_company_name2`, `col_customer_id`, `col_logo_file`, `col_logo_path`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`) VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tab_grn_customerinfo` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_link_personal_category` WRITE;
/*!40000 ALTER TABLE `tab_grn_link_personal_category` DISABLE KEYS */;
INSERT INTO `tab_grn_link_personal_category` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_foreign_key`, `col_list_index`, `col_memo`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_name`, `col_parent`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_user`) VALUES (1,1,NULL,NULL,UNIX_TIMESTAMP(),'ROOT_CATEGORY',0,NULL,1,NULL,NULL,UNIX_TIMESTAMP(),'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `tab_grn_link_personal_category` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_link_system_category` WRITE;
/*!40000 ALTER TABLE `tab_grn_link_system_category` DISABLE KEYS */;
INSERT INTO `tab_grn_link_system_category` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_foreign_key`, `col_list_index`, `col_memo`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_name`, `col_parent`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_security_model`) VALUES (1,1,NULL,NULL,UNIX_TIMESTAMP(),'ROOT_CATEGORY',0,NULL,1,NULL,NULL,UNIX_TIMESTAMP(),'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tab_grn_link_system_category` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_mail_status` WRITE;
/*!40000 ALTER TABLE `tab_grn_mail_status` DISABLE KEYS */;
INSERT INTO `tab_grn_mail_status` (`_id`, `col_code`, `col_color`, `col_name`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_text1`, `col_reserve_text2`, `col_type`, `col_user`) VALUES (1,'default','000000',NULL,NULL,NULL,NULL,NULL,'1',NULL),(2,'unattended','FF0000',NULL,NULL,NULL,NULL,NULL,'1',NULL),(3,'need_reply','008800',NULL,NULL,NULL,NULL,NULL,'1',NULL),(4,'attended','888888',NULL,NULL,NULL,NULL,NULL,'1',NULL),(5,'pending','880088',NULL,NULL,NULL,NULL,NULL,'1',NULL),(6,'wait_sending','888800',NULL,NULL,NULL,NULL,NULL,'1',NULL);
/*!40000 ALTER TABLE `tab_grn_mail_status` ENABLE KEYS */;
UNLOCK TABLES;

/**
 * This NULL data was used for search. 
 * This data exists in past versions. 
 * When deleting this data, 
 * you must fix GRN_MESSAGE_DUMMY_FOLLOW_ID in source codes. 
 */
LOCK TABLES `tab_grn_message_follows` WRITE;
/*!40000 ALTER TABLE `tab_grn_message_follows` DISABLE KEYS */;
INSERT INTO `tab_grn_message_follows` (`_id`, `col_creator`, `col_creator_name`, `col_ctime`, `col_data`, `col_html_data`, `col_id`, `col_message`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`) VALUES (1,NULL,'',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tab_grn_message_follows` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_message_messages_sequence` WRITE;
/*!40000 ALTER TABLE `tab_grn_message_messages_sequence` DISABLE KEYS */;
INSERT INTO `tab_grn_message_messages_sequence` (`col_next_id`) VALUES (1);
/*!40000 ALTER TABLE `tab_grn_message_messages_sequence` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_mimetype` WRITE;
/*!40000 ALTER TABLE `tab_grn_mimetype` DISABLE KEYS */;
INSERT INTO `tab_grn_mimetype` (`_id`, `col_extension`, `col_mime`) VALUES (1,'txt','text/plain'),(2,'html','text/html'),(3,'htm','text/html'),(4,'xml','text/xml'),(5,'xsl','text/xml'),(6,'gif','image/gif'),(7,'jpeg','image/jpeg'),(8,'jpg','image/jpeg'),(9,'jpe','image/jpeg'),(10,'png','image/png'),(11,'tiff','image/tiff'),(12,'tif','image/tif'),(13,'bmp','image/bmp'),(14,'doc','application/msword'),(15,'xls','application/vnd.ms-excel'),(16,'ppt','application/vnd.ms-powerpoint'),(17,'exe','application/x-msdownload'),(18,'zip','application/x-zip-compressed'),(19,'mp3','audio/mpeg'),(20,'ram','audio/x-pn-realaudio'),(21,'mid','audio/midi'),(22,'wav','audio/x-wav'),(23,'mpeg','video/mpeg'),(24,'docx','application/vnd.openxmlformats-officedocument.wordprocessingml.document'),(25,'docm','application/vnd.ms-word.document.macroEnabled.12'),(26,'xlsx','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),(27,'xlsm','application/vnd.ms-excel.sheet.macroEnabled.12'),(28,'pptx','application/vnd.openxmlformats-officedocument.presentationml.presentation'),(29,'pptm','application/vnd.ms-powerpoint.presentation.macroEnabled.12'),(30,'pdf','application/pdf');
/*!40000 ALTER TABLE `tab_grn_mimetype` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_notification_applicationid` WRITE;
/*!40000 ALTER TABLE `tab_grn_notification_applicationid` DISABLE KEYS */;
INSERT INTO `tab_grn_notification_applicationid` (`_id`, `col_application`, `col_id`, `col_urls`) VALUES (1,'1','Cybozu Information','');
/*!40000 ALTER TABLE `tab_grn_notification_applicationid` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_notification_applicationname` WRITE;
/*!40000 ALTER TABLE `tab_grn_notification_applicationname` DISABLE KEYS */;
INSERT INTO `tab_grn_notification_applicationname` (`_id`, `col_application`, `col_locale`, `col_name`) VALUES (1,1,'ja','サイボウズからのお知らせ');
/*!40000 ALTER TABLE `tab_grn_notification_applicationname` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_report_category` WRITE;
/*!40000 ALTER TABLE `tab_grn_report_category` DISABLE KEYS */;
INSERT INTO `tab_grn_report_category` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_foreign_key`, `col_list_index`, `col_memo`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_name`, `col_parent`, `col_public_security_model`, `col_security_model`) VALUES (1,1,'Administrator','Administrator',UNIX_TIMESTAMP(),'ROOT_CATEGORY',0,NULL,1,'Administrator','Administrator',UNIX_TIMESTAMP(),'(root)',NULL,NULL,1);
/*!40000 ALTER TABLE `tab_grn_report_category` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_roleinfo` WRITE;
/*!40000 ALTER TABLE `tab_grn_roleinfo` DISABLE KEYS */;
INSERT INTO `tab_grn_roleinfo` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_role`) VALUES (1,NULL,NULL,NULL,UNIX_TIMESTAMP(),NULL,NULL,NULL,UNIX_TIMESTAMP(),1);
/*!40000 ALTER TABLE `tab_grn_roleinfo` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_rss_channel` WRITE;
/*!40000 ALTER TABLE `tab_grn_rss_channel` DISABLE KEYS */;
INSERT INTO `tab_grn_rss_channel` (`_id`, `col_channel_url`, `col_description`, `col_error_code`, `col_hash`, `col_id`, `col_last_modified`, `col_ptime`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_title`, `col_type`, `col_user_num`, `col_utime`) VALUES (1,NULL,NULL,NULL,'00c303e90cc7f16b7928083b81176c17816ef1ca','http://news.cybozu.co.jp/rss/use2.rdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'サイボウズからのお知らせ',1,NULL,NULL),(2,NULL,NULL,NULL,'d60ba372bafa739c1f696d77dbd354c441f17e44','http://news.cybozu.co.jp/rss/use3.rdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'サイボウズからのお知らせ',1,NULL,NULL),(3,NULL,NULL,NULL,'c0dfc87ea67dcc1ecc4e723af07e6bf4bee7160f','http://news.cybozu.co.jp/rss/use1.rdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'サイボウズからのお知らせ',1,NULL,NULL);
/*!40000 ALTER TABLE `tab_grn_rss_channel` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_rss_sharedfolder` WRITE;
/*!40000 ALTER TABLE `tab_grn_rss_sharedfolder` DISABLE KEYS */;
INSERT INTO `tab_grn_rss_sharedfolder` (`_id`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_title`) VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,'shared_root');
/*!40000 ALTER TABLE `tab_grn_rss_sharedfolder` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_schedule_event_sequence` WRITE;
/*!40000 ALTER TABLE `tab_grn_schedule_event_sequence` DISABLE KEYS */;
INSERT INTO `tab_grn_schedule_event_sequence` (`_id`) VALUES (0);
/*!40000 ALTER TABLE `tab_grn_schedule_event_sequence` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_sso_user` WRITE;
/*!40000 ALTER TABLE `tab_grn_sso_user` DISABLE KEYS */;
INSERT INTO `tab_grn_sso_user` (`_id`, `col_credential`, `col_reserve_blob1`, `col_reserve_blob2`, `col_reserve_blob3`, `col_reserve_int1`, `col_reserve_int2`, `col_reserve_int3`, `col_reserve_text1`, `col_reserve_text2`, `col_reserve_text3`, `col_user`) VALUES (1,'RbRfuoaVSRwPPL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `tab_grn_sso_user` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_systemcalendar` WRITE;
/*!40000 ALTER TABLE `tab_grn_systemcalendar` DISABLE KEYS */;
INSERT INTO `tab_grn_systemcalendar` (`_id`, `col_code`, `col_name`) VALUES (1,'default','default');
/*!40000 ALTER TABLE `tab_grn_systemcalendar` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_userinfo` WRITE;
/*!40000 ALTER TABLE `tab_grn_userinfo` DISABLE KEYS */;
INSERT INTO `tab_grn_userinfo` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_image`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_password_expired`, `col_post`, `col_primary_group`, `col_user`) VALUES (1,NULL,NULL,NULL,UNIX_TIMESTAMP(),NULL,NULL,NULL,NULL,UNIX_TIMESTAMP(),NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `tab_grn_userinfo` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_workflow_category` WRITE;
/*!40000 ALTER TABLE `tab_grn_workflow_category` DISABLE KEYS */;
INSERT INTO `tab_grn_workflow_category` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_foreign_key`, `col_list_index`, `col_memo`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_name`, `col_parent`, `col_public_security_model`, `col_security_model`) VALUES (1,1,'Administrator','Administrator',UNIX_TIMESTAMP(),'ROOT_CATEGORY',0,NULL,1,'Administrator','Administrator',UNIX_TIMESTAMP(),'(root)',NULL,NULL,NULL);
/*!40000 ALTER TABLE `tab_grn_workflow_category` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `tab_grn_workflow_folder` WRITE;
/*!40000 ALTER TABLE `tab_grn_workflow_folder` DISABLE KEYS */;
INSERT INTO `tab_grn_workflow_folder` (`_id`, `col_creator`, `col_creator_foreign_key`, `col_creator_name`, `col_ctime`, `col_folder_type`, `col_foreign_key`, `col_list_index`, `col_memo`, `col_modifier`, `col_modifier_foreign_key`, `col_modifier_name`, `col_mtime`, `col_name`, `col_parent`, `col_user`) VALUES (1,NULL,NULL,NULL,NULL,'0','ROOT_FOLDER_FOREIGN_KEY',0,NULL,NULL,NULL,NULL,NULL,'(root)',NULL,NULL);
/*!40000 ALTER TABLE `tab_grn_workflow_folder` ENABLE KEYS */;
UNLOCK TABLES;

/* Data for Space application start */
INSERT INTO tab_grn_space_space_sequence VALUES (0);
INSERT INTO tab_grn_space_thread_sequence VALUES (0);
INSERT INTO tab_grn_space_todo_sequence VALUES (0);

INSERT INTO tab_grn_space_application SET
  _id = 1,
  col_application_code = "jp.co.cybozu.garoon350.discussion",
  col_application_name = "discussion",
  col_is_available = true, 
  col_application_type = "0",
  col_is_system_use = false,
  col_is_forced_use = true,
  col_creator = 1,
  col_create_timestamp = UNIX_TIMESTAMP(),
  col_modifier = 1,
  col_modify_timestamp = UNIX_TIMESTAMP();

INSERT INTO tab_grn_space_application SET
 _id = 2,
  col_application_code = "jp.co.cybozu.garoon350.todo",
  col_application_name = "todo",
  col_is_available = true, 
  col_application_type = "0",
  col_is_system_use = false,
  col_is_forced_use = false,
  col_creator = 1,
  col_create_timestamp = UNIX_TIMESTAMP(),
  col_modifier = 1,
  col_modify_timestamp = UNIX_TIMESTAMP();

INSERT INTO tab_grn_space_application SET
 _id = 3,
  col_application_code = "jp.co.cybozu.garoon350.comment",
  col_application_name = "comment",
  col_is_available = true, 
  col_application_type = "0",
  col_is_system_use = true,
  col_is_forced_use = true,
  col_creator = 1,
  col_create_timestamp = UNIX_TIMESTAMP(),
  col_modifier = 1,
  col_modify_timestamp = UNIX_TIMESTAMP();

INSERT INTO tab_grn_space_application_local 
    (col_application, col_language, col_application_name)
    VALUES
    (1, 4, 'ディスカッション'),
    (1, 5, 'Discussions'),
    (1, 6, '讨论区'),
    (1, 7, '討論區'),
    (2, 4, '共有ToDo'),
    (2, 5, 'Shared To-Dos'),
    (2, 6, '共享ToDo'),
    (2, 7, '共用ToDo');

INSERT INTO tab_grn_space_category SET 
  _id = 1,
  col_category_code = "jp.co.cybozu.garoon350.space.root",
  col_category_name = "root",
  col_hierarchy_level = 1,
  col_is_system_use = 1,
  col_display_order = '100',
  col_creator = 1,
  col_create_timestamp = UNIX_TIMESTAMP(),
  col_modifier = 1,
  col_modify_timestamp = UNIX_TIMESTAMP();

INSERT INTO tab_grn_space_category_hierarchy SET
  col_category = 1,
  col_ancestor = 1;

INSERT INTO tab_grn_space_category SET 
  _id = 2,
  col_category_code = "default_space_category",
  col_category_name = "General",
  col_parent = 1,
  col_hierarchy_level = 2,
  col_is_system_use = 0,
  col_display_order = '100',
  col_creator = 1,
  col_create_timestamp = UNIX_TIMESTAMP(),
  col_modifier = 1,
  col_modify_timestamp = UNIX_TIMESTAMP();

INSERT INTO tab_grn_space_category_local SET
  col_category = 2,
  col_language = 4,
  col_category_name = '全般';

INSERT INTO tab_grn_space_category_local SET
  col_category = 2,
  col_language = 5,
  col_category_name = 'General';

INSERT INTO tab_grn_space_category_local SET
  col_category = 2,
  col_language = 6,
  col_category_name = '一般';

INSERT INTO tab_grn_space_category_local SET
  col_category = 2,
  col_language = 7,
  col_category_name = '一般';

INSERT INTO tab_grn_space_category_hierarchy SET 
  col_category = 2,
  col_ancestor = 1;

INSERT INTO tab_grn_space_category_hierarchy SET 
  col_category = 2,
  col_ancestor = 2;

INSERT INTO tab_grn_space_dynamic_role SET
  col_dynamic_role_code = "everyone",
  col_dynamic_role_name = "Everyone",
  col_display_order=100;

INSERT INTO tab_grn_space_dynamic_role SET
  col_dynamic_role_code = "loginuser",
  col_dynamic_role_name = "LoginUser",
  col_display_order=200;

INSERT INTO tab_grn_space_authority SET
  col_authority_code = "read_summary",
  col_authority_name = "READ_SUMMARY";

INSERT INTO tab_grn_space_authority SET
  col_authority_code = "read_detail",
  col_authority_name = "READ_DETAIL";

INSERT INTO tab_grn_space_authority SET
  col_authority_code = "write",
  col_authority_name = "WRITE";

INSERT INTO tab_grn_space_authority SET
  col_authority_code = "system_privilege",
  col_authority_name = "SYSTEM PRIVILEGE";

INSERT INTO tab_grn_space_authority SET
  col_authority_code = "operation_privilege",
  col_authority_name = "OPERATION PRIVILEGE";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_graph64",
  col_name = "spaceId_graph64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_graph64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_chart64",
  col_name = "spaceId_chart64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_chart64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_plan64",
  col_name = "spaceId_plan64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_plan64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_report64",
  col_name = "spaceId_report64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_report64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_cabinet64",
  col_name = "spaceId_cabinet64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_cabinet64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_idea64",
  col_name = "spaceId_idea64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_idea64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_inspiration64",
  col_name = "spaceId_inspiration64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_inspiration64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_lab64",
  col_name = "spaceId_lab64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_lab64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_global64",
  col_name = "spaceId_global64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_global64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_aim64",
  col_name = "spaceId_aim64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_aim64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_organization64",
  col_name = "spaceId_organization64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_organization64.png";

INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_user64",
  col_name = "spaceId_user64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_user64.png";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_support64",
  col_name = "spaceId_support64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_support64.png";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_office64",
  col_name = "spaceId_office64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_office64.png";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_factory64",
  col_name = "spaceId_factory64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_factory64.png";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_shop64",
  col_name = "spaceId_shop64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_shop64.png";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_beginning64",
  col_name = "spaceId_beginning64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_beginning64.png";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_profit64",
  col_name = "spaceId_profit64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_profit64.png";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_award64",
  col_name = "spaceId_award64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_award64.png";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = "spaceId_music64",
  col_name = "spaceId_music64",
  col_file_name = "grn/image/cybozu/image-app-space/icons/spaceId_music64.png";
  
INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_021_64',
  col_name = 'spaceId_021_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_021_64.png';  

INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_022_64',
  col_name = 'spaceId_022_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_022_64.png';  

INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_023_64',
  col_name = 'spaceId_023_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_023_64.png';  

INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_024_64',
  col_name = 'spaceId_024_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_024_64.png';  

INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_025_64',
  col_name = 'spaceId_025_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_025_64.png';  

INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_026_64',
  col_name = 'spaceId_026_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_026_64.png';  

INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_027_64',
  col_name = 'spaceId_027_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_027_64.png';  

INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_028_64',
  col_name = 'spaceId_028_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_028_64.png';  

INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_029_64',
  col_name = 'spaceId_029_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_029_64.png';  

INSERT INTO tab_grn_space_icon SET
  col_icon_code = 'spaceId_030_64',
  col_name = 'spaceId_030_64',
  col_file_name = 'grn/image/cybozu/image-app-space/icons/spaceId_030_64.png';  

/* Data for Space application end */

/* GRREQ-151 */
LOCK TABLES `tab_grn_kunai_availability_dynamic_role` WRITE;
/*!40000 ALTER TABLE `tab_grn_kunai_availability_dynamic_role` DISABLE KEYS */;
INSERT INTO `tab_grn_kunai_availability_dynamic_role` (`col_ctime`, `col_dynamic_role`, `col_app_status`) VALUES (UNIX_TIMESTAMP(),'Everyone','a:5:{s:8:\"schedule\";b:1;s:7:\"message\";b:1;s:8:\"workflow\";b:1;s:4:\"mail\";b:1;s:7:\"address\";b:1;}');
/*!40000 ALTER TABLE `tab_grn_kunai_availability_dynamic_role` ENABLE KEYS */;
UNLOCK TABLES;

/* GTM-529 START */
LOCK TABLES `tab_grn_availability_dynamic_role` WRITE;
/*!40000 ALTER TABLE `tab_grn_availability_dynamic_role` DISABLE KEYS */;
INSERT INTO `tab_grn_availability_dynamic_role`(`col_ctime`, `col_dynamic_role`, `col_app`) VALUES (UNIX_TIMESTAMP(), 'Everyone', '{"availability":{"space":{"internal":1,"external":1},"link":{"internal":1,"external":1},"schedule":{"internal":1,"external":1},"message":{"internal":1,"external":1},"bulletin":{"internal":1,"external":1},"cabinet":{"internal":1,"external":1},"phonemessage":{"internal":1,"external":1},"timecard":{"internal":1,"external":1},"address":{"internal":1,"external":1},"mail":{"internal":1,"external":1},"workflow":{"internal":1,"external":1},"report":{"internal":1,"external":1},"cellular":{"internal":1,"external":1}}}');
/*!40000 ALTER TABLE `tab_grn_availability_dynamic_role` ENABLE KEYS */;
UNLOCK TABLES;
/* GTM-529 END */

/* Finalization */
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET SQL_NOTES=@OLD_SQL_NOTES;
