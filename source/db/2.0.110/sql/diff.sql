/* Garoon DDL */

/* ########################################################################## */

/* ########################################################################## */

/* GRN35-1234 */
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
  
/* GRN35-1094 start */
ALTER TABLE `tab_grn_mail_signature` ADD COLUMN `col_position` char(100) NULL;
/* GRN35-1094 end */

/* GRN2-5603 */
UPDATE
    tab_cb_profiledata___system
SET
    col_value  = CONCAT('s:12:"', SUBSTRING(REPLACE(UUID(), "-", "") FROM 1 FOR 12), '";')
WHERE
    col_key    = 0
    AND
    col_module = 'grn.common.system'
    AND
    col_name   = 'uuid'
    AND
    ( col_value = 's:12:"001bdc01189d";' OR col_value = 's:0:"";' );


/* 
 * Schema version-up.
 * !!! Put this query at the bottom of diff.sql !!!
 */
/*!40000 ALTER TABLE `tab_cb_schema_version` DISABLE KEYS */;
UPDATE `tab_cb_schema_version` SET `version`='2.0.110';
/*!40000 ALTER TABLE `tab_cb_schema_version` ENABLE KEYS */;

