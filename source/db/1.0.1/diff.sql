/* Garoon DDL */

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

/* GRN35-318 Add a column space_id and a column sub_module_id to tables relating to the notification */
ALTER TABLE tab_grn_notification_history___p0 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p1 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p10 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p11 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p12 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p13 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p14 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p15 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p16 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p17 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p18 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p19 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p2 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p20 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p21 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p22 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p23 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p24 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p25 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p26 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p27 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p28 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p29 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p3 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p30 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p31 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p32 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p33 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p34 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p35 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p36 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p37 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p38 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p39 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p4 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p40 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p41 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p42 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p43 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p44 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p45 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p46 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p47 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p48 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p49 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p5 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p6 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p7 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p8 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p9 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p0 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p1 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p10 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p11 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p12 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p13 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p14 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p15 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p16 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p17 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p18 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p19 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p2 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p20 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p21 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p22 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p23 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p24 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p25 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p26 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p27 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p28 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p29 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p3 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p30 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p31 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p32 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p33 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p34 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p35 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p36 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p37 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p38 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p39 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p4 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p40 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p41 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p42 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p43 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p44 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p45 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p46 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p47 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p48 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p49 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p5 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p6 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p7 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p8 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_notify___p9 ADD (col_sub_module_id char(64) COLLATE utf8mb4_bin NOT NULL, col_space_id int(11) DEFAULT NULL, col_space_name varchar(255) DEFAULT NULL, col_event_start_ts int(11) DEFAULT NULL);
ALTER TABLE tab_grn_notification_history___p0 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p0 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p0 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p0 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p0 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p1 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p1 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p1 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p1 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p1 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p2 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p2 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p2 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p2 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p2 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p3 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p3 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p3 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p3 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p3 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p4 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p4 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p4 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p4 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p4 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p5 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p5 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p5 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p5 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p5 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p6 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p6 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p6 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p6 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p6 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p7 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p7 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p7 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p7 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p7 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p8 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p8 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p8 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p8 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p8 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p9 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p9 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p9 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p9 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p9 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p10 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p10 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p10 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p10 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p10 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p11 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p11 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p11 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p11 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p11 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p12 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p12 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p12 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p12 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p12 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p13 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p13 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p13 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p13 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p13 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p14 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p14 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p14 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p14 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p14 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p15 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p15 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p15 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p15 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p15 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p16 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p16 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p16 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p16 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p16 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p17 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p17 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p17 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p17 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p17 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p18 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p18 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p18 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p18 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p18 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p19 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p19 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p19 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p19 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p19 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p20 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p20 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p20 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p20 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p20 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p21 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p21 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p21 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p21 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p21 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p22 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p22 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p22 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p22 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p22 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p23 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p23 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p23 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p23 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p23 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p24 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p24 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p24 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p24 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p24 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p25 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p25 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p25 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p25 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p25 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p26 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p26 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p26 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p26 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p26 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p27 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p27 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p27 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p27 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p27 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p28 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p28 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p28 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p28 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p28 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p29 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p29 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p29 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p29 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p29 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p30 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p30 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p30 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p30 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p30 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p31 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p31 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p31 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p31 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p31 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p32 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p32 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p32 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p32 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p32 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p33 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p33 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p33 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p33 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p33 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p34 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p34 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p34 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p34 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p34 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p35 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p35 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p35 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p35 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p35 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p36 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p36 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p36 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p36 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p36 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p37 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p37 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p37 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p37 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p37 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p38 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p38 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p38 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p38 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p38 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p39 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p39 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p39 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p39 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p39 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p40 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p40 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p40 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p40 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p40 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p41 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p41 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p41 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p41 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p41 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p42 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p42 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p42 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p42 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p42 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p43 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p43 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p43 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p43 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p43 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p44 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p44 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p44 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p44 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p44 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p45 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p45 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p45 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p45 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p45 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p46 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p46 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p46 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p46 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p46 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p47 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p47 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p47 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p47 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p47 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p48 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p48 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p48 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p48 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p48 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_history___p49 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_history___p49 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_history___p49 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_history___p49 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_history___p49 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p0 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p0 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p0 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p0 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p0 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p1 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p1 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p1 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p1 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p1 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p2 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p2 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p2 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p2 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p2 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p3 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p3 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p3 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p3 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p3 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p4 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p4 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p4 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p4 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p4 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p5 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p5 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p5 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p5 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p5 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p6 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p6 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p6 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p6 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p6 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p7 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p7 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p7 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p7 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p7 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p8 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p8 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p8 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p8 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p8 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p9 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p9 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p9 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p9 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p9 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p10 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p10 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p10 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p10 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p10 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p11 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p11 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p11 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p11 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p11 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p12 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p12 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p12 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p12 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p12 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p13 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p13 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p13 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p13 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p13 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p14 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p14 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p14 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p14 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p14 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p15 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p15 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p15 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p15 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p15 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p16 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p16 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p16 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p16 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p16 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p17 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p17 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p17 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p17 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p17 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p18 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p18 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p18 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p18 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p18 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p19 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p19 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p19 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p19 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p19 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p20 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p20 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p20 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p20 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p20 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p21 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p21 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p21 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p21 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p21 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p22 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p22 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p22 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p22 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p22 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p23 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p23 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p23 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p23 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p23 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p24 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p24 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p24 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p24 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p24 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p25 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p25 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p25 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p25 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p25 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p26 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p26 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p26 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p26 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p26 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p27 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p27 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p27 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p27 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p27 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p28 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p28 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p28 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p28 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p28 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p29 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p29 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p29 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p29 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p29 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p30 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p30 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p30 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p30 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p30 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p31 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p31 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p31 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p31 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p31 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p32 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p32 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p32 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p32 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p32 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p33 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p33 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p33 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p33 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p33 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p34 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p34 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p34 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p34 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p34 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p35 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p35 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p35 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p35 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p35 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p36 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p36 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p36 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p36 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p36 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p37 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p37 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p37 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p37 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p37 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p38 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p38 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p38 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p38 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p38 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p39 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p39 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p39 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p39 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p39 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p40 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p40 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p40 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p40 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p40 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p41 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p41 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p41 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p41 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p41 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p42 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p42 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p42 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p42 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p42 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p43 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p43 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p43 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p43 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p43 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p44 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p44 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p44 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p44 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p44 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p45 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p45 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p45 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p45 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p45 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p46 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p46 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p46 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p46 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p46 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p47 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p47 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p47 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p47 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p47 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p48 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p48 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p48 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p48 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p48 ADD INDEX idx_spaceid(`col_space_id`);
ALTER TABLE tab_grn_notification_notify___p49 DROP INDEX idx_unique_id_module_user;
ALTER TABLE tab_grn_notification_notify___p49 DROP INDEX idx_user_module_unique_id;
ALTER TABLE tab_grn_notification_notify___p49 ADD UNIQUE idx_unique_id_module_user(`col_unique_id`,`col_module_id`,`col_sub_module_id`,`col_user`);
ALTER TABLE tab_grn_notification_notify___p49 ADD UNIQUE idx_user_module_unique_id(`col_user`,`col_module_id`,`col_sub_module_id`,`col_unique_id`);
ALTER TABLE tab_grn_notification_notify___p49 ADD INDEX idx_spaceid(`col_space_id`);

/* For Space Application start */

/* ###########################   000 common  #################################### */

CREATE TABLE tab_grn_space_dynamic_role(
  _id                         bigint(20)   NOT NULL AUTO_INCREMENT,

  col_dynamic_role_code         varchar(128)  NOT NULL,
  col_dynamic_role_name         varchar(128)  NOT NULL,
  col_display_order             int(11) NOT NULL,

  PRIMARY KEY(_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_icon(
  _id             bigint(20)   NOT NULL AUTO_INCREMENT,
  col_icon_code   varchar(128) NOT NULL,
  col_name        varchar(128) NOT NULL,
  col_file_name   varchar(128) NOT NULL,

  PRIMARY KEY(_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;



/* ###########################   001 authority  #################################### */
CREATE TABLE tab_grn_space_authority(
  _id                         bigint(20)   NOT NULL AUTO_INCREMENT,

  col_authority_code         varchar(128)  NOT NULL,
  col_authority_name         varchar(128)  NOT NULL,

  PRIMARY KEY(_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
CREATE TABLE tab_grn_space_access_control_list(
  _id                         bigint(20)   NOT NULL AUTO_INCREMENT,

  col_authority                bigint(20)   NOT NULL,

  PRIMARY KEY(_id),

  CONSTRAINT cns_grn_space_acl_authority  FOREIGN KEY (col_authority)  REFERENCES tab_grn_space_authority (_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_acl_dynamic_role(
  col_acl                  bigint(20)   NOT NULL,
  col_dynamic_role         bigint(20)   NOT NULL,

  PRIMARY KEY(col_acl, col_dynamic_role),

  CONSTRAINT cns_grn_space_acl_dynamic_role_acl FOREIGN KEY(col_acl) REFERENCES tab_grn_space_access_control_list(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_acl_dynamic_role_dynamic_role FOREIGN KEY(col_dynamic_role) REFERENCES tab_grn_space_dynamic_role(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
CREATE TABLE tab_grn_space_acl_role(
  col_acl                  bigint(20)   NOT NULL,
  col_role                 bigint(20)   NOT NULL,

  PRIMARY KEY(col_acl, col_role),

  CONSTRAINT cns_grn_space_acl_role_acl FOREIGN KEY(col_acl) REFERENCES tab_grn_space_access_control_list(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_acl_role_role FOREIGN KEY(col_role) REFERENCES tab_cb_role(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
CREATE TABLE tab_grn_space_acl_group(
  col_acl                  bigint(20)   NOT NULL,
  col_group                bigint(20)   NOT NULL,

  PRIMARY KEY(col_acl, col_group),

  CONSTRAINT cns_grn_space_acl_group_acl FOREIGN KEY(col_acl) REFERENCES tab_grn_space_access_control_list(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_acl_group_group FOREIGN KEY(col_group) REFERENCES tab_cb_group(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
CREATE TABLE tab_grn_space_acl_user(
  col_acl                  bigint(20)   NOT NULL,
  col_user                 bigint(20)   NOT NULL,

  PRIMARY KEY(col_acl, col_user),

  CONSTRAINT cns_grn_space_acl_user_acl FOREIGN KEY(col_acl) REFERENCES tab_grn_space_access_control_list(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_acl_user_user FOREIGN KEY(col_user) REFERENCES tab_cb_user(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;





/* ###########################   002 notification  #################################### */
CREATE TABLE tab_grn_space_notification(
  _id                         bigint(20)   NOT NULL AUTO_INCREMENT,

  col_is_forced_notification  boolean      NOT NULL,

  PRIMARY KEY(_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_notification_dynamic_role(
  col_notification                  bigint(20)   NOT NULL,
  col_dynamic_role         bigint(20)   NOT NULL,

  PRIMARY KEY(col_notification, col_dynamic_role),

  CONSTRAINT cns_grn_space_notification_dynamic_role_notification FOREIGN KEY(col_notification) REFERENCES tab_grn_space_notification(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_notification_dynamic_role_dynamic_role FOREIGN KEY(col_dynamic_role) REFERENCES tab_grn_space_dynamic_role(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_notification_role(
  col_notification                  bigint(20)   NOT NULL,
  col_role                 bigint(20)   NOT NULL,

  PRIMARY KEY(col_notification, col_role),

  CONSTRAINT cns_grn_space_notification_role_notification FOREIGN KEY(col_notification) REFERENCES tab_grn_space_notification(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_notification_role_role FOREIGN KEY(col_role) REFERENCES tab_cb_role(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_notification_group(
  col_notification                  bigint(20)   NOT NULL,
  col_group                bigint(20)   NOT NULL,

  PRIMARY KEY(col_notification, col_group),

  CONSTRAINT cns_grn_space_notification_group_notification FOREIGN KEY(col_notification) REFERENCES tab_grn_space_notification(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_notification_group_group FOREIGN KEY(col_group) REFERENCES tab_cb_group(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_notification_user(
  col_notification                  bigint(20)   NOT NULL,
  col_user                 bigint(20)   NOT NULL,

  PRIMARY KEY(col_notification, col_user),

  CONSTRAINT cns_grn_space_notification_user_notification FOREIGN KEY(col_notification) REFERENCES tab_grn_space_notification(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_notification_user_user FOREIGN KEY(col_user) REFERENCES tab_cb_user(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_non_notification_user(
  col_notification                  bigint(20)   NOT NULL,
  col_user                 bigint(20)   NOT NULL,

  PRIMARY KEY(col_notification, col_user),

  CONSTRAINT cns_grn_space_non_notification_user_notification FOREIGN KEY(col_notification) REFERENCES tab_grn_space_notification(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_non_notification_user_user FOREIGN KEY(col_user) REFERENCES tab_cb_user(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;



/* ###########################   003 category  #################################### */

CREATE TABLE tab_grn_space_category(
  _id                     bigint(20)   NOT NULL AUTO_INCREMENT,

  col_category_code       varchar(128) NOT NULL,
  col_category_name       varchar(128) NOT NULL,
  col_memo                longtext     NOT NULL,
  col_hierarchy_level     int(11)      NOT NULL,
  col_parent              bigint(20)   DEFAULT NULL,
  col_is_system_use       boolean      NOT NULL,
  col_display_order       int(11)      NOT NULL,
  col_creator             bigint(20)   DEFAULT NULL,
  col_creator_name        char(100)    NOT NULL,
  col_create_timestamp    int(11)      NOT NULL,
  col_modifier            bigint(20)   DEFAULT NULL,
  col_modifier_name       char(100)    NOT NULL,
  col_modify_timestamp    int(11)      DEFAULT NULL,

  PRIMARY KEY(_id),
  KEY(col_category_code),
  KEY(col_parent, col_display_order),

  CONSTRAINT cns_grn_space_category_parent    FOREIGN KEY (col_parent)    REFERENCES tab_grn_space_category (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_category_creator   FOREIGN KEY (col_creator)   REFERENCES tab_cb_user (_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_category_modifier  FOREIGN KEY (col_modifier)  REFERENCES tab_cb_user (_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_category_local(
  col_category     bigint(20) NOT NULL,
  col_language  bigint(20) NOT NULL,
  col_category_name varchar(128) NOT NULL,

  PRIMARY KEY(col_category, col_language),

  CONSTRAINT cns_grn_space_category_local_category FOREIGN KEY (col_category) REFERENCES tab_grn_space_category(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_category_local_language FOREIGN KEY (col_language) REFERENCES tab_cb_language_status(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


CREATE TABLE tab_grn_space_category_hierarchy (
  col_category        bigint(20) NOT NULL,
  col_ancestor        bigint(20) NOT NULL,

  PRIMARY KEY(col_category, col_ancestor),

  CONSTRAINT cns_grn_category_hierarchy_category       FOREIGN KEY(col_category) REFERENCES tab_grn_space_category(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_category_hierarchy_ancestor       FOREIGN KEY(col_ancestor) REFERENCES tab_grn_space_category(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_category_acl(
  col_category             bigint(20)   NOT NULL,
  col_acl                  bigint(20)   NOT NULL,

  col_is_grant             boolean      NOT NULL,

  PRIMARY KEY(col_category, col_acl),

  CONSTRAINT cns_grn_space_category_acl_category FOREIGN KEY(col_category) REFERENCES tab_grn_space_category(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_category_acl_acl FOREIGN KEY(col_acl) REFERENCES tab_grn_space_access_control_list(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_category_notification(
  col_category             bigint(20)   NOT NULL,
  col_notification         bigint(20)   NOT NULL,

  PRIMARY KEY(col_category, col_notification),

  CONSTRAINT cns_grn_space_category_notification_category FOREIGN KEY(col_category) REFERENCES tab_grn_space_category(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_category_notification_notification FOREIGN KEY(col_notification) REFERENCES tab_grn_space_notification(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;



/* ###########################   004 application  #################################### */
CREATE TABLE tab_grn_space_application(
  _id                          bigint(20)    NOT NULL AUTO_INCREMENT,

  col_application_code         varchar(128)  COLLATE utf8mb4_bin NOT NULL,
  col_application_name         varchar(128)  NOT NULL,
  col_is_available             boolean       NOT NULL, 
  col_application_type         int(11)       NOT NULL,
  col_external_application_id  bigint(20)    NOT NULL,
  col_is_system_use            boolean       NOT NULL,
  col_is_forced_use            boolean       NOT NULL,
  col_creator                  bigint(20)    DEFAULT NULL,
  col_creator_name             char(100)     NOT NULL,
  col_create_timestamp         int(11)       NOT NULL,
  col_modifier                 bigint(20)    DEFAULT NULL,
  col_modifier_name            char(100)     NOT NULL,
  col_modify_timestamp         int(11)       DEFAULT NULL,

  PRIMARY KEY(_id),
  KEY(col_application_code),
  
  CONSTRAINT cns_grn_space_application_creator   FOREIGN KEY (col_creator)   REFERENCES tab_cb_user (_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_application_modifier  FOREIGN KEY (col_modifier)  REFERENCES tab_cb_user (_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_application_local(
  col_application   bigint(20) NOT NULL,
  col_language      bigint(20) NOT NULL,
  col_application_name varchar(128) NOT NULL,

  PRIMARY KEY(col_application, col_language),

  CONSTRAINT cns_grn_space_application_local_application    FOREIGN KEY (col_application)   REFERENCES tab_grn_space_application(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_application_local_language       FOREIGN KEY (col_language)      REFERENCES tab_cb_language_status(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


/* ###########################   005 application template #################################### */
CREATE TABLE tab_grn_space_application_template(
  _id                               bigint(20)    NOT NULL AUTO_INCREMENT,

  col_application_template_code     varchar(128)  NOT NULL,
  col_application_template_name     varchar(128)  NOT NULL,
  col_creator                       bigint(20)    DEFAULT NULL,
  col_creator_name                  char(100)     NOT NULL,
  col_create_timestamp              int(11)       NOT NULL,
  col_modifier                      bigint(20)    DEFAULT NULL,
  col_modifier_name                 char(100)     NOT NULL,
  col_modify_timestamp              int(11)       DEFAULT NULL,

  PRIMARY KEY(_id),

  CONSTRAINT cns_grn_space_application_template_creator   FOREIGN KEY (col_creator)   REFERENCES tab_cb_user (_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_application_template_modifier  FOREIGN KEY (col_modifier)  REFERENCES tab_cb_user (_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_application_template_application(
  col_apl_temp      bigint(20) NOT NULL,
  col_application   bigint(20) NOT NULL,

  PRIMARY KEY(col_apl_temp, col_application),

  CONSTRAINT cns_grn_space_application_template_apl_temp        FOREIGN KEY (col_apl_temp)      REFERENCES tab_grn_space_application_template(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_application_template_application     FOREIGN KEY (col_application)   REFERENCES tab_grn_space_application(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


/* ###########################   006 space #################################### */
CREATE TABLE tab_grn_space_space(
  _id                     bigint(20)  NOT NULL,

  col_space_code          varchar(128) NOT NULL,
  col_space_name          varchar(128) NOT NULL,
  col_is_builtin_icon     boolean      NOT NULL,
  col_builtin_icon        bigint(20)   DEFAULT NULL,
  col_original_icon_file  bigint(20)   DEFAULT NULL,
  col_category            bigint(20)   NOT NULL,
  col_is_public           boolean      NOT NULL,
  col_creator             bigint(20)   DEFAULT NULL,
  col_creator_name        char(100)    NOT NULL,
  col_create_timestamp    int(11)      NOT NULL,
  col_modifier            bigint(20)   DEFAULT NULL,
  col_modifier_name       char(100)    NOT NULL,
  col_modify_timestamp    int(11)      DEFAULT NULL,
  col_component_modify_timestamp int(11) DEFAULT NULL,
  
  PRIMARY KEY(_id),

  KEY idx_space_code (col_space_code),

  CONSTRAINT cns_grn_space_space_category     FOREIGN KEY(col_category)     REFERENCES tab_grn_space_category(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_space_builtin_icon FOREIGN KEY(col_builtin_icon) REFERENCES tab_grn_space_icon(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_space_creator      FOREIGN KEY(col_creator)      REFERENCES tab_cb_user(_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_space_modifier     FOREIGN KEY(col_modifier)     REFERENCES tab_cb_user(_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_space_sequence(
  col_last_id bigint(20) NOT NULL
)ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_space_application(
  col_space                           bigint(20) NOT NULL,
  col_application                     bigint(20) NOT NULL,

  col_root_category                   bigint(20) DEFAULT NULL,
  col_is_external_application_owner   boolean    NOT NULL,
  col_creator                         bigint(20) DEFAULT NULL,
  col_creator_name                    char(100)  NOT NULL,
  col_create_timestamp                int(11)    NOT NULL,
  col_modifier                        bigint(20) DEFAULT NULL,
  col_modifier_name                   char(100)  NOT NULL,
  col_modify_timestamp                int(11)    DEFAULT NULL,

  PRIMARY KEY(col_space, col_application),

  CONSTRAINT cns_grn_space_space_application_space                         FOREIGN KEY (col_space)        REFERENCES tab_grn_space_space (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_space_application_application                   FOREIGN KEY (col_application)  REFERENCES tab_grn_space_application (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_space_application_root_category                 FOREIGN KEY(col_root_category) REFERENCES tab_grn_space_category(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_space_application_creator                       FOREIGN KEY (col_creator)      REFERENCES tab_cb_user (_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_space_application_modifier                      FOREIGN KEY (col_modifier)     REFERENCES tab_cb_user (_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


CREATE TABLE tab_grn_space_space_local(
  col_space     bigint(20) NOT NULL,
  col_language  bigint(20) NOT NULL,
  col_space_name varchar(128) NOT NULL,

  PRIMARY KEY(col_space, col_language),

  CONSTRAINT cns_grn_space_space_local_space    FOREIGN KEY (col_space)    REFERENCES tab_grn_space_space(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_space_local_language FOREIGN KEY (col_language) REFERENCES tab_cb_language_status(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


CREATE TABLE tab_grn_space_space_user(
  col_user  bigint(20) NOT NULL,
  col_space bigint(20) NOT NULL,

  col_display_order int(11) NOT NULL,

  PRIMARY KEY(col_user, col_space),

  CONSTRAINT cns_grn_space_space_user_user   FOREIGN KEY(col_user)  REFERENCES tab_cb_user(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_space_user_space  FOREIGN KEY(col_space) REFERENCES tab_grn_space_space(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


CREATE TABLE tab_grn_space_space_memo(
  col_space            bigint(20) NOT NULL,

  col_memo             longtext   NOT NULL,
  col_is_rich_text     boolean    NOT NULL,
  col_creator          bigint(20) DEFAULT NULL,
  col_creator_name     char(100)  NOT NULL,
  col_create_timestamp int(11)    NOT NULL,
  col_modifier         bigint(20) DEFAULT NULL,
  col_modifier_name    char(100)  NOT NULL,
  col_modify_timestamp int(11)    DEFAULT NULL,

  PRIMARY KEY(col_space),

  CONSTRAINT cns_grn_space_space_memo_space     FOREIGN KEY(col_space) REFERENCES tab_grn_space_space(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_space_memo_creator   FOREIGN KEY(col_creator)  REFERENCES tab_cb_user(_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_space_memo_modifier  FOREIGN KEY(col_modifier) REFERENCES tab_cb_user(_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


CREATE TABLE tab_grn_space_space_memo_open_status(
  col_space bigint(20)  NOT NULL,
  col_user  bigint(20)  NOT NULL,

  col_is_memo_open      boolean    NOT NULL,

  PRIMARY KEY(col_space, col_user),

  CONSTRAINT cns_tab_grn_space_space_memo_open_status_space FOREIGN KEY(col_space) REFERENCES tab_grn_space_space(_id) ON DELETE CASCADE,
  CONSTRAINT cns_tab_grn_space_space_memo_open_status_user  FOREIGN KEY(col_user)  REFERENCES tab_cb_user(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_space_acl(
  col_space                bigint(20)   NOT NULL,
  col_acl                  bigint(20)   NOT NULL,

  col_is_grant             boolean      NOT NULL,

  PRIMARY KEY(col_space, col_acl),

  CONSTRAINT cns_grn_space_space_acl_space FOREIGN KEY(col_space) REFERENCES tab_grn_space_space(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_space_acl_acl FOREIGN KEY(col_acl) REFERENCES tab_grn_space_access_control_list(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;



/* ###########################   007 file #################################### */
CREATE TABLE tab_grn_space_file(
  _id                       bigint(20)  NOT NULL AUTO_INCREMENT,

  col_title                 char(100)   DEFAULT NULL,
  col_title_sort_key        char(128)   NOT NULL,
  col_description           text,
  col_mark                  int(11)     DEFAULT NULL,
  col_max_version           int(11)     NOT NULL,
  col_version               int(11)     NOT NULL,
  col_creator               bigint(20)  DEFAULT NULL,
  col_creator_foreign_key   char(128)   DEFAULT NULL,
  col_creator_name          char(100)   NOT NULL,
  col_ctime                 int(11)     NOT NULL,
  col_modifier              bigint(20)  DEFAULT NULL,
  col_modifier_foreign_key  char(128)   DEFAULT NULL,
  col_modifier_name         char(100)   DEFAULT NULL,
  col_mtime                 int(11)     DEFAULT NULL,

  PRIMARY KEY(_id),

  CONSTRAINT cns_grn_space_file_creator      FOREIGN KEY(col_creator)      REFERENCES tab_cb_user(_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_file_modifier     FOREIGN KEY(col_modifier)     REFERENCES tab_cb_user(_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_filebody(
  _id                   bigint(20)                      NOT NULL AUTO_INCREMENT,

  col_blob              char(49) CHARACTER SET ascii    DEFAULT NULL,
  col_charset           char(100)                       DEFAULT NULL,
  col_file              bigint(20)                      DEFAULT NULL,
  col_hash              char(40) CHARACTER SET ascii    DEFAULT NULL,
  col_latest            int(11)                         NOT NULL,
  col_mime              char(100)                       NOT NULL,
  col_name              char(128)                       NOT NULL,
  col_size              int(11)                         NOT NULL,
  col_timestamp         int(11)                         NOT NULL,
  col_version           int(11)                         NOT NULL,

  PRIMARY KEY(_id),

  CONSTRAINT cns_grn_space_filebody_file      FOREIGN KEY(col_file)      REFERENCES tab_grn_space_file(_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_filelog(
  _id                       bigint(20)  NOT NULL AUTO_INCREMENT,

  col_body                  bigint(20)  DEFAULT NULL,
  col_comment               text,
  col_file                  bigint(20)  DEFAULT NULL,
  col_filename              char(128)   NOT NULL,
  col_operation             int(11)     DEFAULT NULL,
  col_record_time           int(11)     DEFAULT NULL,
  col_recorder              bigint(20)  DEFAULT NULL,
  col_recorder_foreign_key  char(128)   DEFAULT NULL,
  col_recorder_name         char(100)   DEFAULT NULL,
  col_restore_version       int(11)     DEFAULT NULL,
  col_version               int(11)     NOT NULL,

  PRIMARY KEY(_id),

  CONSTRAINT cns_grn_space_filelog_body      FOREIGN KEY(col_body)      REFERENCES tab_grn_space_filebody(_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_filelog_file      FOREIGN KEY(col_file)      REFERENCES tab_grn_space_file(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_filelog_recorder  FOREIGN KEY(col_recorder)  REFERENCES tab_cb_user(_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_filelock(
  _id                   bigint(20)  NOT NULL AUTO_INCREMENT,

  col_file              bigint(20)  DEFAULT NULL,
  col_lock_owner        bigint(20)  DEFAULT NULL,
  col_lock_timeout      int(11)     DEFAULT NULL,

  PRIMARY KEY(_id),

  CONSTRAINT cns_grn_space_filelock_file    FOREIGN KEY(col_file)       REFERENCES tab_grn_space_file(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_filelock_owner   FOREIGN KEY(col_lock_owner) REFERENCES tab_cb_user(_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


/* ###########################   008 comment #################################### */
CREATE TABLE tab_grn_space_comment(
  _id                  bigint(20) NOT NULL AUTO_INCREMENT,

  col_comment_no       int(11)    NOT NULL,
  col_content          longtext   NOT NULL,
  col_is_rich_text     boolean    NOT NULL,
  col_hierarchy_level  int(11)    NOT NULL,
  col_parent           bigint(20) DEFAULT NULL,
  col_is_logical_delete boolean   NOT NULL,
  col_creator          bigint(20) DEFAULT NULL,
  col_creator_name     char(100)  NOT NULL,
  col_create_timestamp int(11)    NOT NULL,
  col_modifier         bigint(20) DEFAULT NULL,
  col_modifier_name    char(100)  NOT NULL,
  col_modify_timestamp int(11)    DEFAULT NULL,

  PRIMARY KEY(_id),

  CONSTRAINT cns_grn_space_comment_parent    FOREIGN KEY (col_parent)  REFERENCES tab_grn_space_comment (_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_comment_creator   FOREIGN KEY(col_creator)  REFERENCES tab_cb_user(_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_comment_modifier  FOREIGN KEY(col_modifier) REFERENCES tab_cb_user(_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_comment_hierarchy (
  col_comment         bigint(20) NOT NULL,
  col_ancestor        bigint(20) NOT NULL,

  PRIMARY KEY(col_comment, col_ancestor),

  CONSTRAINT cns_grn_comment_hierarchy_comment       FOREIGN KEY(col_comment)  REFERENCES tab_grn_space_comment(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_comment_hierarchy_ancestor      FOREIGN KEY(col_ancestor) REFERENCES tab_grn_space_comment(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_comment_sequence_no(
  _id         bigint(20) NOT NULL AUTO_INCREMENT,

  col_last_no int(11)    NOT NULL,

  PRIMARY KEY(_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_comment_read_status(
  col_user   bigint(20) NOT NULL,
  col_comment bigint(20) NOT NULL,

  PRIMARY KEY(col_user, col_comment),

  CONSTRAINT cns_grn_space_comment_read_status_user    FOREIGN KEY(col_user)    REFERENCES tab_cb_user (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_comment_read_status_comment FOREIGN KEY(col_comment) REFERENCES tab_grn_space_comment(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_comment_file(
  col_comment   bigint(20) NOT NULL,
  col_file      bigint(20) NOT NULL,

  PRIMARY KEY(col_comment, col_file),

  UNIQUE KEY cni_file (col_file),

  CONSTRAINT cns_grn_space_comment_file_comment     FOREIGN KEY(col_comment)    REFERENCES tab_grn_space_comment(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_comment_file_file        FOREIGN KEY(col_file)       REFERENCES tab_grn_space_file(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


/* ###########################   009 thread #################################### */
CREATE TABLE tab_grn_space_thread (
  _id                         bigint(20)   NOT NULL,

  col_category                bigint(20)   NOT NULL,
  col_title                   varchar(128) NOT NULL,
  col_content                 longtext     NOT NULL,
  col_is_rich_text            boolean      NOT NULL,
  col_comment_sequence_no     bigint(20)   NOT NULL,
  col_is_system_use           boolean      NOT NULL,
  col_creator                 bigint(20)   DEFAULT NULL,
  col_creator_name            char(100)    NOT NULL,
  col_create_timestamp        int(11)      NOT NULL,
  col_modifier                bigint(20)   DEFAULT NULL,
  col_modifier_name           char(100)    NOT NULL,
  col_modify_timestamp        int(11)      DEFAULT NULL,
  col_component_modify_timestamp int(11) DEFAULT NULL,

  PRIMARY KEY(_id),
  KEY idx_category_id (col_category, _id),
  KEY idx_category_create_timestamp (col_category, col_create_timestamp), 
  KEY idx_category_modify_timestamp (col_category, col_modify_timestamp), 
  KEY idx_category_title (col_category, col_title), 
  KEY idx_category_component_modify_timestamp (col_category, col_component_modify_timestamp), 
  
  
  CONSTRAINT cns_grn_space_thread_comment_sequence_no    FOREIGN KEY (col_comment_sequence_no)    REFERENCES tab_grn_space_comment_sequence_no(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_thread_category               FOREIGN KEY (col_category)               REFERENCES tab_grn_space_category (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_thread_creator                FOREIGN KEY (col_creator)                REFERENCES tab_cb_user (_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_thread_modifier               FOREIGN KEY (col_modifier)               REFERENCES tab_cb_user (_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_thread_sequence(
  col_last_id bigint(20) NOT NULL
)ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_thread_read_status(
  col_user   bigint(20) NOT NULL,
  col_thread bigint(20) NOT NULL,

  PRIMARY KEY(col_user, col_thread),

  CONSTRAINT cns_grn_space_thread_read_status_user   FOREIGN KEY(col_user)   REFERENCES tab_cb_user (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_thread_read_status_thread FOREIGN KEY(col_thread) REFERENCES tab_grn_space_thread(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_thread_comment(
  col_thread  bigint(20) NOT NULL,
  col_comment bigint(20) NOT NULL,

  PRIMARY KEY(col_thread, col_comment),

  UNIQUE KEY cni_comment (col_comment),

  CONSTRAINT cns_grn_space_thread_comment_thread  FOREIGN KEY(col_thread)  REFERENCES tab_grn_space_thread(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_thread_comment_comment FOREIGN KEY(col_comment) REFERENCES tab_grn_space_comment (_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_thread_notification(
  col_thread        bigint(20) NOT NULL,
  col_notification  bigint(20) NOT NULL,

  PRIMARY KEY(col_thread, col_notification),

  CONSTRAINT cns_grn_space_thread_notification_thread         FOREIGN KEY(col_thread)         REFERENCES tab_grn_space_thread (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_thread_notification_notification   FOREIGN KEY(col_notification)   REFERENCES tab_grn_space_notification (_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_thread_file(
  col_thread   bigint(20) NOT NULL,
  col_file      bigint(20) NOT NULL,

  PRIMARY KEY(col_thread, col_file),

  UNIQUE KEY cni_file (col_file),

  CONSTRAINT cns_grn_space_thread_file_thread       FOREIGN KEY(col_thread)     REFERENCES tab_grn_space_thread(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_thread_file_file         FOREIGN KEY(col_file)       REFERENCES tab_grn_space_file(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;


/* ###########################   010 todo #################################### */
CREATE TABLE tab_grn_space_todo (
  _id                         bigint(20)   NOT NULL,

  col_category                bigint(20)   NOT NULL,
  col_start_timestamp         int(11)      DEFAULT NULL,
  col_deadline_timestamp      int(11)      DEFAULT NULL,
  col_timezone                varchar(100) NOT NULL,
  col_title                   varchar(128) NOT NULL,
  col_content                 longtext     NOT NULL,
  col_is_rich_text            boolean      NOT NULL,
  col_is_complete             boolean      NOT NULL,
  col_creator                 bigint(20)   DEFAULT NULL,
  col_creator_name            char(100)    NOT NULL,
  col_create_timestamp        int(11)      NOT NULL,
  col_modifier                bigint(20)   DEFAULT NULL,
  col_modifier_name           char(100)    NOT NULL,
  col_modify_timestamp        int(11)      DEFAULT NULL,

  PRIMARY KEY(_id),
  KEY idx_category_id (col_category, _id),
  KEY idx_category_create_timestamp (col_category, col_create_timestamp),
  KEY idx_category_modify_timestamp (col_category, col_modify_timestamp),
  KEY idx_category_deadline_timestamp (col_category, col_deadline_timestamp),
  KEY idx_category_is_complete_id (col_category, col_is_complete, _id),
  KEY idx_category_is_complete_create_timestamp (col_category, col_is_complete, col_create_timestamp),
  KEY idx_category_is_complete_modify_timestamp (col_category, col_is_complete, col_modify_timestamp),
  KEY idx_category_is_complete_deadline_timestamp (col_category, col_is_complete, col_deadline_timestamp),
  
  CONSTRAINT cns_grn_space_todo_category               FOREIGN KEY (col_category)               REFERENCES tab_grn_space_category (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_todo_creator                FOREIGN KEY (col_creator)                REFERENCES tab_cb_user (_id) ON DELETE SET NULL,
  CONSTRAINT cns_grn_space_todo_modifier               FOREIGN KEY (col_modifier)               REFERENCES tab_cb_user (_id) ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_todo_sequence(
  col_last_id bigint(20) NOT NULL
)ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_todo_comment(
  col_todo          bigint(20) NOT NULL,
  col_comment       bigint(20) NOT NULL,
  col_status_code   int(11)    NOT NULL,

  PRIMARY KEY(col_todo, col_comment),

  UNIQUE KEY cni_comment (col_comment),

  CONSTRAINT cns_grn_space_todo_comment_todo    FOREIGN KEY(col_todo)    REFERENCES tab_grn_space_todo (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_todo_comment_comment FOREIGN KEY(col_comment) REFERENCES tab_grn_space_comment(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_todo_read_status(
  col_user   bigint(20) NOT NULL,
  col_todo   bigint(20) NOT NULL,

  PRIMARY KEY(col_user, col_todo),

  CONSTRAINT cns_grn_space_todo_read_status_user    FOREIGN KEY(col_user)    REFERENCES tab_cb_user (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_todo_read_status_todo    FOREIGN KEY(col_todo)    REFERENCES tab_grn_space_todo (_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_todo_user(
  col_user   bigint(20) NOT NULL,
  col_todo   bigint(20) NOT NULL,

  col_display_order int(11) NOT NULL,
  col_is_complete   boolean NOT NULL,

  PRIMARY KEY(col_user, col_todo),
  KEY (col_todo, col_display_order, col_user),
  
  CONSTRAINT cns_grn_space_todo_user_user   FOREIGN KEY(col_user)  REFERENCES tab_cb_user(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_todo_user_todo   FOREIGN KEY(col_todo)  REFERENCES tab_grn_space_todo(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_todo_thread(
  col_todo   bigint(20) NOT NULL,
  col_thread bigint(20) NOT NULL,

  PRIMARY KEY(col_thread, col_todo),

  UNIQUE KEY cni_todo (col_todo),

  CONSTRAINT cns_grn_space_todo_thread_thread FOREIGN KEY(col_thread) REFERENCES tab_grn_space_thread(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_todo_thread_todo   FOREIGN KEY(col_todo)   REFERENCES tab_grn_space_todo (_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_todo_notification(
  col_todo          bigint(20) NOT NULL,
  col_notification  bigint(20) NOT NULL,

  PRIMARY KEY(col_todo, col_notification),

  CONSTRAINT cns_grn_space_todo_notification_todo           FOREIGN KEY(col_todo)           REFERENCES tab_grn_space_todo (_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_todo_notification_notification   FOREIGN KEY(col_notification)   REFERENCES tab_grn_space_notification (_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_space_todo_file(
  col_todo      bigint(20) NOT NULL,
  col_file      bigint(20) NOT NULL,

  PRIMARY KEY(col_todo, col_file),

  UNIQUE KEY cni_file (col_file),

  CONSTRAINT cns_grn_space_todo_file_todo       FOREIGN KEY(col_todo)       REFERENCES tab_grn_space_todo(_id) ON DELETE CASCADE,
  CONSTRAINT cns_grn_space_todo_file_file       FOREIGN KEY(col_file)       REFERENCES tab_grn_space_file(_id) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

/* For Space Application end */




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

INSERT INTO
    tab_grn_space_category_local
SELECT
    2, tab_cb_language_status._id, '全般'
FROM
    tab_cb_language_status
WHERE
    tab_cb_language_status.col_language = 'ja';

INSERT INTO
    tab_grn_space_category_local
SELECT
    2, tab_cb_language_status._id, 'General'
FROM
    tab_cb_language_status
WHERE
    tab_cb_language_status.col_language = 'en';

INSERT INTO
    tab_grn_space_category_local
SELECT
    2, tab_cb_language_status._id, '一般'
FROM
    tab_cb_language_status
WHERE
    tab_cb_language_status.col_language = 'zh';
  
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
  col_authority_code = "read",
  col_authority_name = "READ";

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
  
INSERT INTO tab_cb_profiledata___system SET
  col_key = 0,
  col_module = 'grn.common.application',
  col_name = 'space_root_category',
  col_value = 's:33:"jp.co.cybozu.garoon350.space.root";';

INSERT INTO tab_grn_applicationname SET
  col_application = 'space',
  col_locale = 'en',
  col_name = 'Space';

INSERT INTO tab_grn_applicationname SET
  col_application = 'space',
  col_locale = 'ja',
  col_name = 'スペース';

INSERT INTO tab_grn_applicationname SET
  col_application = 'space',
  col_locale = 'zh',
  col_name = '空间';
/* Data for Space application end */

/*GRN35-321*/
CREATE TABLE `tab_grn_report_availability_dynamic_role` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_authority_cellular` int(11) DEFAULT NULL,
  `col_ctime` int(11) DEFAULT NULL,
  `col_dynamic_role` char(100) DEFAULT NULL,
PRIMARY KEY (`_id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tab_grn_report_availability_groupuser`(
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_authority_cellular` int(11) DEFAULT NULL,
  `col_ctime` int(11) DEFAULT NULL,
  `col_groupuser` bigint(20) NOT NULL,
PRIMARY KEY (`_id`),UNIQUE KEY `cni_groupuser` (`col_groupuser`),
CONSTRAINT `cns_grn_report_availability_groupuser_groupuser` FOREIGN KEY (`col_groupuser`) REFERENCES `tab_cb_group` (`_id`) ON DELETE CASCADE ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tab_grn_report_availability_role`(
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_authority_cellular` int(11) DEFAULT NULL,
  `col_ctime` int(11) DEFAULT NULL,
  `col_role` bigint(20) NOT NULL,
PRIMARY KEY (`_id`),
UNIQUE KEY `cni_role` (`col_role`),
CONSTRAINT `cns_grn_report_availability_role_role` FOREIGN KEY (`col_role`) REFERENCES `tab_cb_role` (`_id`) ON DELETE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

/*GRN35-322*/
CREATE TABLE `tab_grn_workflow_availability_dynamic_role` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_authority_cellular` int(11) DEFAULT NULL,
  `col_ctime` int(11) DEFAULT NULL,
  `col_dynamic_role` char(100) DEFAULT NULL,
PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tab_grn_workflow_availability_groupuser` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_authority_cellular` int(11) DEFAULT NULL,
  `col_ctime` int(11) DEFAULT NULL,
  `col_groupuser` bigint(20) NOT NULL,
PRIMARY KEY (`_id`),
UNIQUE KEY `cni_groupuser` (`col_groupuser`),
CONSTRAINT `cns_grn_workflow_availability_groupuser_groupuser` FOREIGN KEY (`col_groupuser`) REFERENCES `tab_cb_group` (`_id`) ON DELETE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tab_grn_workflow_availability_role` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_authority_cellular` int(11) DEFAULT NULL,
  `col_ctime` int(11) DEFAULT NULL,
  `col_role` bigint(20) NOT NULL,
PRIMARY KEY (`_id`),
UNIQUE KEY `cni_role` (`col_role`),
CONSTRAINT `cns_grn_workflow_availability_role_role` FOREIGN KEY (`col_role`) REFERENCES `tab_cb_role` (`_id`) ON DELETE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

/*GRN35-38*/
CREATE TABLE `tab_grn_cellular_availability_dynamic_role` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_dynamic_role` char(100) DEFAULT NULL,
PRIMARY KEY (`_id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC; 

CREATE TABLE `tab_grn_cellular_availability_groupuser`(
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_groupuser` bigint(20) NOT NULL,
PRIMARY KEY (`_id`),
UNIQUE KEY `cni_groupuser` (`col_groupuser`),CONSTRAINT `cns_grn_cellular_availability_groupuser_groupuser` FOREIGN KEY (`col_groupuser`) REFERENCES `tab_cb_group` (`_id`) ON DELETE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tab_grn_cellular_availability_role` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_ctime` int(11) DEFAULT NULL,
  `col_role` bigint(20) NOT NULL,
PRIMARY KEY (`_id`),
UNIQUE KEY `cni_role` (`col_role`),CONSTRAINT `cns_grn_cellular_availability_role_role` FOREIGN KEY (`col_role`) REFERENCES `tab_cb_role` (`_id`) ON DELETE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

/*GRN35-715*/
ALTER TABLE `tab_cb_user` ADD (`col_slash_password` text, `col_slash_salt` varchar(64));

ALTER TABLE tab_grn_mail_message___p0 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p1 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p2 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p3 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p4 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p5 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p6 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p7 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p8 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p9 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p10 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p11 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p12 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p13 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p14 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p15 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p16 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p17 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p18 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p19 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p20 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p21 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p22 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p23 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p24 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p25 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p26 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p27 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p28 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p29 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p30 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p31 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p32 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p33 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p34 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p35 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p36 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p37 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p38 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p39 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p40 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p41 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p42 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p43 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p44 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p45 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p46 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p47 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p48 ADD INDEX idx_send_ts(`col_send_ts`);
ALTER TABLE tab_grn_mail_message___p49 ADD INDEX idx_send_ts(`col_send_ts`);

/** GRN-21 V-CUBE Relation Start **/
ALTER TABLE `tab_grn_facility_facility` ADD COLUMN `col_vcube_available` INT(11) DEFAULT NULL;
ALTER TABLE `tab_grn_facility_facility` ADD COLUMN `col_vcube_guests_audience_limit` INT(11) DEFAULT NULL;
ALTER TABLE `tab_grn_facility_facility` ADD COLUMN `col_vcube_guests_normal_limit` INT(11) DEFAULT NULL;

CREATE TABLE tab_grn_schedule_vcube_cooperation (
  _id                       bigint(20)  NOT NULL AUTO_INCREMENT,
  col_cooperation_status    int(11)     DEFAULT NULL,
  col_creator               text,
  col_end_datetime          int(11)     DEFAULT NULL,
  col_event_id              bigint(20)  DEFAULT NULL,
  col_event_members         text,
  col_facility_code         char(100)   DEFAULT NULL,
  col_memo                  text,
  col_modifier              text,
  col_outside_members       text,
  col_password              char(50)    DEFAULT NULL,
  col_reservation_id        char(50)    DEFAULT NULL,
  col_start_datetime        int(11)     DEFAULT NULL,
  col_timestamp             int(11)     DEFAULT NULL,
  col_timezone              char(100)   DEFAULT NULL,
  col_title                 char(255)   DEFAULT NULL,
  col_end_timezone          char(100)   DEFAULT NULL,
  PRIMARY KEY (_id),
  UNIQUE KEY idx_event_id (col_event_id)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE tab_grn_schedule_vcube_invitation (
  _id               bigint(20)  NOT NULL AUTO_INCREMENT,
  col_coop_id       bigint(20)  NOT NULL,
  col_guest_id      text,
  col_invite_url    text,
  col_user_email    char(100)   DEFAULT NULL,
  col_user_id       char(50)    DEFAULT NULL,
  col_user_lang     char(10)    DEFAULT NULL,
  col_user_name     char(100)   DEFAULT NULL,
  col_user_timezone char(100)   DEFAULT NULL,
  col_user_type     char(10)    DEFAULT NULL,
  PRIMARY KEY (_id),
  KEY cni_coop_id (col_coop_id),
  KEY idx_coop_id (col_coop_id),
  CONSTRAINT cns_grn_schedule_vcube_invitation_coop_id FOREIGN KEY (col_coop_id) REFERENCES tab_grn_schedule_vcube_cooperation (_id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

INSERT INTO `tab_cb_profiledata___system` (`col_key`, `col_module`, `col_name`, `col_value`) VALUES (0, 'grn.vcube.system', 'vcube_license', 's:1:\"1\";');

/** GRN35-21 V-CUBE Relation End **/

/**
 * GRN35-652
 */
DROP TABLE IF EXISTS `tab_grn_cellular_token`;
CREATE TABLE `tab_grn_cellular_token` (
  `_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `col_cellular_token` char(50)   DEFAULT NULL,
  `col_last_time_login` int(11) DEFAULT NULL,
  `col_user` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `cni_user` (`col_user`),
  CONSTRAINT `cns_grn_cellular_token` FOREIGN KEY (`col_user`) REFERENCES `tab_cb_user` (`_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/**
 * end GRN35-652
 */

/** GRN2-3810 **/
ALTER TABLE `tab_cb_user` MODIFY `col_display_name` varchar(128) NOT NULL, MODIFY `col_email_address` varchar(256) DEFAULT NULL, MODIFY `col_nickname` varchar(128) NOT NULL, MODIFY `col_normalized_sort_key` varchar(130) DEFAULT NULL, MODIFY `col_sort_key` varchar(130) DEFAULT NULL;

ALTER TABLE `tab_grn_message_messages_sequence` ENGINE = InnoDB;
ALTER TABLE `tab_grn_schedule_event_sequence` ENGINE = InnoDB;
ALTER TABLE `tab_grn_space_space_sequence` ENGINE = InnoDB;
ALTER TABLE `tab_grn_space_thread_sequence` ENGINE = InnoDB;
ALTER TABLE `tab_grn_space_todo_sequence` ENGINE = InnoDB;

INSERT INTO `tab_grn_defaultapplicationmenu` SET col_app_id = 'space' ,col_location = 'index';
INSERT INTO `tab_grn_defaultstartmenu` SET col_app_id = 'space' ,col_location = 'index';

/* ########################################################################## */

/* 
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`=2;
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;

/* Finalization */
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
