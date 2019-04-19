<?php

/**
 * @name   grn_workflow_pathstep_progress
 * @description 進行状況
 *
 * @date
 * @author
 *
 * @param
 *
 * @option
 */
function smarty_function_grn_workflow_pathstep_progress($params, &$smarty)
{
    $t = new GRN_Smarty();

    $uid = null;
    if (array_key_exists('uid', $params) && strlen($params['uid']) > 0) {
        $uid = $params['uid'];
    }
    $pathsteps = [];
    if (array_key_exists('path_steps', $params)
        && count($params['path_steps']) > 0
    ) {
        $pathsteps = $params['path_steps'];
    }
    $app_path = '';
    if (array_key_exists('app_path', $params)
        && strlen($params['app_path']) > 0
    ) {
        $app_path = $params['app_path'];
    }
    $pid = '';
    if (array_key_exists('pid', $params) && strlen($params['pid']) > 0) {
        $pid = $params['pid'];
    }
    $status = '';
    if (array_key_exists('status', $params) && strlen($params['status']) > 0) {
        $status = $params['status'];
    }
    $puid = '';
    if (array_key_exists('puid', $params) && strlen($params['puid']) > 0) {
        $puid = $params['puid'];
    }

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $user =& $uum->getUser($uid);
    if ($user == false) {
        return '';
    }
    unset($user);

    $result = [];
    $processing = false;

    if ($status == GRN_WORKFLOW_STATUS_REMAND) {
        // 差し戻し

        //申請者の未処理一覧のフォルダを取得
        $translation_map_folder = [
            'id'   => '_id',
            'name' => 'name',
            'type' => 'folder_type',
        ];
        require_once('workflow/controller_util.csp');
        $u = GRN_Workflow_Folder_Controller_Utility::getInstance();
        if ( ! is_null($puid) && strlen($puid) > 0) {
            $folder_list = $u->getListView($translation_map_folder, $puid);
            unset($u);
            $folder_id = null;
            foreach ($folder_list as $id => $folder) {
                if ($folder['type']
                    == GRN_WORKFLOW_FOLDER_TYPE_UNPROCESSED_ID
                ) {
                    $folder_id = $id;
                    break;
                }
            }
            if ( ! is_null($folder_id)) {
                require_once('workflow/folderrelation_logic.csp');
                $logic = GRN_Workflow_FolderRelation_Logic::getInstance();
                $list = $logic->getListByPetitionID($pid);
                unset($logic);

                foreach ($list as $relation) {
                    if ($relation['col_folder'] == $folder_id) {
                        // 差し戻しで申請者の未処理一覧フォルダにある
                        $processing = true;
                        break;
                    }
                }
            }
        }
    }

    foreach ($pathsteps as $path_step) {
        $src = '';
        if ($path_step['col_type'] == GRN_WORKFLOW_CIRCULAR) {
            //回覧経路
            continue;
        }
        if ( ! $path_step['col_activate'] || $path_step['col_skip']) {
            //無効またはスキップの経路
            continue;
        }
        if ($path_step['col_finished'] != GRN_WORKFLOW_FINISHED_COMPLETE
            && $processing == false
        ) {
            $src = 'approval_plan_dispose13.gif';
            $processing = true;
        } elseif (array_search($uid, $path_step['uids']) !== false) {
            $src = 'approval_plan_user13.gif';
        } else {
            $src = 'approval_plan_step13.gif';
        }
        $img = '<img src="' . htmlspecialchars($app_path)
               . '/grn/image/cybozu/' . htmlspecialchars($src)
               . '" align="absmiddle">';
        $result[] = $img;
        $img = '<img src="' . htmlspecialchars($app_path)
               . '/grn/image/cybozu/approval_plan_arrow13.gif'
               . '" align="absmiddle">';
        $result[] = $img;
    }
    array_pop($result);

    $result = implode('&nbsp;', $result);

    return $result;

}

