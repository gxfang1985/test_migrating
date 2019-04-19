<?php
require_once('grn/ui.csp');

/**
 * @name    grn_sso_link  イメージ付リンクの出力
 *
 * @date    2005/5/13
 * @author  Y.Nakamura
 * @option  string  caption           リンクキャプション
 * @option  integer truncated_caption キャプションをtruncateする文字数
 * @option  string  caption_module    キャプションモジュール
 * @option  string  caption_key       キャプションキー
 * @option  string  script            JavaScript
 * @option  string  class             class名
 * @option  string  image             イメージファイル名
 * @option  boolean image_direct      外部イメージファイルか否か
 * @option  string  alt               IMAGEタグのALT属性
 * @option  string  target            AタグのTARGET属性
 * @option  string  title             AタグのTITLE属性
 * @option  boolean disabled          無効化するかどうか
 * @option  boolean unread            未読かどうか
 *
 * @param string  sso_id            シングルサインオンID
 *
 * @option  string  app_id            アプリケーションID（ex: 'portal''）
 * @option  array   id_list           id_list 関連 IDリスト  (ex: grn.common.uum.user.xxxxの場合 は、array('user' => 1))
 * @option  string  redirect_url      リダイレクトURL（SSO先URLと違うページにリダイレクトしたい場合）
 * @option  array   params            その他のパラメータ
 *
 */

function smarty_function_grn_sso_link($params, &$smarty)
{
    $function_name = "grn_sso_link";

    static $sso_link_count = 0;

    // necessary parameter and value
    if (strlen(@$params['sso_id']) === 0) {
        return htmlspecialchars($function_name) . ': missing sso_id parameter';
    }

    //Get Parameters
    $sso_link = $params;
    $sso_link['count'] = $sso_link_count;
    if ( ! array_key_exists('id_list', $sso_link)) {
        $sso_link['id_list'] = [];
    } elseif (is_null($sso_link['id_list'])) {
        $sso_link['id_list'] = [];
        if (array_key_exists('uid', $params)
            && is_null($params['uid']) === false
        ) {
            $sso_link['id_list']['uid'] = $params['uid'];
        }
    }

    //Include SSO Link Controller
    include(cb_basedir() . '/code/doc_root/grn/sso/sso_link.csp');

    //Count Up
    $sso_link_count++;
}

