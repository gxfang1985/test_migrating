{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{assign var='form_name' value=$smarty.template|basename}

{if 0 >= $change_path_history_total}
    {assign var=no_change_path_history value=true}
{/if}

{* メニュー、通知メッセージ *}
<div id="main_menu_part">
    {if $folder}
        {* 受信 *}
        {if GRN_WORKFLOW_FOLDER_TYPE_IN_ID == $folder.col_folder_type}
            <span class="menu_item">
                {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple element_id="workflow/print" alt=''}
            </span>
            <span class="menu_item">
                {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
                {capture name='grn_workflow_delete_from_received_list'}{cb_msg module='grn.workflow' key='delete_from_received_list' replace='true'}{/capture}{grn_link id="lnk_delete" caption=$smarty.capture.grn_workflow_delete_from_received_list script='javascript:vodi(0);' image='delete20.gif' fid=$fid pid=$pid simple=$simple alt=''}
            </span>
        {* 送信 *}
        {elseif GRN_WORKFLOW_FOLDER_TYPE_OUT_ID == $folder.col_folder_type}
            <span class="menu_item">
            {if !$form || !$is_access}{assign var='disable_reuse' value=true}{/if}
                {if $petition.agent_user && $login.id == $petition.agent_user}
                    {capture name='grn_workflow_reuse_and_apply'}{cb_msg module='grn.workflow' key='reuse_and_apply' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_reuse_and_apply page='workflow/send_form_reuse_proxy' image='reuse20.gif' fid=$fid pid=$pid simple=$simple mode='reuse' disabled=$disable_reuse element_id="workflow/send_form_reuse_proxy" alt=''}
            {else}
                {capture name='grn_workflow_reuse_and_apply'}{cb_msg module='grn.workflow' key='reuse_and_apply' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_reuse_and_apply page='workflow/send_form_reuse' image='reuse20.gif' fid=$fid pid=$pid simple=$simple mode='reuse' disabled=$disable_reuse element_id="workflow/send_form_reuse" alt=''}
            {/if}
            </span>
            <span class="menu_item">
                {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple element_id="workflow/print" alt=''}
            </span>
            {if ! ((GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status && $cancel_confirm) || GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status || GRN_WORKFLOW_STATUS_FINISHED == $petition.status || GRN_WORKFLOW_STATUS_REJECTION == $petition.status)}
                {assign var=disabled_delete value=true}
            {/if}
            <span class="menu_item">
                {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
                {capture name='grn_workflow_delete_from_sent_list'}{cb_msg module='grn.workflow' key='delete_from_sent_list' replace='true'}{/capture}{grn_link id="lnk_delete" caption=$smarty.capture.grn_workflow_delete_from_sent_list script="javascript:void(0);" image='delete20.gif' fid=$fid pid=$pid simple=$simple disabled=$disabled_delete alt=''}
            </span>
            <div id="rare_menu_part_under">
                {* 未処理 *}
                {if GRN_WORKFLOW_STATUS_UNPROCESSING == $petition.status}
                    <span class="menu_item">
                        {capture name='grn_workflow_take_back_application'}{cb_msg module='grn.workflow' key='take_back_application' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_take_back_application page='workflow/cancel' image='cancel20.gif' fid=$fid pid=$pid simple=$simple element_id="workflow/cancel" alt=''}
                    </span>
                {* 進行中 *}
                {elseif GRN_WORKFLOW_STATUS_IN_PROCESS == $petition.status || GRN_WORKFLOW_STATUS_REMAND == $petition.status}
                    <span class="menu_item">
                        {capture name='grn_workflow_cancel_application'}{cb_msg module='grn.workflow' key='cancel_application' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_cancel_application page='workflow/cancel' image='cancel20.gif' fid=$fid pid=$pid simple=$simple element_id="workflow/cancel" alt=''}
                    </span>
                {/if}
            </div>
        {* 結果 *}
        {elseif GRN_WORKFLOW_FOLDER_TYPE_FINISH_ID == $folder.col_folder_type}
            <span class="menu_item">
            {if !$form || !$is_access}{assign var='disable_reuse' value=true}{/if}
            {if $petition.agent_user && $login.id == $petition.agent_user}
                {capture name='grn_workflow_reuse_and_apply'}{cb_msg module='grn.workflow' key='reuse_and_apply' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_reuse_and_apply page='workflow/send_form_reuse_proxy' image='reuse20.gif' fid=$fid pid=$pid simple=$simple disabled=$disable_reuse element_id="workflow/send_form_reuse_proxy" alt=''}
            {else}
                {capture name='grn_workflow_reuse_and_apply'}{cb_msg module='grn.workflow' key='reuse_and_apply' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_reuse_and_apply page='workflow/send_form_reuse' image='reuse20.gif' fid=$fid pid=$pid simple=$simple disabled=$disable_reuse element_id="workflow/send_form_reuse" alt=''}
            {/if}
            </span>
        <span class="menu_item">
            {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple element_id="workflow/print" alt=''}
        </span>
        {* 下書き *}
        {elseif GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID == $folder.col_folder_type}
            <span class="menu_item">
                {if !$form || !$is_access}{assign var='disable_draft' value=true}{/if}
                {if $petition.agent_user && $login.id == $petition.agent_user}
                    {capture name='grn_workflow_edit_draft_2'}{cb_msg module='grn.workflow' key='edit_draft_2' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_edit_draft_2 page='workflow/send_form_draft_proxy' image='modify20.gif' fid=$fid pid=$pid simple=$simple disabled=$disable_draft element_id="workflow/send_form_draft_proxy" alt=''}
                {else}
                    {capture name='grn_workflow_edit_draft_2'}{cb_msg module='grn.workflow' key='edit_draft_2' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_edit_draft_2 page='workflow/send_form_draft' image='modify20.gif' fid=$fid pid=$pid simple=$simple disabled=$disable_draft element_id="workflow/send_form_draft" alt=''}
                {/if}
            </span>
            <span class="menu_item">
                {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple element_id="workflow/print" alt=''}
            </span>
            <span class="menu_item">
                {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
                {capture name='grn_workflow_delete_from_draft'}{cb_msg module='grn.workflow' key='delete_from_draft' replace='true'}{/capture}{grn_link id="lnk_delete" caption=$smarty.capture.grn_workflow_delete_from_draft script='javascript:void(0);' image='delete20.gif' fid=$fid pid=$pid simple=$simple alt=''}
            </span>
        {/if}
    {else}
        <span class="menu_item">
            {if $fid != GRN_WORKFLOW_FOLDER_TYPE_APPROVAL_PLAN_ID}
                {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple element_id="workflow/print" alt=''}
            {/if}
        </span>
    {/if}
    {if $auto_register_status=="success"}
        <p class="explanation">
            <div class="mBottom10"><span class="icon_information_grn">{cb_msg module='grn.workflow' key='auto_schedule_confirm_success' replace='true'}({capture name='grn_workflow_auto_schedule_link'}{cb_msg module='grn.workflow' key='auto_schedule_confirm_success_link' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_auto_schedule_link page='schedule/view' event=$schedule_id})</span></div>
        {elseif $auto_register_status=="failed"}
            <div class="mBottom10"><span class="icon_attention_grn"><span class="attentionMessage-grn">{cb_msg module='grn.workflow' key='auto_schedule_confirm_failed' replace='true'}</span></span></div>
        </p>
    {/if}
</div>

{grn_title title=$page_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

{if GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $petition.status}
    <!-- 取り戻し -->
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow' key='key_5_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_5_2' replace='true'}</span>{cb_msg module='grn.workflow' key='key_5_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
                <td>{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid users_info=$users_info}
                    {if $petition.agent_transactor || $petition.agent_transactor_name}
                        {cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_transactor name=$petition.agent_transactor_name valid=$petition.agent_transactor_valid users_info=$users_info}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                    {/if}
                </td>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='date_time' replace='true'}</th>
                <td>{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ptime}</td>
            </tr>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='comment' replace='true'}</th>
                <td colspan="3">{grn_format body=$petition.comment}</td>
            </tr>
        </table>
    </div>
    <div class="border-partition-common-grn"></div>
{elseif GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status}
    <!-- 取り消し -->
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow' key='key_6_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_6_2' replace='true'}</span>{cb_msg module='grn.workflow' key='key_6_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
                <td>{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid users_info=$users_info}
                    {if $petition.agent_transactor || $petition.agent_transactor_name}
                        {cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_transactor name=$petition.agent_transactor_name valid=$petition.agent_transactor_valid users_info=$users_info}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                    {/if}   
                </td>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='date_time' replace='true'}</th>
                <td>{grn_date_format format='DateTimeMiddle_YMDW_HM'  date=$petition.ptime}</td>
            </tr>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='comment' replace='true'}</th>
                <td colspan="3">{grn_format body=$petition.comment}</td>
            </tr>
        </table>
    </div>
    <div class="border-partition-common-grn"></div>
{elseif 'reapply' == $handle_mode}
    <!-- 再申請 -->
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow' key='key_7_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_7_2' replace='true'}</span>{cb_msg module='grn.workflow' key='key_7_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</th>
                <td>{grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid users_info=$users_info}
                    {if $petition.agent_user || $petition.agent_user_name}
                        {cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_user name=$petition.agent_user_name valid=$petition.agent_user_valid users_info = $users_info}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                    {/if}
                </td>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='date_time' replace='true'}</th>
                <td>{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ctime}</td>
            </tr>
        </table>
    </div>
    <div class="border-partition-common-grn"></div>
{/if}

{* 申請の標題 *}
<div class="marginHalf">
    {grn_workflow_priority value=$petition.priority mode="view"}
    {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if}
    <font size="+1"><span class="bold">{$petition.form_name|escape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</span></font>
</div>

{if $view}
    <div class="border-partition-common-grn"></div>
    {* 申請内容 *}
    <span class="sub_title">{cb_msg module='grn.workflow' key='application_contents' replace='true'}</span>
    <table class="view_table" width="100%">
        <tr valign="top">
            <th rowspan="1" align="left">{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</th>
            {if $petition.agent_user || $petition.agent_user_name}
                <td nowrap>
                    {grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid users_info=$users_info}
                    {cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}
                    {grn_user_name uid=$petition.agent_user name=$petition.agent_user_name  valid=$petition.agent_user_valid users_info=$users_info}
                    {cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                </td>
            {else}
                <td nowrap>{grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid users_info=$users_info}</td>
            {/if}
        </tr>
        <tr valign="top">
            <th rowspan="1" align="left">{cb_msg module='grn.workflow' key='item_type_4' replace='true'}</th>
            <td nowrap>{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ctime}</td>
        </tr>
<!-- ここから　項目セクション -->
        {foreach from=$item_data_list item=item_data_line}
            {if $item_data_line.type == 2}
                </table>
                <table width="100%">
                    <tr valign="top">
                        <td>
                            <div class="wf_empty_row"></div>
                        </td>
                    </tr>
                </table>
                <table class="view_table" width="100%">
            {elseif $item_data_line.type == 3}
                <tr valign="top">
                    <td colspan="2">
                        {if $item_data_line.sub_item_data_count == 0}
                            <div id="js_customization_item_{$item_data_line.code}"></div>
                        {else}
                            <table class="layout-border-none" width="100%">
                                <tr>
                                    {grn_workflow_include_item folder_id=$fid petition_id=$pid iid=$item_data_line.iid item=$item_data_line display="view"}
                                    {foreach from=$item_data_line.sub_item_data_list item=sub_item_data}
                                        {grn_workflow_include_item folder_id=$fid petition_id=$pid iid=$sub_item_data.iid item=$sub_item_data display="view"}
                                    {/foreach}
                                </tr>
                            </table>
                        {/if}
                    </td>
                </tr>
            {else}
                <tr valign="top">
                    {if $item_data_line.type != 3}
                        <th rowspan="1" align="left">
                            {$item_data_line.display_name|escape}
                        </th>
                    {/if}
                    {if $item_data_line.sub_item_data_count == 0}
                        {grn_workflow_include_item folder_id=$fid petition_id=$pid iid=$item_data_line.iid item=$item_data_line display="view"}
                    {else}
                        <td>
                            {if $item_data_line.right_align_flag == 1}
                                <table class="layout-border-none-full-width">
                            {else}
                                <table class="layout-border-none" width="100%">
                            {/if}
                                <tr>
                                    {grn_workflow_include_item folder_id=$fid petition_id=$pid iid=$item_data_line.iid item=$item_data_line display="view"}
                                    {foreach from=$item_data_line.sub_item_data_list item=sub_item_data}
                                        {grn_workflow_include_item folder_id=$fid petition_id=$pid iid=$sub_item_data.iid item=$sub_item_data display="view"}
                                    {/foreach}
                                </tr>
                            </table>
                        </td>
                    {/if}
                </tr>
            {/if}
        {/foreach}
<!-- ここまで　項目セクション -->
    </table>

    {if GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID != $folder.col_folder_type}
        <p></p>
        {if $simple}{* 進行状況（簡易版） *}
            <span class="sub_title">{cb_msg module='grn.workflow' key='process_status' replace='true'}</span>
            <span class="menu_item">
                <small>{cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{capture name='grn_workflow_show_all_process_status'}{cb_msg module='grn.workflow' key='show_all_process_status' replace='true'}{/capture}{grn_link page='workflow/view' caption=$smarty.capture.grn_workflow_show_all_process_status fid=$fid pid=$pid simple=0}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</small>
            </span>
            {if GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID != $folder.col_folder_type}
                <div id="main_menu_part">
                    <span class="menu_item">
                        {if $fid != GRN_WORKFLOW_FOLDER_TYPE_APPROVAL_PLAN_ID}
                            {capture name='grn_workflow_change_path_history_list'}{cb_msg module='grn.workflow' key='change_path_history_list' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_change_path_history_list page='workflow/change_path_history_list' image='view20.gif' fid=$fid pid=$pid simple=$simple disabled=$no_change_path_history cid=$cid alt=''}
                            {if !$no_change_path_history}
                                <span class="inline_block_grn mTop7 mBottom3 mLeft15"><span class="information_strong_grn"><span class="icon_information_grn attention_message_sub_grn bold_grn">{cb_msg module='grn.workflow' key='route_changed' replace='true'}</span></span></span>
                            {/if}
                        {/if}
                    </span>
                </div>
            {/if}
            <div class="wf_path_table_simple">
                <table class="list_column">
                    <colgroup>
                        {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status && GRN_WORKFLOW_STATUS_TEMPORARY < $petition.status}<col width="1%">{/if}
                        <col width="10%">
                        <col width="85%">
                        <col width="4%">
                    </colgroup>
                    <tr>
                        {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status && GRN_WORKFLOW_STATUS_TEMPORARY < $petition.status}<th></th>{/if}
                        <th nowrap>{cb_msg module='grn.workflow' key='path_class' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.workflow' key='path_step' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.workflow' key='result_datetime_processor' replace='true'}</th>
                    </tr>

                    {assign var=not_first value=true}
                    {foreach name=path_step from=$path_steps item=path_step}
                        {if $path_step.col_activate}
                            <tr>
                                {* 状況アイコン *}
                                {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status && GRN_WORKFLOW_STATUS_TEMPORARY < $petition.status}
                                    <td align="center">
                                        {if $path_step.in_process}
                                            {grn_image image='current20.gif'}
                                        {elseif GRN_WORKFLOW_FINISHED_REJECTION == $path_step.col_finished}
                                            {grn_image image='reject20.gif'}
                                        {elseif GRN_WORKFLOW_FINISHED_REMAND == $path_step.col_finished}
                                            {grn_image image='remand20.gif'}
                                        {/if}
                                    </td>
                                {/if}
                                {* 経路種別 *}
                                {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                                    <td nowrap>{cb_msg module='grn.workflow' key='pass_along' replace='true'}</td>
                                {else}
                                    {if $path_step.last_acceptance}
                                        <td class="last_decision" nowrap><span class="kind">{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</span></td>
                                    {else}
                                        <td nowrap>{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</td>
                                    {/if}
                                {/if}
                                {* 経路ステップ名 *}
                                <td>{grn_link caption=$path_step.col_role page='workflow/path_step_view' fid=$fid pid=$pid simple=$simple psid=$path_step._id br=true}</td>
                                {* 処理者/結果/コメント/日時 *}
                                {if $not_first}
                                    {assign var=not_first value=false}
                                    <td rowspan="{$path_step_total}" nowrap>
                                        <small>{cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{capture name='grn_workflow_show_all_process_status'}{cb_msg module='grn.workflow' key='show_all_process_status' replace='true'}{/capture}{grn_link page='workflow/view' caption=$smarty.capture.grn_workflow_show_all_process_status fid=$fid pid=$pid simple=0}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</small>
                                    </td>
                                {/if}
                            </tr>
                        {/if}
                    {/foreach}
                </table>
            </div>
        {else}
            {* 進行状況（フル） *}
            <span class="sub_title">{cb_msg module='grn.workflow' key='process_status' replace='true'}</span>
            <span class="menu_item">
                <small>{cb_msg module='grn.workflow' key='bracket_arrow_left' replace='true'}{capture name='grn_workflow_show_path_step_path_type'}{cb_msg module='grn.workflow' key='show_path_step_path_type' replace='true'}{/capture}{grn_link page='workflow/view' caption=$smarty.capture.grn_workflow_show_path_step_path_type fid=$fid pid=$pid simple=1}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</small>
            </span>
            {if GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID != $folder.col_folder_type}
                <div id="main_menu_part">
                    <span class="menu_item">
                        {if $fid != GRN_WORKFLOW_FOLDER_TYPE_APPROVAL_PLAN_ID}
                            {capture name='grn_workflow_change_path_history_list'}{cb_msg module='grn.workflow' key='change_path_history_list' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_change_path_history_list page='workflow/change_path_history_list' image='view20.gif' fid=$fid pid=$pid simple=$simple disabled=$no_change_path_history cid=$cid alt=''}
                            {if !$no_change_path_history}
                                <span class="inline_block_grn mTop7 mBottom3 mLeft15"><span class="information_strong_grn"><span class="icon_information_grn attention_message_sub_grn bold_grn">{cb_msg module='grn.workflow' key='route_changed' replace='true'}</span></span></span>
                            {/if}
                        {/if}
                    </span>
                </div>
            {/if}
            <div class="wf_path_table">
                <table class="list_column">
                    <colgroup>
                        {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status && GRN_WORKFLOW_STATUS_TEMPORARY < $petition.status}<col width="1%">{/if}
                        <col width="10%">
                        <col width="25%">
                        <col width="5%">
                        <col width="15%">
                        <col width="44%">
                    </colgroup>
                    <tr>
                        {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status && GRN_WORKFLOW_STATUS_TEMPORARY < $petition.status}<th></th>{/if}
                        <th nowrap>{cb_msg module='grn.workflow' key='path_class' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.workflow' key='path_step' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.workflow' key='result' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.workflow' key='date_time' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.workflow' key='processor_comment' replace='true'}</th>
                    </tr>
                    {foreach name=path_step from=$path_steps item=path_step}
                        {if $path_step.col_activate}
                            {if ! $path_step.col_skip || 0 < $path_step.user_count}
                                {assign var=not_first value=true}
                                {foreach name=user from=$path_step.users item=user}
                                    <tr>
                                        {if $not_first}
                                            {assign var=not_first value=false}
                                            {* 状況アイコン *}
                                            {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status && GRN_WORKFLOW_STATUS_TEMPORARY < $petition.status}
                                                <td rowspan="{$path_step.user_count}" align="center">
                                                    {if $path_step.in_process}
                                                        {grn_image image='current20.gif'}
                                                    {elseif GRN_WORKFLOW_FINISHED_REJECTION == $path_step.col_finished}
                                                        {grn_image image='reject20.gif'}
                                                    {elseif GRN_WORKFLOW_FINISHED_REMAND == $path_step.col_finished}
                                                        {grn_image image='remand20.gif'}
                                                    {/if}
                                                </td>
                                            {/if}
                                            {* 経路種別 *}
                                            {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                                                <td rowspan="{$path_step.user_count}" nowrap>{cb_msg module='grn.workflow' key='pass_along' replace='true'}</td>
                                            {else}
                                                {if $path_step.last_acceptance}
                                                    <td rowspan="{$path_step.user_count}" class="last_decision" nowrap><span class="kind">{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</span></td>
                                                {else}
                                                    <td rowspan="{$path_step.user_count}" nowrap>{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</td>
                                                {/if}
                                            {/if}
                                            {* 経路ステップ名 *}
                                            <td rowspan="{$path_step.user_count}">{grn_link caption=$path_step.col_role page='workflow/path_step_view' fid=$fid pid=$pid simple=$simple psid=$path_step._id cid=$cid br=true}</td>
                                        {/if}
                                        {* 結果 *}
                                        <td class="tAlignCenter-grn" nowrap>
                                            {* 0:- 1:未処理 2:承認 3:却下 4:差し戻し 5:確認 *}
                                            {if GRN_WORKFLOW_RESULT_ACCEPT <= $user.col_result}
                                                {if $path_step.last_acceptance}
                                                    <div class="wfRouteHistoryResultMarkOkLast-grn">{cb_msg module='grn.workflow' key="col_result_`$user.col_result`"}</div>
                                                {else}
                                                    <div class="wfRouteHistoryResultMark-grn">{cb_msg module='grn.workflow' key="col_result_`$user.col_result`"}</div>
                                                {/if}
                                            {else}
                                                {cb_msg module='grn.workflow' key="col_result_`$user.col_result`"}
                                            {/if}
                                        </td>
                                        {* 日時 *}
                                        <td nowrap>{if GRN_WORKFLOW_RESULT_UNPROCESSING != $user.col_result}{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$user.col_ptime}{/if}</td>
                                        {* 処理者 *}
                                        <td class="wfRouteHistoryUserComment-grn">
                                            <div class="wfRouteHistory-grn">
                                                <span class="wfRouteHistoryUser-grn">
                                                    {if $user.col_agent_user || $user.col_agent_display_name}
                                                        {grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid users_info=$users_info}
                                                        {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$user._agent_id name=$user.col_agent_display_name valid=$user.col_agent_valid users_info=$users_info}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                    {else}
                                                        {grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid users_info=$users_info}
                                                    {/if}
                                                </span>
                                                {* コメント *}
                                                <div class="wfRouteHistoryComment-grn">{grn_format span_mode=true body=$user.col_comment.current}</div>
                                                {if 0 < $user.col_comment.log_total}
                                                    {foreach from=$user.col_comment.logs item=log}
                                                        <div class="wfRouteHistoryTitle-grn">
                                                            <div class="wfRouteHistoryCommentAction-grn">
                                                                <span class="nowrap-grn">
                                                                    {cb_msg module='grn.workflow' key="col_result_`$log.col_result`"}
                                                                    {if $log.col_agent}
                                                                        {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$log.col_agent name=$log.col_agent_name users_info=$users_info}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                                    {/if}
                                                                    {if GRN_WORKFLOW_RESULT_REMAND == $log.col_result}
                                                                        {if 'applicant' == $log.destination}
                                                                            {cb_msg module='grn.workflow' key='applicant_bracket_arrow' replace='true'}
                                                                        {else}
                                                                            {assign var='destination' value=$log.destination}
                                                                            {cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{$path_steps.$destination.col_role|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                                                        {/if}
                                                                    {/if}
                                                                </span>
                                                                <span class="wfRouteHistoryCommentDate-grn">
                                                                    {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$log.col_ptime}
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="wfRouteHistoryComment-grn">{grn_format span_mode=true body=$log.col_comment}</div>
                                                    {/foreach}
                                                {/if}
                                            </div>
                                        </td>
                                    </tr>
                                {/foreach}
                            {else}
                                {* （省略） *}
                                <tr>
                                    {* 状況アイコン *}
                                    {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status && GRN_WORKFLOW_STATUS_TEMPORARY < $petition.status}<td align="center">&nbsp;</td>{/if}
                                    {* 経路種別 *}
                                    <td nowrap>
                                        {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                                            {cb_msg module='grn.workflow' key='pass_along' replace='true'}
                                        {else}
                                            {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
                                        {/if}
                                    </td>
                                    {* 経路ステップ名 *}
                                    <td>{grn_link caption=$path_step.col_role page='workflow/path_step_view' fid=$fid pid=$pid simple=$simple psid=$path_step._id disabled=$path_step.not_modify br=true}</td>
                                    {* 結果 *}
                                    <td nowrap>{cb_msg module='grn.workflow' key='skip_result'}</td>
                                    {* 日時 *}
                                    <td nowrap>&nbsp;</td>
                                    {* 処理者&コメント *}
                                    <td class="wfRouteHistoryUserComment-grn" nowrap>{cb_msg module='grn.workflow' key='skip'}</td>
                                </tr>
                            {/if}
                        {/if}
                    {/foreach}
                </table>
            </div>
            {grn_image image='spacer20.gif'}
            <span class="menu_item">
                <small>{cb_msg module='grn.workflow' key='bracket_arrow_left' replace='true'}{capture name='grn_workflow_show_path_step_path_type'}{cb_msg module='grn.workflow' key='show_path_step_path_type' replace='true'}{/capture}{grn_link page='workflow/view' caption=$smarty.capture.grn_workflow_show_path_step_path_type fid=$fid pid=$pid simple=1}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</small>
            </span>
        {/if}
    {/if}
{else}
    <p class="comment">{cb_msg module='grn.workflow' key='cannot_show_contents' replace='true'}</p>
{/if}

{if $apply_customization && $view}
    {grn_load_customization_js_css}
{/if}

{include file="grn/footer.tpl"}
