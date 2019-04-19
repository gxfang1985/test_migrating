<?php
declare(strict_types=1);

use grn\space\common\data\collection\SpaceMemberCollection;

/**
 * @param array $params \grn\space\common\data\collection\SpaceMemberCollection SpaceMemberCollection
 * @param       $smarty
 *
 * @return string
 */
function smarty_function_grn_space_members_name_with_dialog(
    array $params,
    &$smarty
) {
    $params['app_id'] = 'space';
    $spaceMemberCollection = $params['spaceMemberCollection'] ??
                             new SpaceMemberCollection();
    $params['members']
        = $spaceMemberCollection->toArrayMembers();
    $spaceService
        = \grn\space\service\SpaceService::getInstance();
    $params['user_profile_url_array']
        = $spaceService->getUserProfileUrlArray($spaceMemberCollection);
    require_once $smarty->_get_plugin_filepath('function',
        'grn_members_name_with_dialog');

    return smarty_function_grn_members_name_with_dialog($params, $smarty);
}
