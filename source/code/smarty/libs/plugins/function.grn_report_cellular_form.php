<?php

/**
 * @name   grn_cellular_form
 * formタグ(開始)とhiddenを出力
 *
 * @param string method   form method
 * @param string page     the page name
 *
 * @option mixed   (var)  hidden parameters
 * @option array params   hidden parameters
 * @option string name    form name
 * @option string postfix contents after /-/
 *
 *  記述例
 *  <pre>{grn_cellular_form method="post" page="cellular/index"}
 */
function smarty_function_grn_report_cellular_form($params, &$smarty)
{
    $function_name = "grn_report_cellular_form";

    // necessary parameter and value
    if ( ! array_key_exists('method', $params)) {
        return htmlspecialchars($function_name) . ": missing key parameter";
    }

    $org_page = $params['page'];
    $form_method = $params['method'];
    unset($params['method']);

    $form_name = null;
    if (array_key_exists('name', $params)) {
        $form_name = $params['name'];
        unset($params['name']);
    }

    require_once('grn/ui.csp');
    $params = grn_ui_url_params($params, $function_name, $smarty);

    $page = $params['page'];
    $fragment = $params['fragment'];
    $postfix = $params['postfix'];
    $params = (array)@$params['url_params'];

    require_once('report/cellular.csp');
    $page = __grn_report_cellular_prepare_page($page, $params);

    $url = cb_pageurl($page, [], $fragment, $postfix);

    if (preg_match('/\?$/', $url)) {
        $url = substr($url, 0, strlen($url) - 1);
    }

    $url = grn_report_cellular_remote_path($url);

    $str = "<form method=\"" . htmlspecialchars($form_method) . "\"";

    $str .= strlen($form_name) ? " name=\"" . htmlspecialchars($form_name)
                                 . "\"" : "";

    $str .= " action=\"$url\">";

    if (is_array($params) && count($params)) {
        foreach ($params as $hidden_name => $hidden_value) {
            $str .= "<input type=\"hidden\" name=\""
                    . htmlspecialchars($hidden_name) . "\" value=\""
                    . htmlspecialchars($hidden_value) . "\">";
        }
    }

    // セッションIDがクッキーで送信されていない場合
    if (strlen(($sid = strip_tags(SID))) > 0) {
        $pair = explode('=', $sid);
        $str .= "<input type=\"hidden\" name=\"" . htmlspecialchars($pair[0])
                . "\" value=\"" . htmlspecialchars($pair[1]) . "\">";
    }

    // add CSRF Ticket
    if ($form_method === 'post') {
        $parts = explode('/', $org_page);
        $page_name = array_pop($parts);
        if (preg_match('/^command_/', $page_name)) {
            require_once('fw/csrf.csp');
            $str .= "<input type=\"hidden\" name=\"csrf_ticket\" value=\""
                    . htmlspecialchars(cb_csrf_get_token()) . "\">";
        }
    }

    return $str;
}

