<?php

/**
 * @name   grn_mobile_report_include_item
 *  設定している項目のインクルード
 *
 * @date   2012/06/14
 * @option array  item                     //報告項目（データ）
 *
 *  記述例
 *  <pre>{grn_mobile_report_include_item item=$item}</pre>
 */

function smarty_function_grn_mobile_report_include_item($params, &$smarty)
{
    $function_name = "grn_mobile_report_include_item";

    if ($params['item'] === '' || is_null($params['item'])) {
        return htmlspecialchars($function_name) . ": missing item parameter";
    }

    $item_for_view = $params['item'];

    switch ($item_for_view['data_type']) {
        case 'grn.report.numeric':
            if (array_key_exists('number', $item_for_view)) {
                if ('' !== trim($item_for_view['number'])) {
                    //Preparation for format parameter.
                    $thousandsSep = $item_for_view['settings']['split_rank']
                        ? ',' : '';
                    $decimals
                        = (int)$item_for_view['settings']["effective_figures"];
                    $decPoint = '.';
                    $minusChar = cb_msg(GRN_REPORT_MODULE_ID,
                        'minus_type_'
                        . $item_for_view['settings']['minus_type']);
                    $isDecimalZeroPadding = true;
                    require_once('fw/string_util.csp');
                    $item_for_view['number']
                        = cb_number_format($item_for_view['number'], $decimals,
                        $decPoint, $thousandsSep, $minusChar,
                        $isDecimalZeroPadding);
                }
            }
            break;
        case 'grn.report.date':
            if (is_null($item_for_view['number'])) {
                $item_for_view['text']['year'] = null;
                $item_for_view['text']['month'] = null;
                $item_for_view['text']['day'] = null;
            } else {
                $ts = new CB_TimeStamp();
                $ts->unix_ts = $item_for_view['number'];
                $tsex = new CB_TimeStampEx($ts);
                $date =& $tsex->getDate();
                unset($tsex);
                $item_for_view['text']['year'] = $date->year;
                $item_for_view['text']['month'] = $date->month;
                $item_for_view['text']['day'] = $date->day;
            }
            break;
        case 'grn.report.time':
            if (is_null($item_for_view['number'])) {
                $time = new CB_Time();
                $time->hour = null;
                $time->minute = null;
                $item_for_view['time'] = $time;
            } else {
                require_once('report/item_resources.csp');
                $item_util
                    = grn_report_get_item_util($item_for_view['data_type']);
                $item
                    = ['col_number' => $item_for_view['number']];
                $time = $item_util->getItemData($item);
                $item_for_view['time'] = $time;
                unset($item, $time);
            }
            break;
        case 'grn.report.file':
            $smarty->assign('attached_file_list', $item_for_view['files']);
            $smarty->assign('attached_file_count',
                count($item_for_view['files']));
            break;
    }

    $smarty->assign('item', $item_for_view);
    $smarty->display('report/mobile/_view_item.tpl');
}

