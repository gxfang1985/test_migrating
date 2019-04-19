<?php

/**
 * @name   grn_mobile_attach_file_link
 * @description show the link of the attached file information by the specified file id
 *
 * @param string name   filename
 * @param string class  css class
 * @param string dpage  download page for the file
 * @param array  params arguments for cb_pageurl
 *
 * @param bool   inline
 */
function smarty_function_grn_mobile_attach_file_link($params, &$smarty)
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

    $class = 'mobile-icon-attachment-left-grn';
    if (array_key_exists('class', $params)) {
        $class = $params['class'];
        unset($params['class']);
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
    require_once('grn/ui.csp');
    $html = '<a data-role="button" href="' . $download_url . '"><span class="'
            . $class . '"></span><span class="mobile-font-normal-grn">'
            . htmlspecialchars($name) . '</span></a>';

    return $html;
}

