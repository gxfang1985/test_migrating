<?php

/**
 * @name grn_hierarchy_select
 * @description 階層構造を選択するselectボックス
 *
 * @date        2005/02/02
 *
 * @param  string  padding    パディング
 * @param  string  mark       階層構造のマーク
 *
 * @option      array   hierarchy  階層構造データ
 *  残りのパラメータはすべてgrn_selectと同一
 *
 * Examples;
 * {php}
 *  $child = array( 'value' => '1', 'label' => 'x' );
 *  $hierarchy = array( array( 'value' => '1', 'label' => 'x', 'selected' = TRUE,
 *                             'child' => $child ) );
 *  $this->assign( hierarchy, $hierarchy );
 * {/php}
 * {grn_select_hierarchy name='group_id' padding='　' mark='┗' hierarchy=$hierarchy}
 */
function smarty_function_grn_select_hierarchy($params, &$smarty)
{
    $function_name = 'grn_select_hierarchy';

    $padding = '&nbsp;';
    if (array_key_exists('padding', $params)) {
        $padding = $params['padding'];
    }

    if (array_key_exists('hierarchy', $params)
        && is_array($params['hierarchy'])
    ) {
        $hierarchy = $params['hierarchy'];
    } else {
        return htmlspecialchars($function_name) . ': hierarchy is required';
    }

    $mark = '';
    if (array_key_exists('mark', $params)) {
        $mark = $params['mark'];
    }

    unset($params['mark']);
    unset($params['hierarchy']);
    unset($params['padding']);

    $options = [];
    _option_expand($mark, $padding, $hierarchy, 0, $options);

    $params['options'] = $options;

    require_once($smarty->_get_plugin_filepath('function', 'grn_select'));

    return smarty_function_grn_select($params, $smarty);
}

/**
 * @access private
 */
function _option_expand($mark, $padding, $data, $hierarchy, &$result)
{
    $prepend = '';
    $blanks = str_repeat($padding,
        mb_strlen(_unhtmlentities($padding)) * $hierarchy);
    if ($hierarchy > 0) {
        $prepend = $blanks . $mark;
    }

    foreach ($data as $item) {
        $selected = false;
        $label = $prepend . $item['label'];

        if (array_key_exists('selected', $item) && $item['selected']) {
            $selected = true;
        }

        $result[] = [
            'value'    => $item['value'],
            'label'    => $label,
            'selected' => $selected
        ];
        if (array_key_exists('child', $item)) {
            $h = $hierarchy + 1;
            _option_expand($mark, $padding, $item['child'], $h, $result);
        }
    }
}

/**
 * @access private
 */
function _unhtmlentities($string)
{
    $trans_tbl = get_html_translation_table(HTML_ENTITIES);
    $trans_tbl = array_flip($trans_tbl);

    return strtr($string, $trans_tbl);
}


