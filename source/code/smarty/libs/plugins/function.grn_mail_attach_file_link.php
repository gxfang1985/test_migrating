<?php

/**
 * @name grn_mail_attach_file_link
 * @description show the link of the attached file information by the specified file id
 *
 * @param string  fid        file id
 * @param string name   filename
 * @param string size   size in byte
 * @param string mime   mime type
 * @param string dpage  download page for the file
 * @param string vpage  view page for the file
 * @param array  params arguments for cb_pageurl
 * @param bool     inline
 *
 * @option      boolean receive
 * @option      boolean disabled
 *
 * @param bool   browse file name plus icon
 * @param string three_pane  is from 3pane page
 */
function smarty_function_grn_mail_attach_file_link($params, &$smarty)
{
    global $G_config_common;
    $app_path = $G_config_common->get('Global', 'app_path');

    $is_debug = ($G_config_common->get('Global', 'debug')
                 & ERROR_TRACE_LOG_FLAG_213);
    $config_grn = new CB_ConfigManager(cb_basedir() . '/garoon.ini', 'Global');
    if ( ! $config_grn || $is_debug) {
        $build_date = time();
    } else {
        $build_date = $config_grn->get('System', 'build_date');
    }
    $build_date .= '.text';

    require_once('mail/utility.csp');
    $utility = GRN_Mail_Utility::getInstance();
    $mail_app = $utility->getMailApp();

    $name = null;
    if (array_key_exists('name', $params)) {
        $name = htmlspecialchars($params['name']);
        unset($params['name']);
    }
    if (strlen($name) == 0) {
        $name = cb_msg($mail_app->getModuleId(), 'no_filename');
        //return 'name not found';
    }

    $mime = null;
    if (array_key_exists('mime', $params)) {
        $mime = $params['mime'];
        unset($params['mime']);
    }

    if (is_null($mime)) {
        $mime = "application/octet-stream";
    }

//    $sent = @ $params['sent'];

    $receive = @ $params['receive'];
    unset($params['receive']);

    $no_source = @ $params['no_source'];
    unset($params['no_source']);

    $no_rfc822link = @ $params['no_rfc822link'];
    unset($params['no_rfc822link']);

    if ($no_source) {
        return $name . '&nbsp;(' . htmlspecialchars($mime) . ')';
    }

    $dpage = null;
    if (array_key_exists('dpage', $params)) {
        $dpage = $params['dpage'];
        unset($params['dpage']);
    }
    if ( ! $dpage) {
        return 'dpage not found';
    }

    /*
        $size = null;
        if( array_key_exists( 'size', $params ) ) {
            $size = $params['size'];
            unset( $params['size'] );
            $size = sprintf( "%.1f&nbsp;KB", floatval($size) * 0.001 );
        }
    */
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

    $browse = false;
    if (array_key_exists('browse', $params)) {
        $browse = $params['browse'];
        unset($params['browse']);
    }

    $three_pane = false;
    if (array_key_exists('three_pane', $params)) {
        $three_pane = $params['three_pane'];
        unset($params['three_pane']);
    }

    $user_params = null;
    if (array_key_exists('params', $params)) {
        $user_params = $params['params'];
        unset($params['params']);
    }

    if ($user_params) {
        $params += $user_params;
    }

    $return_string = '';

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

    if ($inline) {
        $mime_manager = GRN_MIMEConfigManager::getInstance();
        if ($mime_manager->isInlineImageMimeType($mime)) {

            if (\grn\grn\ThumbnailUtil::isEnableInlineThumbnail()) {
                $download_url .= '&thumbnail=1';

                return '<a href="' . cb_pageurl('mail/file_image_view', $params)
                       . '" target="_blank"><img border="0" src="'
                       . $download_url . '"></a>';
            } else {
                return '<img src="' . $download_url . '">&nbsp;('
                       . htmlspecialchars($mime) . ')&nbsp;';
            }
        }
    }

    $msg = cb_msg('grn.mail', 'mail_attach_file_link_warnning');
    if ($three_pane) {
        if ($disabled) {
            $return_string .= '<a name="javascript:void(0);">' . $name
                              . '</a>&nbsp;(' . htmlspecialchars($mime)
                              . ')&nbsp;';
        } else {
            if ($receive) {
                if ($browse) {
                    $return_string .= '<a class="icon_attachment_small_grn" href="'
                                      . $download_url
                                      . '" onclick=\'if(confirm("' . $msg
                                      . '")){return true;}return false;\'>'
                                      . $name . '</a>';
                } else {
                    $return_string .= '<a class="with_lang icon_attachment_grn" href="'
                                      . $download_url
                                      . '" onclick=\'if(confirm("' . $msg
                                      . '")){return true;}return false;\'>'
                                      . $name
                                      . '</a><span class="vAlignMiddle-grn">&nbsp;('
                                      . htmlspecialchars($mime)
                                      . ')&nbsp;</span>';
                }
            } else {
                if ($browse) {
                    $return_string .= '<a class="icon_attachment_small_grn" href="'
                                      . $download_url . '">' . $name . '</a>';
                } else {
                    $return_string .= '<a class="with_lang icon_attachment_grn" href="'
                                      . $download_url . '">' . $name
                                      . '</a><span class="vAlignMiddle-grn">&nbsp;('
                                      . htmlspecialchars($mime)
                                      . ')&nbsp;</span>';
                }
            }
        }
    } else {
        if ($disabled) {
            $return_string .= '<a name="#"><img src="'
                              . htmlspecialchars($app_path)
                              . '/grn/image/cybozu/clip8x20.gif?' . $build_date
                              . '" border="0">' . $name . '</a>&nbsp;('
                              . htmlspecialchars($mime) . ')&nbsp;';
        } else {
            if ($receive) {
                $return_string .= '<a class="with_lang" href="' . $download_url
                                  . '" onclick=\'if(confirm("' . $msg
                                  . '")){return true;}return false;\'><img src="'
                                  . htmlspecialchars($app_path)
                                  . '/grn/image/cybozu/clip8x20.gif?'
                                  . $build_date . '" border="0">' . $name
                                  . '</a>&nbsp;(' . htmlspecialchars($mime)
                                  . ')&nbsp;';
            } else {
                $return_string .= '<a class="with_lang" href="' . $download_url
                                  . '"><img src="' . htmlspecialchars($app_path)
                                  . '/grn/image/cybozu/clip8x20.gif?'
                                  . $build_date . '" border="0">' . $name
                                  . '</a>&nbsp;(' . htmlspecialchars($mime)
                                  . ')&nbsp;';
            }
        }
    }
    if (($mime == 'message/rfc822') && ! $no_rfc822link && ! $browse) {
        $fid = @ $params['fid'];
        assert(' ! is_null( $fid ) || ( strlen( $fid ) > 0 )');
        $pids = @ $params['pids'];
        if (is_null($pids) || (strlen($pids) == 0)) {
            $mid = @ $params['mid'];
            assert(' ! is_null( $mid ) || ( strlen( $mid ) > 0 )');
            $pids = $mid . '.' . $fid;
        } else {
            $pids .= '.' . $fid;
        }

        $params['pids'] = $pids;

        $rfc822_title = cb_msg($mail_app->getModuleId(), 'show_rfc822');
        $rfc822_url = cb_pageurl('mail/rfc822', $params);

        if ($receive) {
            $return_string .= '<a class="with_lang" href="' . $rfc822_url
                              . '" onclick=\'if(confirm("' . $msg
                              . '")){return true;}return false;\'>'
                              . $rfc822_title . '</a>&nbsp;';
        } else {
            $return_string .= '<a class="with_lang" href="' . $rfc822_url . '">'
                              . $rfc822_title . '</a>&nbsp;';
        }
    }

    return $return_string;
}

