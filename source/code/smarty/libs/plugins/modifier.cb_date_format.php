<?php

/*
 * Smarty plugin
 * -------------------------------------------------------------
 * Type:     modifier
 * Name:     date_format
 * Purpose:  format datestamps via date()
 * Input:    string: input date string
 *           resource_key: Cybozu resource key
 *           default_date: default date if $string is empty
 * Description:
 *           As strftime() called by the original date_format
 *           has I18N problems (depends on OS encoding and locale),
 *           we use date() instead.
 * -------------------------------------------------------------
 */
require_once $smarty->_get_plugin_filepath('shared', 'make_timestamp');

require_once 'fw/date.csp';

function smarty_modifier_cb_date_format(
    $string,
    $resource_key,
    $default_date = null
) {
    if ($string != '') {
        return cb_date_format($resource_key, $string);
    } elseif (isset($default_date) && $default_date != '') {
        return cb_date_format($resource_key, $default_date);
    } else {
        return;
    }
}

/* vim: set expandtab: */


