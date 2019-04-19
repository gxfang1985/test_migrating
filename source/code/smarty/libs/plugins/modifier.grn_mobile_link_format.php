<?php

/**
 * Garoon Smarty mobile link format modifier plugin
 *
 * Type:     modifier<br>
 * Name:     grn_mobile_link_format<br>
 *
 * @param string
 *
 * @return string
 */
function smarty_modifier_grn_mobile_link_format($string)
{
    $string = preg_replace('/\<a /', '<a rel="external" ', $string);

    return $string;
}


