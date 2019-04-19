<?php

/**
 * @name   grn_cellular_address_group_form
 *
 * @author yuichi tanaka
 *
 * @param  string $method フォームのメソッド
 * @param  string $page   フォームの遷移先
 *
 * @option int    $gid        選択されているgroupのid
 * @option array  $params     その他のパラメータ
 */

function smarty_function_grn_cellular_address_group_form($params, &$smarty)
{
    assert('array_key_exists(\'method\', $params)');
    assert('array_key_exists(\'page\', $params)');

    $function_name = 'grn_cellular_address_group_form';

    $selected = array_key_exists('gid', $params) ? $params['gid'] : null;

    $form_params = [];
    $form_params['method'] = $params['method'];
    $form_params['page'] = $params['page'];
    $form_params['params'] = array_key_exists('params', $params)
        ? $params['params'] : [];
    require_once($smarty->_get_plugin_filepath('function',
        'grn_cellular_form'));
    $result = smarty_function_grn_cellular_form($form_params, $smarty);

    $result .= '<select name="group_id">';

    if ($params['my_address_groups']) {
        foreach ($params['my_address_groups'] as $group) {
            $result .= "<option value=\"" . htmlspecialchars($group['id'])
                       . "\"";
            $result .= $group['id'] == $selected ? ' selected' : '';
            $result .= '>' . htmlspecialchars($group['name']) . '</option>';
        }
    }

    $result .= '</select><br>';

    $submit_params['name'] = 'Go';
    $submit_params['accesskey'] = $params['accesskey'];
    $submit_params['caption'] = cb_msg('grn.cellular.common', 'submit_move');

    require_once($smarty->_get_plugin_filepath('function',
        'grn_cellular_submit'));
    $result .= smarty_function_grn_cellular_submit($submit_params, $smarty);
    $result .= '</form>';

    return $result;
}

