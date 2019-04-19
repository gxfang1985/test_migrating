<?php
require_once('grn/ui.csp');

/**
 * @name   grn_link_raw
 *  イメージ付外部リンクの出力
 *
 * @date   2005/1/13
 * @author K.Tokuta
 * @option string  caption           リンクキャプション
 * @option integer truncated_caption キャプションをtruncateする文字数
 * @option string  caption_module    キャプションモジュール
 * @option string  caption_key       キャプションキー
 *
 * @param  string  page              画面名
 *
 * @option string  script            JavaScript
 * @option string  fragment          flagment
 * @option string  postfix           postfix
 * @option string  class             class名
 * @option string  image             イメージファイル名
 * @option boolean image_direct      外部イメージファイルか否か
 * @option string  alt               IMAGEタグのALT属性
 * @option string  target            AタグのTARGET属性
 * @option string  title             AタグのTITLE属性
 * @option boolean disabled          無効化するかどうか
 * @option boolean unread            未読かどうか
 * @option boolean br                改行するかどうか
 * @option string  element_id        AタグのID属性
 * @option array   params            その他のパラメータ
 * @option boolean skip_params       パラメータチェック処理をスキップするかどうか
 */

function smarty_function_grn_link_raw($params, &$smarty)
{
    $function_name = 'grn_link_raw';

    if (array_key_exists('skip_params', $params)) {
        $skip_params = (bool)$params['skip_params'];
    } else {
        $skip_params = false;
    }

    if ( ! $skip_params) {
        $params = grn_ui_link_params($params, $function_name, $smarty);
    }

    if (array_key_exists('script', $params)) {
        $script = $params['script'];
    } else {
        $script = null;
    }

    $page = $script ? $script : $params['page'];
    $caption = $params['caption'];
    $target_area = $params['target_area'];

    if (array_key_exists('title_area', $params)) {
        $title_area = $params['title_area'];
    } else {
        $title_area = null;
    }

    if (array_key_exists('class', $params)) {
        $class = $params['class'];
    } else {
        $class = null;
    }

    if (array_key_exists('disabled', $params)) {
        $disabled = $params['disabled'];
    } else {
        $disabled = null;
    }

    if (array_key_exists('unread', $params)) {
        $unread = $params['unread'];
        //GRN2-4027
        if (array_key_exists('mail_unread_id', $params)) {
            $mail_unread_id = $params['mail_unread_id'];
        } else {
            $mail_unread_id = null;
        }
        //GRN2-4027
    } else {
        $unread = null;
    }

    if (array_key_exists('br', $params)) {
        $br = $params['br'];
    } else {
        $br = null;
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

    if (array_key_exists('alt', $params)) {
        $alt = $params['alt'];
    } else {
        $alt = null;
    }

    if (array_key_exists('postfix', $params)) {
        $postfix = $params['postfix'];
    } else {
        $postfix = null;
    }

    if (array_key_exists('no_image_class', $params)) {
        $no_image_class = $params['no_image_class'];
    } else {
        $no_image_class = null;
    }

    $return_string = '';
    $img_tag = '';
    if ($image) {
        if ( ! $no_image_class) {
            $image_params = [
                'image' => $image,
                'alt'   => $alt,
                'class' => $class
            ];
        } else {
            $image_params = ['image' => $image, 'alt' => $alt];
        }
        if ($image_direct) {
            static $include_grn_image_raw = false;
            if ($include_grn_image_raw === false) {
                require_once($smarty->_get_plugin_filepath('function',
                    'grn_image_raw'));
                $include_grn_image_raw = true;
            }
            $img_tag = smarty_function_grn_image_raw($image_params, $smarty);
        } else {
            static $include_grn_image = false;
            if ($include_grn_image === false) {
                require_once($smarty->_get_plugin_filepath('function',
                    'grn_image'));
                $include_grn_image = true;
            }
            $img_tag = smarty_function_grn_image($image_params, $smarty);
        }
    }

    if ($disabled) {
        $return_string .= '<span class="' . htmlspecialchars($class)
                          . '" name="#">' . $img_tag . $caption . '</span>';
    } else {
        $pattern = "/[\\\\<>\"\s]/";
        $page = preg_replace($pattern, "", $page);
        //URLに使用不可能な文字を除外 
        if (array_key_exists('no_script', $params)) {
            require_once('grn/controller.csp');
            $page = grn_safe_url($page);
        }
        //$pattern = "/[^a-zA-Z0-9\-._~%:\/?#\[\]@!$&'()*+,;=]/"; 
        //insert id for link
        $id = '';
        if (array_key_exists('id', $params)) {
            $id = 'id="' . htmlspecialchars($params['id']) . '"';
        }
        if (array_key_exists('element_id', $params)) {
            $id = 'id="' . htmlspecialchars($params['element_id']) . '"';
        }

        //ファイルダウンロード用に、$postfixが指定されていれば、with_langクラスを追加する
        $with_lang = '';
        if (strlen($postfix) !== 0) {
            $with_lang = (strlen($class) !== 0) ? 'with_lang ' : 'with_lang';
        }
        $class_text = '';
        if (strlen($class) !== 0) {
            $class_text = ' class="' . $with_lang . htmlspecialchars($class)
                          . '"';
        }
        $return_string .= '<a ' . $id . $class_text . $title_area . ' href="'
                          . $page . '"' . $target_area . '>';
        if ($unread) {
            //GRN2-4027
            if ($mail_unread_id) {
                $return_string .= $img_tag
                                  . "<span class='bold' id=$mail_unread_id>"
                                  . $caption . '</span></a>';
            } else {
                $return_string .= $img_tag . '<span class="bold">' . $caption
                                  . '</span></a>';
            }
            //GRN2-4027
        } else {
            $return_string .= $img_tag . $caption . '</a>';
        }
    }

    if ( ! $br) {
        $wrapper_class = cb_at($params, 'wrapper_class', '');
        $return_string = '<span class="nowrap-grn '
                         . htmlspecialchars($wrapper_class) . '">'
                         . $return_string . '</span>';
    }

    return $return_string;
}

