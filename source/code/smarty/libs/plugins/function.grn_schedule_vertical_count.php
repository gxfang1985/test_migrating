<?php
require_once 'fw/date.csp';

/**
 * @name   grn_schedule_rows_count
 *  サブタイトル
 *
 * @date   2005/7/20
 * @author Okahashi
 *
 */

function smarty_function_grn_schedule_vertical_count($params, &$smarty)
{
    $font_size = 12;
    if (array_key_exists('size', $params)) {
        $font_size = $params['size'];
    }

    $rows = 0;
    if (array_key_exists('rows', $params)) {
        $rows = $params['rows'];
    }

    $string = '';
    for ($i = 0; $i < $rows; $i++) {
        if ($i == 0) {
            $string .= "<tr><td>&nbsp;</td></tr>";
        } else {
            $string .= "<tr><td style=\"border-bottom:1px solid #ffffff\">&nbsp;</td></tr>";
        }
    }
//    if($rows > 1){
//        $string .= "<tr><td style=\"font-size:3pt;\">";
//        for( $i=0; $i < round($rows/3); $i++ )
//        {
//            $string .= "&nbsp;<br>";
//        }
//        $string .= "</td></tr>";
//    }

    $minutes = 0;
    if (array_key_exists('m_type', $params)) {
        $minutes = $params['m_type'];
    }
    $minutes_num = 0;
    if (array_key_exists('m_num', $params)) {
        $minutes_num = $params['m_num'];
        if ( ! $minutes_num) {
            $minutes_num = 1;
        }
    }
    $minutes_size = $minutes_num * $font_size / 12;
    if ($minutes != 0) {
        $string .= "<tr><td style=\"font-size:14pt;border-bottom:1px solid #ffffff\">";
        $string .= "<div style=\"font-size:" . htmlspecialchars($minutes_size)
                   . "pt;height:" . (htmlspecialchars($minutes) / 5)
                   . "em\">&nbsp;<br></div>";
        $string .= "</td></tr>";
    }

    return $string;
}

