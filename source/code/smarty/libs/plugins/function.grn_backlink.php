<?php
/**
 * @name   grn_backlink
 * @description show site position
 *
 */

function smarty_function_grn_backlink($parameters, $smarty)
{
    $positions = (array)@ $parameters['positions'];
    $result = array_reverse($positions);
    $ct = 0;
    foreach ($result as $site_info) {
        $name = $site_info['name'];
        unset($site_info['name']);

        $page = isset($site_info['page']) ? $site_info['page'] : null;
        unset($site_info['page']);

        $fragment = isset($site_info['fragment']) ? $site_info['fragment']
            : null;
        unset($site_info['fragment']);

        unset($site_info['icon']);
        unset($site_info['isHidden']);

        if ($ct == 1) {
            $msg = cb_msg('fw.ui', 'backlink', ['app_name' => $name]);

            return '<a class="footer_back_grn" href="' . cb_pageurl($page,
                    $site_info, $fragment) . '">' . $msg . '</a>';
            break;
        }
        $ct++;

    }
}

