<?php

/**
 * @name   grn_filename
 *
 * @date   2004/10/13
 * @author KAMBE,Shinichi
 * @date   2004/10/22
 * @author M.Oomori
 * @date   2004/11/18
 * @author Y.Tanaka
 * @date   2005/02
 * @author YOSHIDA, Hideyasu
 *
 * @param string fid    ファイルID
 * @param string name   ファイル名
 * @param string mime   MIMEタイプ
 * @param string size   サイズ（バイト）
 * @param string dpage  ダウンロードページのURL
 * @param array  params ダウンロードページのURL引数
 * @param bool   inline 画像のときインライン表示させるフラグ
 */
function smarty_function_grn_filename($params, & $smarty)
{
    $name = null;
    if (array_key_exists('name', $params)) {
        $name = $params['name'];
        unset($params['name']);
    }
    if (0 == strlen($name)) {
        return 'name not found';
    }

    $dpage = null;
    if (array_key_exists('dpage', $params)) {
        $dpage = $params['dpage'];
        unset($params['dpage']);
    }
    if ( ! $dpage) {
        return 'dpage not found';
    }

    $size = null;
    if (array_key_exists('size', $params)) {
        $size = $params['size'];
        unset($params['size']);
        $size = sprintf("%.1f&nbsp;KB", floatval($size) * 0.001);
    }

    $client = null;
    if (array_key_exists('client', $params)) {
        $client = $params['client'];
        unset($params['client']);
    }

    require_once('grn/mime.csp');
    $mime_config_manager = GRN_MIMEConfigManager::getInstance();

    $pos = strrpos($name, '.');
    if ($pos < strlen($name) - 1) {
        $extension = substr($name, $pos + 1);

        require_once('grn/mime.csp');
        $mime_config_manager = GRN_MIMEConfigManager::getInstance();
        $mime = $mime_config_manager->getMIMEType($extension);
    }

    if (false === ($mime = $mime_config_manager->getMIMEType($extension))) {
        $mime = null;
        if (array_key_exists('mime', $params)) {
            $extension = substr($name, $pos + 1);

            $mime = $params['mime'];
            unset($params['mime']);
        } else {
            $mime = "application/octet-stream";
        }
    }

    $inline = false;
    if (array_key_exists('inline', $params)) {
        $inline = $params['inline'];
        unset($params['inline']);
    }

    $user_params = null;
    if (array_key_exists('params', $params)) {
        $user_params = $params['params'];
        unset($params['params']);
    }

    if ($user_params) {
        $params += $user_params;
    }

    $download_url = cb_pageurl($dpage, $params, null, $name);
    require_once('fw/miscFunctions.csp');
    if (cb_is_need_download_ticket()) {
        require_once('grn/ticket.csp');
        global $G_container_base;
        $uum = $G_container_base->getInstance('uum');
        $user = $uum->getLoginUser();
        $download_url .= '&ticket=' . GRN_Ticket::create($user->getOID());
    }

    if ($client == "mobile") {
        return $download_url;
    }

    $view_url = cb_pageurl($vpage, $params, null, null);

    // $sizeは&nbsp;が入るのでエスケープしない。
    // $download_urlはcb_pageurlの返り値が入り、cb_pageurlの中でhtmlspecialcharsが呼ばれているのでエスケープしない。
    if ($inline) {
        $mime_manager = GRN_MIMEConfigManager::getInstance();
        if ($mime_manager->isInlineImageMimeType($mime)) {
            return '<img src="' . $download_url . '">&nbsp;('
                   . htmlspecialchars($mime) . ')&nbsp;' . $size;
        }
    }

    return '<a class="with_lang" href="' . $download_url . '">'
           . htmlspecialchars($name) . '</a>&nbsp;(' . htmlspecialchars($mime)
           . ')&nbsp;' . $size;
}

