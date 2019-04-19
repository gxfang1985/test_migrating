<?php

use grn\fts\Application;

/**
 * @param array  $params
 * @param Smarty $smarty
 *
 * @return string
 */
function smarty_function_grn_load_search_css($params, $smarty)
{
    if (Application::isAvailable()) {
        static $SEARCH_PATHS = [
            'bulletin/search',
            'message/search',
            'cabinet/search',
            'mail/search',
            'space/search',
            'fts/search',
        ];
        $page = cb_get_pagename();
        if (in_array($page, $SEARCH_PATHS)) {
            require_once $smarty->_get_plugin_filepath('function',
                'grn_load_css');

            return smarty_function_grn_load_css(['file' => 'grn/html/search.css'],
                $smarty);
        }
    }

    return '';
}
