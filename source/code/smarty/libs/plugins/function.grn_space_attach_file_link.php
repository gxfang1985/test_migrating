<?php

/**
 * @name   grn_space_attach_file_link
 * @description show the link of the attached file information by the specified file id
 *
 * @param string fid    file id
 * @param string name   filename
 * @param string size   size in byte
 * @param string mime   mime type
 * @param string class  css class
 * @param string dpage  download page for the file
 * @param string vpage  view page for the file
 * @param string upage  upload page for the file
 * @param bool   upload where show upload link
 * @param array  params arguments for cb_pageurl
 *
 * @param bool   inline
 */
function smarty_function_grn_space_attach_file_link($params, &$smarty)
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

    $upage = null;
    if (array_key_exists('upage', $params)) {
        $upage = $params['upage'];
        unset($params['upage']);
    }

    $upload = false;
    if (array_key_exists('upload', $params)) {
        $upload = $params['upload'];
        unset($params['upload']);
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

    $disabled = null;
    if (array_key_exists('disabled', $params)) {
        $disabled = $params['disabled'];
        unset($params['disabled']);
    }

    $class = 'icon-attachedFile-grn';
    if (array_key_exists('class', $params)) {
        $class = $params['class'];
        unset($params['class']);
    }

    $short = false;
    if (array_key_exists('short', $params)) {
        $short = $params['short'];
        unset($params['short']);
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
        $ticket = GRN_Ticket::create($user->getOID());
        $download_url .= '&ticket=' . $ticket;
        $params['ticket'] = $ticket;
    }

    $view_url = cb_pageurl($vpage, $params, null, null);
    $msg = cb_msg('fw.ui', 'grn_attach_file_link');

    if ($short) {
        if ($disabled) {
            return htmlspecialchars($name);
        } else {
            return '<a class="' . $class . '" href="' . $download_url . '">'
                   . htmlspecialchars($name) . '</a>';
        }
    }

    if ($inline) {
        $images = [
            'image/gif'   => 1,
            'image/jpeg'  => 1,
            'image/pjpeg' => 1,
            'image/png'   => 1
        ];

        if (array_key_exists($mime, $images)) {
            $download_url .= '&thumbnail=1';
            $html = '<span>';
            $html = $html . '<a href="' . cb_pageurl('space/file_view',
                    $params) . '" target="_blank"><img border="0" src="'
                    . $download_url . '"></a>&nbsp;<nobr>';
            if ($disabled) {
                $html = $html . $size;
            } else {
                $html = $html . '<a href="' . $view_url . '">' . $msg
                        . '</a>&nbsp;' . $size;
            }
            if ($upload) {
                $html = $html . getUploadLink($upage, $params);
            }
            $html = $html . '</nobr></span>';

            return $html;
        }
    }

    if ($disabled) {
        $html = htmlspecialchars($name) . '&nbsp;<nobr>' . $size;
    } else {
        $html = '<a class="' . $class . '" href="' . $download_url . '">'
                . htmlspecialchars($name) . '</a>&nbsp;<nobr><a href="'
                . $view_url . '">' . $msg . '</a>&nbsp;' . $size;
    }
    if ($upload) {
        $html = $html . getUploadLink($upage, $params);
    }
    $html = $html . '</nobr>';

    return $html;
}

function getUploadLink($upage, $params)
{
    return '<a class="icon-fileUpload-block-grn" href="' . cb_pageurl($upage, [
            'tid'          => $params['tid'],
            'spid'         => $params['spid'],
            'fid'          => $params['fid'],
            'index_return' => 'true'
        ]) . '"></a>';
}

