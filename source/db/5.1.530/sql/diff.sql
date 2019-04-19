/* Garoon DDL */

/* fixed for STM-65 start */
DELETE FROM `tab_cb_profiledata___p0`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p1`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p2`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p3`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p4`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p5`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p6`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p7`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p8`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p9`  WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p10` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p11` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p12` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p13` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p14` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p15` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p16` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p17` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p18` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p19` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p20` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p21` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p22` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p23` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p24` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p25` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p26` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p27` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p28` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p29` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p30` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p31` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p32` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p33` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p34` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p35` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p36` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p37` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p38` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p39` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p40` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p41` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p42` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p43` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p44` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p45` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p46` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p47` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p48` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
DELETE FROM `tab_cb_profiledata___p49` WHERE `col_name` LIKE 'grn.common.startcomheader.%';
/* end of fixed for STM-65 */

/* ########################################################################## */
/*
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='5.1.530';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;
