<?php

function smarty_function_grn_site_position_category($parameters, &$smarty)
{
    $app_name = explode('/', $parameters['page']);
    $app_name = $app_name[0];
    $caption = '';
    $locator = GRN_ApplicationLocator::instance();

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();

    require_once("fw/i18n.csp");
    require_once("fw/i18n/locale.csp");
    $i18n = CB_I18N::getInstance();
    $default_locale = CB_LocaleManager::getCurrentLanguage($login->getOID());

    switch ($app_name) {
        case 'bulletin':
            $app = $locator->getInstance('bulletin');
            $caption = $app->getName();
            $value_key = 'cid';
            break;
        case 'cabinet':
            $app = $locator->getInstance('cabinet');
            $caption = $app->getName() . '(' . cb_msg('grn.bulletin',
                    'root_category_name', null, $default_locale) . ')';
            $value_key = 'hid';
            break;
    }

    if (array_key_exists('positions', $parameters)) {
        $positions = (array)$parameters['positions'];
    } else {
        $positions = [];
    }
    require_once($smarty->_get_plugin_filepath('function', 'grn_link'));

    $link_array = [];
    foreach ($positions['ancestors'] as $key => $site_info) {
        if ($key == 1) {
            $params = [
                'page'     => $parameters['page'],
                $value_key => $site_info[$value_key],
                'sf'       => 1,
                'caption'  => $caption
            ];
        } else {
            $params = [
                'page'     => $parameters['page'],
                $value_key => $site_info[$value_key],
                'caption'  => $site_info['name']
            ];
        }
        $link_position = smarty_function_grn_link($params, $smarty);
        $link_array[] = $link_position;
    }

    $link_array[] = htmlspecialchars($positions['name']);
    $link = '';
    // if( count($link_array) )
    // {
    // $link = implode('&nbsp;&gt;&nbsp;', $link_array);
    // }
    $max_link = count($link_array);
    foreach ($link_array as $key => $value) {
        if ($key < $max_link - 1) {
            $link .= "<span class='globalNavi-item-grn'>" . $value . "</span>";
            $link .= "<span class='globalNavi-item-grn-image'></span>";
        } else {
            $link .= "<span class='globalNavi-item-last-grn'>" . $value
                     . "</span>";
        }
    }

    $image_param = ['image' => grn_site_position_app2image($app_name)];
    require_once('function.grn_image.php');

    return '<div class="global_navi">&nbsp;'
           . smarty_function_grn_image($image_param, $smarty) . $link
           . '</div>';
}

function grn_site_position_app2image($app_name)
{
    $app2image = [
        'bulletin' => 'bulletin20.gif',
        'cabinet'  => 'file20.gif',
    ];
    if (array_key_exists($app_name, $app2image)) {
        return $app2image[$app_name];
    } else {
        return '';
    }
}

