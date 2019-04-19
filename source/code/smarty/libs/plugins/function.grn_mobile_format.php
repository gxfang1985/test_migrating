<?php
function smarty_function_grn_mobile_format($params, &$smarty)
{
    if ( ! array_key_exists('body', $params)) {
        return 'grn_mobile_format: no body';
    }

    require_once('grn/ui.csp');

    $body = $params['body'];

    if ( ! array_key_exists('nolink', $params) || ! $params['nolink']) {
        $body = grn_autolink($body, true);
    } else {
        $body = htmlspecialchars($body);
    }
    $body = str_replace("\t", '    ', $body);
    $body = str_replace("\r\n", '<br>', $body);
    $body = str_replace("\r", '<br>', $body);
    $body = str_replace("\n", '<br>', $body);
    $body = _grn_mobile_replace_first_white_space($body);

    return '<pre style="white-space:-moz-pre-wrap; white-space:pre-wrap;display:inline;">'
           . $body . '</pre>';
}

function _grn_mobile_replace_first_white_space($body)
{
    //get lines
    $lines = explode('<br>', $body);
    $result = [];
    foreach ($lines as $key => $line) {
        //get total_first_whitespace
        $ltrim_line = ltrim($line);
        $total_first_whitespace = strlen($line) - strlen($ltrim_line);
        //create &nbsp;&nbsp;&nbsp;&nbsp;
        $ltrim_line = str_replace('  ', ' &nbsp;', $ltrim_line);
        $result[] = str_repeat("&nbsp;", $total_first_whitespace)
                    . $ltrim_line;
    }

    return implode('<br>', $result);
}

