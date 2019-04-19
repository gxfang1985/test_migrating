<?php
/**
 * @name   grn_cabinet_folder_title
 *  組織名表示
 *
 * @date   2005/01/16
 * @author Y.Tanaka
 *
 * @param  string  hid     フォルダID
 * @param  string  title   フォルダタイトル
 *
 */

function smarty_function_grn_cabinet_folder_title($params, &$smarty)
{
    $function_name = 'grn_cabinet_folder_title';

    if ( ! array_key_exists('hid', $params)) {
        if (array_key_exists('id_name', $params)) {
            $id_name = $params['id_name'];
        } else {
            $id_name = null;
        }

        if (array_key_exists('id_value', $params)) {
            $id_value = $params['id_value'];
        } else {
            $id_value = null;
        }

        if ( ! $id_name) {
            return htmlspecialchars($function_name)
                   . ': missing id_name parameter';
        }
        unset($params['id_name']);
        unset($params['id_value']);

        $params[$id_name] = $id_value;
    }

    if (array_key_exists('title', $params)) {
        $caption = $params['title'];
        unset($params['title']);
    } else {
        $caption = null;
    }

    if (array_key_exists('open', $params)) {
        $open = $params['open'];
        unset($params['open']);
    } else {
        $open = null;
    }

    if (array_key_exists('child', $params)) {
        $child = $params['child'];
        unset($params['child']);
    } else {
        $child = null;
    }

    if (array_key_exists('notified', $params)) {
        $notified = $params['notified'];
        unset($params['notified']);
    } else {
        $notified = null;
    }

    if (array_key_exists('subscribed', $params)) {
        $subscribed = $params['subscribed'];
        unset($params['subscribed']);
    } else {
        $subscribed = null;
    }

    if ( ! array_key_exists('caption', $params)) {
        $params['caption'] = $caption;
    }

    if ( ! array_key_exists('image', $params)) {
        $image = 'folder20.gif';

        if ($open) {
            if ($child) {
                $image = 'folder20_co.gif';
            }
        } else {
            if ($child) {
                $image = 'folder20_c.gif';
            }
        }
        $params['image'] = $image;
    }

    if (array_key_exists('params', $params)) {
        $args = $params['params'];
        unset($params['params']);

        if ($args) {
            $params += $args;
        }

        unset($args);
    }

    require_once($smarty->_get_plugin_filepath('function', 'grn_link'));

    $link_string = smarty_function_grn_link($params, $smarty);

    if ($child) {
        $link_string .= '(' . htmlspecialchars($child) . ')';
    }

    if ($notified || $subscribed) {
        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $link_string .= '&nbsp;'
                        . smarty_function_grn_image(['image' => 'subscribe20.png'],
                $smarty);
    }

    return $link_string;
}


