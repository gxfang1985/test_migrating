<?php

use grn\space\common\utility\ValidateUtility;

require_once 'fw/ui.csp';
require_once 'grn/ui.csp';

/**
 * @param array $params
 * @param       $smarty
 *
 * @return string
 */
function smarty_function_grn_space_todo_member_names(array $params, &$smarty)
{
    $spaceService = \grn\space\service\SpaceService::getInstance();

    $params['app_id'] = 'space';
    $space_member_collection = cb_at($params, 'spaceMemberCollection',
        new \grn\space\common\data\collection\SpaceMemberCollection());
    $params['user_profile_url_array']
        = $spaceService->getUserProfileUrlArray($space_member_collection);
    $params['is_display_deleted_user'] = true;

    $members_array = [];
    $deleted_user_index = 1;
    /** @var \grn\space\common\data\bean\SpaceMember $space_member */
    foreach ($space_member_collection as $space_member) {
        $member_id = $space_member->getMemberID();
        if (ValidateUtility::isNull($member_id) || $space_member->isDeleted()) {
            $member_id
                = \grn\grn\dialog\MemberNameWithDialog::PREFIX_DELETED_USER
                  . $deleted_user_index;
            $deleted_user_index++;
        }
        $members_array[$member_id] = $space_member->getDisplayMemberArray();
    }
    $params['members'] = $members_array;

    require_once $smarty->_get_plugin_filepath('function',
        'grn_members_name_with_dialog');

    return smarty_function_grn_members_name_with_dialog($params, $smarty);
}
