<?php

/**
 * @name   smarty_function_grn_attach_file_link_no_view
 * @description show the link of the attached file information by the specified temporary file id
 *
 * @date        2012/06/07
 * @author      vinh pham
 *
 * @param string name   filename
 * @param string mime   mime type
 * @param string dpage  download page for the file
 * @param array  params arguments for cb_pageurl
 *
 */
function smarty_function_grn_attach_file_link_no_view($params, &$smarty)
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

    $mime = '';
    $ext = substr(strrchr($name, '.'), 1);
    if (strlen($ext) > 0) {
        require_once('grn/mime.csp');
        $mcm = GRN_MIMEConfigManager::getInstance();
        $mime = $mcm->getMIMEType($ext);
    }
    if ( ! is_string($mime) || strlen($mime) == 0) {
        $mime = 'application/octet-stream';
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


    $msg = cb_msg('fw.ui', 'grn_attach_file_link');

    if ($inline) {
        $mime_manager = GRN_MIMEConfigManager::getInstance();
        if ($mime_manager->isInlineImageMimeType($mime)) {
            return '<img src="' . $download_url . '">&nbsp;('
                   . htmlspecialchars($mime) . ')&nbsp;';
        }
    }

    if ($image) {
        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $image = smarty_function_grn_image(['image' => $image], $smarty);
    }

    if ($disabled) {
        return $image . htmlspecialchars($name) . '&nbsp;('
               . htmlspecialchars($mime) . ')&nbsp;';
    } else {
        return '<a class="with_lang" href="' . $download_url . '">' . $image
               . htmlspecialchars($name) . '</a>&nbsp;('
               . htmlspecialchars($mime) . ')&nbsp;';
    }


}

