/* ########################################################################## */
/* execute the drop table query later */
/* ########################################################################## */

/* GRN35-1236 cb_search(全文検索サーバー for ガルーン) 関連のロジックとテーブルを削除する */
DROP TABLE IF EXISTS `tab_grn_cbsearch_bulletin_acl_user`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_bulletin_article`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_bulletin_file`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_bulletin_follow`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_bulletin_acl`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_cabinet_acl_user`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_cabinet_file`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_cabinet_acl`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_mail_file`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_mail_article`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_message_acl_user`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_message_article`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_message_file`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_message_follow`;
DROP TABLE IF EXISTS `tab_grn_cbsearch_message_acl`;
