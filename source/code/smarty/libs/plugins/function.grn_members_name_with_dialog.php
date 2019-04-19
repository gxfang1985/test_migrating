<?php
declare(strict_types=1);

require_once 'fw/ui.csp';
require_once 'grn/ui.csp';

/**
 * @param array   $params [members, app_id]
 * @param  Smarty $smarty
 *
 * @return string
 */
function smarty_function_grn_members_name_with_dialog(array $params, &$smarty)
{
    $result = new \grn\grn\dialog\MemberNameWithDialog($smarty);

    return $result->fetch($params);
}
