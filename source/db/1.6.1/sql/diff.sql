/* Garoon DDL */

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

/* ########################################################################## */

/** GRN2-4535 **/
DROP TABLE IF EXISTS `tab_grn_ticket_user`;
CREATE TABLE `tab_grn_ticket_user` (
  `col_ctime` int(11) NOT NULL,
  `col_ticket` varchar(128) NOT NULL,
  `col_user` bigint(20) NOT NULL,
  KEY `idx_ticket` (`col_ticket`),
  KEY `idx_ctime` (`col_ctime`)
) ENGINE=MEMORY DEFAULT CHARSET=ascii COLLATE=ascii_bin;

/* ########################################################################## */

/* 
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='1.6.1';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;

/* Finalization */
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
