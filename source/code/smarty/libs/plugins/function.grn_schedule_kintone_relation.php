<?php
/**
 * Get the relation between schedule and kintone
 * Add, Modify, View
 */

use grn\kintone\bean\GrnKintoneAppRelationSetting;
use grn\kintone\AppRelationSettingLogic;
use grn\schedule\scheduleKintoneAppRelationLogic;

function smarty_function_grn_schedule_kintone_relation($params, &$smarty)
{
    $use_type = cb_at($params, 'use_type', 'view');
    $event_id = cb_at($params, 'event_id', '');
    $event_menu = cb_at($params, 'event_menu', '');

    $script
        = '<script type="text/javascript">jQuery(function(){
    var __kintoneRelation = grn.page.schedule.kintoneRelation;
    __kintoneRelation.setResource("spinnerImage", "'
          . $smarty->get_template_vars('app_path')
          . '/grn/image/cybozu/spinner.gif?'
          . $smarty->get_template_vars('build_date') . '");
    __kintoneRelation.setResource("accessError", "' . cb_msg('grn.schedule',
            'GRN_SCH-943') . '");';
    if ('modify' == $use_type || 'add' == $use_type) {
        $script
            .= '
    var itemInfo = {';
    }

    $setting_logic = new AppRelationSettingLogic();
    $all_settings = $setting_logic->getAllRelationSettings('schedule/add');
    $first = true;
    $items = [];
    foreach ($all_settings as $id => $setting) {
        $kintone_app = $setting[AppRelationSettingLogic::KINTONE_APP];
        if ('modify' == $use_type || 'add' == $use_type) {
            // define item information, JS
            $script .= ($first ? ' "item_' : ', "item_') .
                       $id . '" : { "itemName" : "'
                       . _grn_escape_js($setting[AppRelationSettingLogic::ITEM_NAME],
                    $smarty) . '", ' .
                       (cb_at($setting, AppRelationSettingLogic::ALL_MENU)
                           ? '"allMenu" : true, '
                           : '"menus" : '
                             . _grn_convert_array_to_js_string($setting[AppRelationSettingLogic::MENUS],
                               $smarty) . ', ') .
                       '"kintoneApp" : [';
            if (is_array($kintone_app)) {
                $first_tmp = true;
                foreach ($kintone_app as $app) {
                    $script .= ($first_tmp ? ' ' : ', ') . '{ "appID" : "'
                               . cb_at($app,
                            GrnKintoneAppRelationSetting::VALUE_KEY_APP_ID)
                               . '", "fieldCode" : '
                               . _grn_convert_array_to_js_string(cb_at($app,
                            GrnKintoneAppRelationSetting::VALUE_KEY_APP_FIELD_CODE),
                            $smarty) . ' }';
                    $first_tmp = false;
                }
            }
            $script .= ' ] } ';
            $first = false;
        }

        if (cb_at($setting, AppRelationSettingLogic::ALL_MENU)
            || ($event_menu
                && in_array($event_menu,
                    $setting[AppRelationSettingLogic::MENUS]))
        ) {
            $items[$id] = $kintone_app;
        }
    }

    if ('modify' == $use_type || 'add' == $use_type) {
        $script
            .= '};
    __kintoneRelation.setSystemInfo(itemInfo);
    __kintoneRelation.insertItems();';

        require_once('fw/error_message.csp');
        $msg = CB_ErrorMessage::getInstance('GRN_SCHD_13319', null);
        $error = $msg->formatDiagnosisMessage();
        $cause = $msg->formatCauseMessage();
        $countermeasure = $msg->formatCounterMeasureMessage();
        $script
            .= '
    var errorMsg = {"code": "GRN_SCHD_13319", "error": "' . $error
               . '", "cause": "' . $cause . '", "countermeasure": "'
               . $countermeasure . '"};
    var __kintoneError = __kintoneRelation.kintoneError;
    __kintoneError.setErrorMsg(errorMsg);
    __kintoneError.setResource("warnImage", "'
               . $smarty->get_template_vars('app_path')
               . '/grn/image/cybozu/warn100x60.gif?'
               . $smarty->get_template_vars('build_date') . '");
    __kintoneError.setResource("error", "' . cb_msg('fw.error', 'Error') . '");
    __kintoneError.setResource("cause", "' . cb_msg('fw.error', 'Cause') . '");
    __kintoneError.setResource("countermeasure", "' . cb_msg('fw.error',
                'Counter Measure') . '");';
    }

    $html = '';
    if ('modify' == $use_type || 'view' == $use_type) {
        $schedule_kintone_logic = new scheduleKintoneAppRelationLogic();
        $records
            = $schedule_kintone_logic->getRelatedAppRecords($event_id,
            $items);

        foreach ($items as $item_id => $app_setting) {
            if ('view' == $use_type) {
                $html .= '<tr><th nowrap>'
                         . htmlspecialchars($all_settings[$item_id][AppRelationSettingLogic::ITEM_NAME],
                        ENT_QUOTES) . '</th><td id="td_kintone_item_' . $item_id
                         . '"></td></tr>';
            }

            if (cb_at($records, $item_id)) {
                $app_id
                    = $records[$item_id][GrnKintoneAppRelationSetting::VALUE_KEY_APP_ID];
                $record_id = $records[$item_id]['record_id'];
                $fields = cb_at($records[$item_id],
                    GrnKintoneAppRelationSetting::VALUE_KEY_APP_FIELD_CODE);
                if ('modify' == $use_type) {
                    $script
                        .= '
    __kintoneRelation.getRecordForModify(\'' . $item_id . '\', \'' . $app_id
                           . '\', \'' . $record_id . '\', '
                           . _grn_convert_array_to_js_string($fields, $smarty)
                           . ');';
                } elseif ('view' == $use_type) {
                    $script
                        .= '
    __kintoneRelation.getRecordForView(\'' . $item_id . '\', \'' . $app_id
                           . '\', \'' . $record_id . '\', '
                           . _grn_convert_array_to_js_string($fields, $smarty)
                           . ');';
                }
            } else {
                if ('modify' == $use_type) {
                    $script
                        .= '
    __kintoneRelation.deleteRelation(\'item_' . $item_id . '\');';
                }
            }
        }
    }

    if ('add' == $use_type && cb_at($params, 'kintone_dialog_mode')
        && ! is_null(cb_at($params, 'selected_item'))
    ) {
        $script
            .= '
    __kintoneRelation.getRecordForModify(\'' . cb_at($params, 'selected_item')
               . '\', \'' . cb_at($params, 'kintone_app') . '\', \''
               . cb_at($params, 'kintone_record') . '\', '
               . _grn_convert_array_to_js_string(cb_at($params, 'field_code'),
                $smarty) . ');';
    }

    $script
        .= '
});</script>';

    return $script . $html;
}

function _grn_convert_array_to_js_string($array, $smarty)
{
    $js = '[';
    if (is_array($array)) {
        $first = true;
        foreach ($array as $v) {
            $js .= ($first ? '' : ', ') . '"' . _grn_escape_js($v, $smarty)
                   . '"';
            $first = false;
        }
    }
    $js .= ']';

    return $js;
}

function _grn_escape_js($js, $smarty)
{
    require_once($smarty->_get_plugin_filepath('modifier', 'escape'));

    return smarty_modifier_escape($js, 'javascript');
}
