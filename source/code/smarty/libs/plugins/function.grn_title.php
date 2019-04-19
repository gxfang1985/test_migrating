<?php
/**
 * @param  array     $params
 *                    string title             タイトル
 *                    string class             クラスの指定
 *                    string caption_module    キャプションモジュール
 *                    string caption_key       キャプションキー
 *                    string id                エレメントid
 *                    string no_style
 * @param GRN_Smarty $smarty
 *
 * @return string
 */
function smarty_function_grn_title($params, &$smarty)
{
    $default_style = cb_at($params, 'no_style') ? ''
        : ' style="display:inline;"';

    // class
    $attribute = ' class="' . htmlspecialchars($params['class']) . '"';

    // id
    if (isset($params['id']) === true) {
        $attribute .= ' id="' . htmlspecialchars($params['id']) . '"';
    }

    // caption
    if (array_key_exists('caption_module', $params)
        && array_key_exists('caption_key', $params)
    ) {
        $caption_module = $params['caption_module'];
        $caption_key = $params['caption_key'];

        // cb_msgはリソースから値を取得するのでエスケープする必要がない
        return '<h2' . $default_style . $attribute . '>'
               . cb_msg($caption_module, $caption_key) . '</h2>';
    }

    // title
    if (array_key_exists('event_menu_color', $params)
        && $params['event_menu_color'] != ''
        && $params['event_menu_color'] != '0'
        && array_key_exists('event_detail', $params)
    ) {
        $title = '<span class=event_color' . $params['event_menu_color']
                 . '_grn >' . htmlspecialchars($params['event_menu'])
                 . '</span>' . htmlspecialchars($params['event_detail']);
    } else {
        $title = htmlspecialchars($params['title']);
    }

    // private title
    if (array_key_exists('is_private', $params) && $params['is_private']) {
        return $str = '<h2' . $default_style . $attribute . '>' . $title . ' ' .
                      cb_msg("fw.common", "private-left-parenthesis") .
                      '<span class="icon-private-grn"></span>' .
                      cb_msg("fw.common", "private") .
                      cb_msg("fw.common", "private-right-parenthesis")
                      . '</h2>';
    }

    if (array_key_exists('style', $params)) {
        return $str = '<h2 style="' . $params['style'] . '"' . $attribute . '>'
                      . $title . '</h2>';
    }

    return $str = '<h2' . $default_style . $attribute . '>' . $title . '</h2>';
}
