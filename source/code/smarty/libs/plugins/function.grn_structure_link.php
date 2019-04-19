<?php
require_once 'fw/ui.csp';

/**
 * @name   grn_structure_link
 *  イメージ付リンクの出力
 *
 * @date   2004/10/13
 * @author KAMBE,Shinichi
 *
 * @param  string  caption         リンクキャプション
 * @param  integer truncated_caption キャプションをtruncateする文字数
 * @param  string  caption_module  キャプションモジュール
 * @param  string  caption_key     キャプションキー
 * @param  string  page            画面名
 * @param  string  fragment        URLフラグメント
 * @param  string  script          JavaScript
 * @param  string  class           イメージファイル名
 *
 * @option string  target          AタグのTARGET属性
 * @option boolean disabled        無効化するかどうか
 * @option boolean focus           選択状態かどうか
 * @option boolean unread          未読かどうか
 * @date   2004/12/22 追加変更(Okahashi)
 * @option string  setup           購読かどうか
 * @option string  unread_num      未読数
 * @option string  all_num         総数
 * @date   2005/04/22 追加変更(SHIMADA)
 * @option string  image           画像名
 * @option boolean image_direct    外部イメージファイルか否か
 *
 */

function smarty_function_grn_structure_link($params, &$smarty)
{
    //-- create url parameters for cb_pageurl
    $url_params = $params;

    unset($url_params['caption']);
    unset($url_params['truncated_caption']);
    unset($url_params['caption_module']);
    unset($url_params['caption_key']);
    unset($url_params['page']);
    unset($url_params['fragment']);
    unset($url_params['postfix']);
    unset($url_params['class']);
    unset($url_params['target']);
    unset($url_params['disabled']);
    unset($url_params['focus']);
    unset($url_params['unread']);
    unset($url_params['setup']);
    unset($url_params['unread_num']);
    unset($url_params['all_num']);
    unset($url_params['script']);
    unset($url_params['image']);
    unset($url_params['image_direct']);

    //--get parames
    // is_truncated_caption
    $truncated_caption = (int)$params['truncated_caption'];

    // caption
    if (array_key_exists('caption', $params)) {
        $caption = $params['caption'];
        if ($truncated_caption) {
            $caption = mb_strimwidth($caption, 0, $truncated_caption, '...');
        }
        $caption = htmlspecialchars($caption);
    } else {
        $caption_module = $params['caption_module'];
        $caption_key = $params['caption_key'];
        $caption = cb_msg($caption_module, $caption_key);
    }

    if (array_key_exists('page', $params)) {
        $page = $params['page'];
    } else {
        $page = null;
    }

    if (array_key_exists('fragment', $params)) {
        $fragment = $params['fragment'];
    } else {
        $fragment = null;
    }

    if (array_key_exists('postfix', $params)) {
        $postfix = $params['postfix'];
    } else {
        $postfix = null;
    }

    $script = null;
    if (array_key_exists('script', $params)) {
        $script = $params['script'];
    }

    if (array_key_exists('class', $params)) {
        $class = $params['class'];
    } else {
        $class = null;
    }

    if (array_key_exists('image', $params)) {
        $image = $params['image'];
    } else {
        $image = null;
    }

    if (array_key_exists('image_direct', $params)) {
        $image_direct = $params['image_direct'];
    } else {
        $image_direct = null;
    }

    if (array_key_exists('target', $params)) {
        $target = $params['target'];
    } else {
        $target = null;
    }

    $target_area = $target ? (' target="' . htmlspecialchars($target) . '"')
        : '';

    if (array_key_exists('disabled', $params)) {
        $disabled = $params['disabled'];
    } else {
        $disabled = null;
    }

    if (array_key_exists('focus', $params)) {
        $focus = $params['focus'];
    } else {
        $focus = null;
    }

    if (array_key_exists('unread', $params)) {
        $unread = $params['unread'];
    } else {
        $unread = null;
    }

    if ($params['setup']) {
        $setup = true;
    }

    if (array_key_exists('unread_num', $params)) {
        $unread_num = $params['unread_num'];
    } else {
        $unread_num = null;
    }

    if (array_key_exists('all_num', $params)) {
        $all_num = $params['all_num'];
    } else {
        $all_num = null;
    }

    $img_tag = '';
    if ($image) {
        $image_params = ['image' => $image, 'alt' => $caption];
        if ($image_direct) {
            require_once($smarty->_get_plugin_filepath('function',
                'grn_image_raw'));
            $img_tag = smarty_function_grn_image_raw($image_params, $smarty);
        } else {
            require_once($smarty->_get_plugin_filepath('function',
                'grn_image'));
            $img_tag = smarty_function_grn_image($image_params, $smarty);
        }
    }

    $setup_image_tag = '';
    if ($setup) {
        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $setup_image_tag
            = smarty_function_grn_image(['image' => 'subscribe20.png'],
            $smarty);
    }

    if ($disabled) {
        return '<div class="tree_item"><nobr><a class="'
               . htmlspecialchars($class) . '" name="#">' . $img_tag . $caption
               . $setup_image_tag . '</a></nobr></div>';
    } else {
        $pageurl = $script ? htmlspecialchars($script)
            : cb_pageurl($page, $url_params, $fragment, $postfix);

        if ( ! is_null($unread_num) && $unread_num > 0) {
            if ($focus) {
                return '<div class="tree_item"><span class="hilight"><span class="bold"><a class="'
                       . htmlspecialchars($class) . '" href="' . $pageurl . '"'
                       . $target_area . '>' . $img_tag . $caption
                       . $setup_image_tag . '</a>('
                       . htmlspecialchars($unread_num)
                       . ')</nobr></span></span></div>';
            } else {
                if ($unread) {
                    return '<div class="tree_item"><nobr><a class="'
                           . htmlspecialchars($class) . '" href="' . $pageurl
                           . '"' . $target_area . '>' . $img_tag
                           . '<span class="bold">' . $caption . $setup_image_tag
                           . '</span></a>(' . htmlspecialchars($unread_num)
                           . ')</nobr></div>';
                } else {
                    return '<div class="tree_item"><nobr><a class="'
                           . htmlspecialchars($class) . '" href="' . $pageurl
                           . '"' . $target_area . '>' . $img_tag . $caption
                           . $setup_image_tag . '</a>('
                           . htmlspecialchars($unread_num) . ')</nobr></div>';
                }
            }
        } else {
            if ($focus) {
                return '<div class="tree_item"><span class="hilight"><span class="bold"><a class="'
                       . htmlspecialchars($class) . '" href="' . $pageurl . '"'
                       . $target_area . '>' . $img_tag . $caption
                       . $setup_image_tag . '</a></nobr></span></span></div>';
            } else {
                if ($unread) {
                    return '<div class="tree_item"><nobr><a class="'
                           . htmlspecialchars($class) . '" href="' . $pageurl
                           . '"' . $target_area . '>' . $img_tag
                           . '<span class="bold">' . $caption . $setup_image_tag
                           . '</span></a></nobr></div>';
                } else {
                    return '<div class="tree_item"><nobr><a class="'
                           . htmlspecialchars($class) . '" href="' . $pageurl
                           . '"' . $target_area . '>' . $img_tag . $caption
                           . $setup_image_tag . '</a></nobr></div>';
                }
            }
        }
    }
}

