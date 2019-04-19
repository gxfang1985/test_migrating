<?php

require_once('grn/ui.csp');

/**
 * @name   grn_format
 *          本文等の整形.
 *          改行変換、自動リンクを行う
 *          自動リンク処理により、同時にHTMLエスケープも行われる
 *          {$hoge|nl2br|grn_autolink} と同じ
 *
 * @date   2004/11/23
 * @author Yamamoto, Hirotaka
 *
 * @param  string  body        文字列
 */


function __grn_format_replace_white_space($content, $browser = null)
{
    $len = strlen($content);
    $result = '';
    $tag_body = '';
    $in_tag = false;
    if ($browser && $browser == 'ie') {
        $trans_tbl = [

            "\t" => "&nbsp;&nbsp; &nbsp;",
            "\n" => "<br>",
        ];
    } else {
        $trans_tbl = [
            " "  => "&nbsp;",
            "\t" => "&nbsp;&nbsp;&nbsp;&nbsp;",
            "\n" => "<br />",
        ];
    }
    for ($i = 0; $i < $len; $i++) {
        $c = $content{$i};
        switch ($c) {
            case '<':
                if ($in_tag) {
                    // ignore nested <
                } else {
                    $in_tag = true;
                    $result .= strtr($c, $trans_tbl);
                }
                break;

            case '>':
                if ($in_tag) {
                    $in_tag = false;

                    $t = $tag_body;
                    $t .= $c;

                    $result .= $t;
                    $tag_body = '';
                } else {
                    // escape dangling >
                    $result .= '&gt;';
                }
                break;

            default:
                if ($in_tag) {
                    $tag_body .= $c;
                } else {
                    $j = $i + 1;
                    if ($c == " " && $i < $len - 1 && $content{$j} == " ") {
                        $result .= " &nbsp;";
                        $i++;
                    } else {
                        $result .= strtr($c, $trans_tbl);
                    }
                }
        }
    }

    return $result;
}

function smarty_function_grn_format($params, &$smarty)
{
    if ( ! array_key_exists('body', $params)) {
        return 'grn_format: no body';
    }

    require_once('grn/ui.csp');

    $body = $params['body'];

    if ( ! array_key_exists('nolink', $params) || ! $params['nolink']) {
        // grn_autolinkの内部ではhtmlspecialcharsでエスケープが行われる。
        if (array_key_exists('message_follow_link', $params)) {
            $body = _grn_follow_autolink($body, false,
                $params['message_follow_link'], 'message', $params['cid'],
                $params['rid']);
        } elseif (array_key_exists('bulletin_follow_autolink', $params)) {
            $body = _grn_follow_autolink($body, false,
                $params['bulletin_follow_autolink'], 'bulletin',
                $params['cid']);
        } elseif (array_key_exists('report_follow_autolink', $params)) {
            $body = _grn_follow_autolink($body, false,
                $params['report_follow_autolink'], 'report', $params['cid'],
                $params['rid']);
        } elseif (array_key_exists('thread_follow_autolink', $params)) {
            $body = _grn_follow_autolink($body, false,
                $params['thread_follow_autolink'], 'space_thread',
                $params['spid']);
        } elseif (array_key_exists('todo_follow_autolink', $params)) {
            $body = _grn_follow_autolink($body, false,
                $params['todo_follow_autolink'], 'space_todo', $params['spid'],
                $params['from']);
        } else {
            $body = grn_autolink($body);
        }
    } else {
        $body = htmlspecialchars($body);
    }

    $ua = grn_ui_get_user_agent();

    $tag_name = "div";
    if (array_key_exists('span_mode', $params) && $params['span_mode']) {
        $tag_name = "span";
    }

    if (array_key_exists('app', $ua)) {
        switch ($ua['app']) {
            case 'ie':
                // IE の後方互換モードでは white-space:pre; は無効なため、空白を &nbsp; に置換することで整形する。
                // &nbsp; にすると改行されないので、word-break:break-all; で強制的に自動改行する。
                $body = str_replace("\r\n", '<br>', $body);
                $body = str_replace("\r", '<br>', $body);
                $body = str_replace("\n", '<br>', $body);
                $body = _grn_replace_first_white_space_forIE($body);
                $body = __grn_format_replace_white_space($body, $ua['app']);
                if (array_key_exists('flag_notification_header', $params)) {
                    return '<pre class="format_contents" style="width=99%;word-wrap:break-word; white-space:pre-wrap;display:inline;">'
                           . $body . '</pre>';
                }

                return '<' . $tag_name
                       . ' class="format_contents" style="word-wrap:break-word;">'
                       . $body . '</' . $tag_name . '>';
            case 'netscape':
            case 'safari':
            case 'firefox':
                // Firefox は CSS で、整形＆改行することができる
                // - FF2: white-space:-moz-pre-wrap;
                // - FF3: white-space:pre-wrap;
                //replace special character
                $body = str_replace("\t", '    ', $body);
                $body = str_replace("\r\n", '<br />', $body);
                $body = str_replace("\r", '<br />', $body);
                $body = str_replace("\n", '<br />', $body);
                $body = _grn_replace_first_white_space($body);

                return '<pre class="format_contents" style="white-space:-moz-pre-wrap; white-space:pre-wrap;display:inline;">'
                       . $body . '</pre>';
            default:
                break;
        }
    }

    // IE,Mozilla以外ではCSSで表示を制御できそうにないので文字を変換して対応
    $body = __grn_format_replace_white_space($body);

    return '<' . $tag_name . ' class="format_contents">' . $body . '</'
           . $tag_name . '>';
}

/**
 * @name   _grn_replace_first_white_space
 * @date   2009/2/11
 * @author Nguyen Anh Tuyen
 *
 * @param  string $body : input body
 *                      use to replace special character.
 */
function _grn_replace_first_white_space($body)
{
    //get lines
    $lines = explode('<br />', $body);
    $result = [];
    foreach ($lines as $key => $line) {
        //get total_first_whitespace
        $ltrim_line = ltrim($line);
        $total_first_whitespace = strlen($line) - strlen($ltrim_line);
        //create &nbsp;&nbsp;&nbsp;&nbsp;.........
        $ltrim_line = str_replace('  ', ' &nbsp;', $ltrim_line);
        $result[] = str_repeat("&nbsp;", $total_first_whitespace)
                    . $ltrim_line;

    }

    return implode('<br>', $result);
}

function _grn_replace_first_white_space_forIE($body)
{

    //get lines
    $lines = explode('<br>', $body);
    $result = [];
    foreach ($lines as $key => $line) {
        //get total_first_whitespace
        if (@$line[0] == " ") {
            $line = "&nbsp;" . substr($line, 1);
        }


        $result[] = $line;
    }

    return implode('<br>', $result);
}

