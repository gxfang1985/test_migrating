<?php

/**
 * @param array      $params
 *                   'previous': the previous button information, page, and page_params
 *                   'next': the next button information, page, and page_params
 * @param GRN_Smarty $smarty
 *
 * @description
 *  show previous/next navigation UI
 *  if 'previous' or 'next' is not specified, you can get gray button
 *
 * Example)
 *      'navi' , array(
 *          'previous' => array(
 *              'page' => cb_get_pagename(),
 *              'page_params' => array( 'aid' => 1 )
 *              ),
 *          'next' => array(
 *              'page' => cb_get_pagename(),
 *              'page_params' => array( 'aid' => 3 )
 *              ),
 *          ),
 *
 *  * @return string
 */
function smarty_function_grn_previous_next_navi($params, &$smarty)
{
    // function name
    $function_name = 'grn_previous_next_navi';

    // get parameters
    $previous = cb_at($params, 'previous', false);
    if ($previous && ! is_array($previous)) {
        return htmlspecialchars($function_name) . ': $previous is not valid';
    }

    $next = cb_at($params, 'next', false);
    if ($next && ! is_array($next)) {
        return htmlspecialchars($function_name) . ': $next is not valid';
    }

    // Make "previous" part
    $return_string = '<span class="moveButtonBase-grn';
    if ($previous) {
        $previous_msg = cb_msg('grn.common', 'previous_next_navi_prev');
        $return_string .= '"><a href="' . cb_pageurl($previous['page'],
                $previous['page_params']) . '" aria-label="' . $previous_msg
                          . '" title="' . $previous_msg;
    } else {
        $return_string .= ' button_disable_filter_grn"><a href="#" aria-disabled="true';
    }
    $return_string .= '"><span class="moveButtonArrowLeft-grn"></span></a></span>';

    // Make "next" part
    $return_string .= '<span class="moveButtonBase-grn';
    if ($next) {
        $next_msg = cb_msg('grn.common', 'previous_next_navi_next');
        $return_string .= '"><a href="' . cb_pageurl($next['page'],
                $next['page_params']) . '" aria-label="' . $next_msg
                          . '" title="' . $next_msg;
    } else {
        $return_string .= ' button_disable_filter_grn"><a href="#" aria-disabled="true';
    }
    $return_string .= '"><span class="moveButtonArrowRight-grn"></span></a></span>';

    return $return_string;
}


