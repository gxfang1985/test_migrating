<?php

/**
 * @name   grn_attach_file_link
 * @description show the link of the attached file information by the specified file id
 *
 * @date        2004/10/13
 * @author      KAMBE,Shinichi
 * @date        2004/10/22
 * @author      M.Oomori
 *
 * @param  string  fid        file id
 *
 * @status      under implementation
 *
 * @date        2004/11/18
 * @author      Y.Tanaka
 *
 * @param string name   filename
 * @param string size   size in byte
 * @param string mime   mime type
 * @param string dpage  download page for the file
 * @param string vpage  view page for the file
 * @param array  params arguments for cb_pageurl
 * @param string unit   unitsize
 * @param int precision precision
 * @param string tpage  view the original image file
 *
 * @param bool   inline
 */
function smarty_function_grn_attach_file_link($params, &$smarty)
{
    $name = null;
    if (array_key_exists('name', $params)) {
        $name = $params['name'];
        unset($params['name']);
    }
    if (strlen($name) < 1) {
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

    $vpage = null;
    if (array_key_exists('vpage', $params)) {
        $vpage = $params['vpage'];
        unset($params['vpage']);
    }
    if ( ! $vpage) {
        return 'vpage not found';
    }

    $size = null;
    if (array_key_exists('size', $params)) {
        $size = $params['size'];
        unset($params['size']);
        require_once($smarty->_get_plugin_filepath('function',
            'grn_format_filesize'));
        $size = smarty_function_grn_format_filesize([
            'size'  => $size,
            'round' => 'ceil'
        ], $smarty);
    }

    $mime = null;
    if (array_key_exists('mime', $params)) {
        $mime = $params['mime'];
        unset($params['mime']);
    } else {
        $mime = "application/octet-stream";
    }

    $inline = false;
    if (array_key_exists('inline', $params)) {
        $inline = $params['inline'];
        unset($params['inline']);
    }

    $image = 'disk20.gif';
    if (array_key_exists('image', $params)) {
        $image = $params['image'];
        unset($params['image']);
    }

    $disabled = null;
    if (array_key_exists('disabled', $params)) {
        $disabled = $params['disabled'];
        unset($params['disabled']);
    }

    $thumbnail_page = null;
    if (array_key_exists('tpage', $params)) {
        $thumbnail_page = $params['tpage'];
        unset($params['tpage']);
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

    $view_url = cb_pageurl($vpage, $params, null, null);
    $msg = cb_msg('fw.ui', 'grn_attach_file_link');

    if ($inline) {
        $mime_manager = GRN_MIMEConfigManager::getInstance();
        if ($mime_manager->isInlineImageMimeType($mime)) {
            $download_url .= '&nolog=1'; //GRB-15942
            if ($thumbnail_page
                && \grn\grn\ThumbnailUtil::isEnableInlineThumbnail()
            ) {
                $download_url .= '&thumbnail=1';
                $thumbnail_url = cb_pageurl($thumbnail_page, $params);
                $thumbnail_url .= '&nolog=1'; //GRB-15942
                if ($disabled) {
                    return '<a href="' . $thumbnail_url
                           . '" target="_blank"><img border="0" src="'
                           . $download_url . '"></a>&nbsp;('
                           . htmlspecialchars($mime) . ')&nbsp;' . $size;
                } else {
                    return '<a href="' . $thumbnail_url
                           . '" target="_blank"><img border="0" src="'
                           . $download_url . '"></a>&nbsp;('
                           . htmlspecialchars($mime) . ')&nbsp;<a href="'
                           . $view_url . '">' . $msg . '</a>&nbsp;' . $size;
                }
            }

            if ($disabled) {
                return '<img src="' . $download_url . '">&nbsp;('
                       . htmlspecialchars($mime) . ')&nbsp;' . $size;
            } else {
                return '<img src="' . $download_url . '">&nbsp;('
                       . htmlspecialchars($mime) . ')&nbsp;<a href="'
                       . $view_url . '">' . $msg . '</a>&nbsp;' . $size;
            }
        }
    }

    if ($image) {
        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $image = smarty_function_grn_image(['image' => $image], $smarty);
    }

    if ($disabled) {
        return $image . htmlspecialchars($name) . '&nbsp;('
               . htmlspecialchars($mime) . ')&nbsp;' . $size;
    } else {
        return '<a class="with_lang" href="' . $download_url . '">' . $image
               . htmlspecialchars($name) . '</a>&nbsp;('
               . htmlspecialchars($mime) . ')&nbsp;<a href="' . $view_url . '">'
               . $msg . '</a>&nbsp;' . $size;
    }

    /**
     * // get file info from GRN_FileManager
     * require_once( 'grn/file.csp' );
     * $file_manager = GRN_FileManager::getInstance();
     * $file_table =& $file_manager->getFileTable();
     * if( ! $file_table ) {
     * return 'fid is not valid';
     * }
     * $file =& $file_table->getRow( $fid );
     * if ( ! $file ) {
     * return 'fid is not valid';
     * }
     * $body =& $file->getCurrentBody();
     * if ( ! $body ) {
     * return 'fid is not valid';
     * }
     *
     * $file_name = $body->get( 'name' );
     * $file_mime_type = $body->get( 'mime' );
     * $file_size = $body->get( 'size' );
     *
     * // create html expression
     * //// page url's are not fixed, 10/22/2004
     * $pageurl_parameters = array( 'fid' => $fid );
     * $file_download_url = cb_pageurl('grn/file_download', $pageurl_parameters);
     * $file_detail_url = cb_pageurl('grn/file_view', $pageurl_parameters);
     * $html = '<a href=' . $file_download_url . '>' . $file_name . '</a> ' . $file_mime_type . '<a href="' . $file_detail_url . '">詳細</a> ' . $file_size;
     * return $html;
     **/
}

