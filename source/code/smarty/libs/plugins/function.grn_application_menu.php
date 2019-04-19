<?php

use grn\grn\access\service\AppAccess;

/**
 * @name   grn_application_menu
 * @description アプリケーションメニューを出力する
 *
 * @date        2005/01
 * @author      YOSHIDA, Hideyasu
 *
 * @param
 */
function smarty_function_grn_application_menu($parameters, & $smarty)
{
    require_once('report/resources.csp');
    require_once('workflow/resources.csp');

    // ログインユーザーを取得する
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();

    // UIの共通設定管理ロジックを取得する
    require_once('grn/ui.csp');
    $manager = GRN_UIConfigManager::getInstance();



    // アプリケーションメニューの表示/非表示を判定する
    if ( ! getHeaderSettingFromConfig('getDisplayApplicationMenu')) {
        return '<div class="applicationMenu-grn"></div>' ;
    }

    $menu_style = getHeaderSettingFromConfig('getApplicationMenuStyle');

    // ロケータ（アプリケーションが使用できるかどうかの判定のため）
    require_once('grn/application.csp');
    $app_locator = GRN_ApplicationLocator::instance();

    $app_menus = '';

    // メニューを取得する
    $menu = $manager->getDefaultApplicationMenu();

    // アプリケーションパスの取得
    global $G_config_common;
    $app_path = $G_config_common->get('Global', 'app_path');
    $app_ids_available
        = AppAccess::getAllAppIdsAvailableByUserId(cb_get_login_user()->getOID());
    $list = $menu->listMenu();
    foreach ($list as $key => $item) {
        if (($item['app_id'] == 'report' || $item['app_id'] == 'workflow')
            && ! $app_locator->isLicensed($item['app_id'])
        ) {
            continue;
        }
        $location = $item['location'];
        $name = $item['name'];
        $app_id = $item['app_id'];
        $link = '';
        $icon = '';

        if ( ! is_null($app_id)) {
            // 利用可能でない場合、そのメニューを表示しない
            if ( ! in_array($app_id, $app_ids_available)) {
                continue;
            }
            $location = cb_format_url($location);
            $icon = $item['icon'];
        } else {
            require_once('grn/controller.csp');
            $location = grn_safe_url($location);
            $item['icon'] = grn_safe_url($item['icon']);
            $icon = $item['icon'];
        }

        $link = _smarty_function_grn_application_menu_createAppIcon($menu_style,
            $location, $app_path, $app_id, $name, $icon);

        $app_menus .= "$link";
    }

    $retval = ' <div class="applicationMenu-grn">';

    $retval .= '<div class="appMenuDecoration-grn"></div><div id="applicationMenu"';
    require_once('grn/appmenu_state_last_access.csp');
    $state = grn_appmenu_get_state_last_access($login);

    if ($state == 0) {
        $retval .= " style='overflow-y: hidden;display:none' >";
        $className = "appmenuCollapse";
    } else {
        $retval .= " style='overflow-y: hidden;display:block' >";
        $className = "appmenuExpand";
    }

    $retval .= '<div class="margin_bottom">';
    $retval .= '<div class="application_menu">';
    $retval .= $app_menus;
    $retval .= '</div>';
    $retval .= '</div><div style="clear:both;"></div>';
    $retval .= " </div>";
    $retval .= ' <div class="appmenuToggleWrapper"  onclick="ToggleApplicationMenu();"> ';
    $retval .= ' <div id="appmenuToggler" class="';
    $retval .= $className;
    $retval .= '" ></div></div></div>';

    return $retval;
}

/**
 * アプリケーションメニューを作成する
 */
function _smarty_function_grn_application_menu_createAppIcon(
    $menu_style,
    $location,
    $app_path,
    $app_id,
    $name,
    $icon
) {
    require_once 'fw/ui.csp';
    $button_standard
        = '<span class="appmenu-item" %s title="%s"><a href="%s"><div class="icon-appMenu-%s appmenu-item-icon"></div><div><nobr>%s</nobr></div></a></span>';
    $button_icon_text
        = '<span class="appmenu-item" %s title="%s"><a href="%s"><img src="%s" alt="%s" class="appmenu-item-icon" border="0" /><div><nobr>%s</nobr></div></a></span>';
    $button_noicon_text
        = '<span class="appmenu-item" %s><a href="%s"><nobr>%s</nobr></a></span>';

    $escaped_location = htmlspecialchars($location, ENT_QUOTES);
    $escaped_name = htmlspecialchars($name);

    global $G_config_common;
    $is_debug = ($G_config_common->get('Global', 'debug')
                 & ERROR_TRACE_LOG_FLAG_213);
    global $G_config_grn;
    if ( ! $G_config_grn || $is_debug) {
        $build_date = time();
    } else {
        $build_date = $G_config_grn->get('System', 'build_date');
    }

    $build_date .= '.text';

    if ( ! is_null($app_id)) {
        require_once('schedule/resources.csp');
        if ($app_id == GRN_SCHEDULE_APPLICATION_ID
            && strpos($location, "schedule/facility_index") !== false
        ) {
            $app_id = "facility";
        }

        if ($menu_style == 'NoIcon') {
            return sprintf($button_noicon_text,
                'id="appmenu-' . $app_id . '"',
                $escaped_location,
                $escaped_name);
        } else {
            return sprintf($button_standard,
                'id="appmenu-' . $app_id . '"',
                $escaped_name,
                $escaped_location,
                $app_id,
                $escaped_name);
        }
    } else {
        if (strlen($icon) > 0) // アイコンがある
        {
            if ($menu_style == 'NoIcon') {
                return sprintf($button_noicon_text,
                    '',
                    $escaped_location,
                    $escaped_name);
            } else {
                if (strpos($icon, '?') === false) {
                    $img_src = $icon . '?' . $build_date;
                } else {
                    $img_src = $icon . '&' . $build_date;
                }

                return sprintf($button_icon_text,
                    '',
                    $escaped_name,
                    $escaped_location,
                    $img_src,
                    $escaped_name,
                    $escaped_name);
            }
        } else // アイコンがない
        {
            if ($menu_style == 'NoIcon') {
                return sprintf($button_noicon_text,
                    '',
                    $escaped_location,
                    $escaped_name);
            } else {
                return sprintf($button_standard,
                    '',
                    $escaped_name,
                    $escaped_location,
                    'defaultmenu',
                    $escaped_name);
            }
        }
    }
}
