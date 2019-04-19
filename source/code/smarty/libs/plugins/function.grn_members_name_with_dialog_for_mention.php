<?php
declare(strict_types=1);

use grn\space\screen\GenericScreenBase;

function smarty_function_grn_members_name_with_dialog_for_mention(
    array $params,
    &$smarty
) {
    $accessibility_text = cb_msg('grn.grn',
        'mention_list_aria_label');
    $params['members'] = $params['members'] ?? [];
    $params['user_profile_url_array']
        = \GRN_ControllerUtil::createMultiUserProfileUrl($params['members']);
    $params['ul_attribute'] = $params['ul_attribute'] ?? '';
    $params['list_wrap_begin'] = $params['list_wrap_begin'] ??
                                 '<ul ' . $params['ul_attribute']
                                 . ' aria-label="' . $accessibility_text
                                 . '">';
    $params['list_wrap_end'] = $params['list_wrap_end'] ?? '</ul>';
    $params['is_display_deleted_user'] = $params['is_display_deleted_user'] ??
                                         true;
    $params['append_script_file'] = $params['append_script_file'] ?? false;
    $params['dialog_name'] = $params['dialog_name'] ??
                             'span-member-dialog-mention';
    $params['is_expand_with_ajax'] = $params['is_expand_with_ajax'] ?? true;
    $params['limit_display_count'] = $params['limit_display_count'] ??
                                     GenericScreenBase::MAX_NUM_DISPLAY_MEMBER;
    $params['has_space_between_item'] = false;
    if (isset($params['is_mobile'])) {
        $result
            = new \grn\grn\mention\MobileMentionMemberNameWithDialog($smarty);
    } else {
        $result = new \grn\grn\mention\MentionMemberNameWithDialog($smarty);
    }

    return $result->fetch($params);
}
