<?php

/**
 * @name   grn_cellular_address_group_form
 *
 * @author yuichi tanaka
 *
 * @param  string $field フィールドのデータ array( 'type'=> , 'name'=> , 'value' => )
 *
 */

function smarty_function_grn_cellular_display_field($params, &$smarty)
{
    require_once('grn/smarty.csp');
    if ( ! array_key_exists('item_code', $params)
         ||
         ! array_key_exists('item_data', $params)
    ) {
        return '';
    }
    $s = new GRN_Smarty();
    $s->assign('item_code', $params['item_code']);
    $s->assign('item_data', $params['item_data']);
    $function_name = 'grn_cellular_display_field';

    return $s->fetch('grn/display_field.tpl');
}

