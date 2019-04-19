<?php

/**
 * @name grn_button_cancel
 *
 * @description キャンセルボタン
 *      captionが指定されていれば、指定されたキャプション、指定されてなければ「キャンセルする」
 *      pageが指定されていれば、指定されたページへonClickで飛ぶ。指定がなければhistory.back()
 *      classは指定されたクラスを使用する
 *      残ったパラメータは飛び先のパラメータとして使用される
 *
 * @date        2004/10/20
 * @author      KAMBE,Shinichi
 * @option      string   caption    リンクキャプション
 * @option      string   page       画面名
 * @option      string   class      クラス
 * @option      boolean  disabled   禁止状態
 *
 * @date        2005/1/20
 * @author      K.Tokuta
 *
 */

function smarty_function_grn_button_cancel($params, &$smarty)
{
    $function_name = 'grn_button_cancel';

    // caption
    if (array_key_exists('caption', $params)) {
        $caption = $params['caption'];
        unset($params['caption']);
    } else {
        require_once('fw/i18n.csp');
        $caption = cb_msg('fw.ui', 'cancel');
    }

    // class
    $class = @ $params['class'];
    unset($params['class']);

    // disabled
    $disabled = (@ $params['disabled']) ? ' disabled' : '';
    unset($params['disabled']);

    // fragment
    if (array_key_exists('fragment', $params)) {
        $fragment = $params['fragment'];
    } else {
        $fragment = null;
    }
    unset($params['fragment']);

    //insert id for button
    $id = '';
    if (array_key_exists('id', $params)) {
        $id = htmlspecialchars($params['id']);
    }


    // page
    if (array_key_exists('page', $params)) {
        $page = $params['page'];
        unset($params['page']);

        // cb_pageurlは内部でhtmlspecialcharsを実行している。
        $location = 'location.href=\'' . cb_pageurl($page, $params, $fragment)
                    . '\';';
        $url = cb_pageurl($page, $params, $fragment);
    } else {
        $location = 'history.back()';
        $url = 'back';
    }

    if (array_key_exists('module', $params) && strlen($params['module']) > 0
        && $params['module'] == 'schedule'
    ) {
        $update_back_step = array_key_exists('update_back_step', $params)
            ? $params['update_back_step'] : false;

        return _grn_function_make_link_return($caption, $url, 'schedule/index',
            $update_back_step, $params);
    }

    $return_string
        = sprintf('<input class="%s" type="button" value="%s" onClick="%s"%s id="%s">',
        htmlspecialchars($class),
        htmlspecialchars($caption),
        $location,
        htmlspecialchars($disabled),
        htmlspecialchars($id));

    return $return_string;
}

/*
 *  Make link style button for cancel button
 *
 *  $caption
 *  $url            url when user click cancel
 *  $return_page    in case do not specify url, and page does not have history, it will return to the default page
 */
function _grn_function_make_link_return(
    $caption,
    $url,
    $return_page,
    $update_back_step = false,
    $params
) {
    $page = 'schedule/index';
    $backlink = cb_pageurl($page);

    $script_str = '';
    $return_code = "\n";

    $script_str .= "<script language=\"javascript\" type=\"text/javascript\"><!--"
                   . htmlspecialchars($return_code);
    $script_str
        .= <<<EOD
    var total_back_step=1;
    var check_cancel = false;
    function cancelSchedule(url)
    {
        if(check_cancel)
        {
            return;
        }
        check_cancel = true;
        if(url == 'back')
        {
            if(history.length > 1)
            {
                if( total_back_step > 1)
                {
                    history.go(-total_back_step);
                }
                else
                {
                    history.back();
                }
            }
            else
            {
                location.href = '$backlink';
            }
        }
        else
        {
            location.href = url;
        }
    }
EOD;

    if ($update_back_step) {
        $script_str .= "\n\n";
        $script_str
            .= <<<EOD
            function update_back_step()
            {
                total_back_step++;
            }
EOD;
    }
    $script_str .= "\n//-->\n</script>\n";
    $return_string
        = '<span class="aButtonStandard-grn"><a href="javascript:void(0);" onClick="cancelSchedule(\''
          . $url . '\');return false;"><span>'
          . htmlspecialchars($caption) . '</span></a></span>';

    // span cover button_base_grn
    $span_cover = '';
    $close_span_cover = '';
    if (array_key_exists('span_cover', $params)) {
        $return_string = '<span class="button_base_grn">' . $return_string
                         . '</span>';
    }

    return $script_str . $return_string;
}
