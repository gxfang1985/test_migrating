<?php

use grn\grn\MemberLogic;

/**
 * @param            $params
 * @param GRN_Smarty $smarty
 *
 * @options    string    layout_template Path to the rendering template
 * @options    array     path_step_list  Approval step information
 * @options    int       path_step_count The number of approval step
 * @options    boolean   preview         Whether in preview mode or not
 * @options    array     params          Extend parameters
 *
 * @return mixed|string|void
 */
function smarty_function_grn_workflow_member_add($params, &$smarty)
{
    $t = new GRN_Smarty();
    $params['is_extended_plugin'] = true;

    require_once($smarty->_get_plugin_filepath('function', 'grn_member_add'));
    if ( ! array_key_exists('layout_template', $params)) {
        $params['layout_template'] = 'workflow/member_add.tpl';
    }
    $sUID = cb_at($params, 'sUID', 'sUID');

    $path_step_list = [];
    $member_list_names = [];
    if (array_key_exists('path_step_list', $params)) {
        $path_step_list = $params['path_step_list'];
        foreach ($path_step_list as $step_id => $path_step) {
            $path_step_users = cb_at($path_step, 'users', []);
            $user_ids = [];
            foreach ($path_step_users as $step_user) {
                $user_id = (int)$step_user['_id'];
                if ($user_id === MemberLogic::OMITTED_USER_ID) {
                    $user_ids = [MemberLogic::OMITTED_USER_ID];
                    break;
                }
                $user_ids[] = $user_id;
            }
            $path_step_list[$step_id]['users'] = MemberLogic::getInstance()
                                                            ->getDisplayUsersByUserIds($user_ids,
                                                                GRN_WORKFLOW_APPLICATION_ID);
            $member_list_names[]
                = "all_path_step_{$step_id}_{$sUID}";
        }
        unset($params['path_step_list']);
    }

    $path_step_count = $params['path_step_count'] ?? 0;
    unset($params['path_step_list']);

    $is_preview = $params['is_preview'] ?? false;
    unset($params['is_preview']);

    if ( ! array_key_exists('app_id', $params)) {
        $params['app_id'] = GRN_WORKFLOW_APPLICATION_ID;
    }

    $t->assign('popup_target_list', cb_at($params, 'CID', 'CID'));
    $t->assign("member_list_names", $member_list_names);
    $t->assign('path_step_list', $path_step_list);
    $t->assign('path_step_count', $path_step_count);
    $t->assign('is_preview', $is_preview);

    return smarty_function_grn_member_add($params, $t);
}

