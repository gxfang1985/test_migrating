{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{if 0 >= $change_path_history_total}
    {assign var=no_change_path_history value=true}
{/if}

<!--menubar-->
<p></p>
<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_workflow_system_petition_print'}{cb_msg module='grn.workflow.system' key='petition_print' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_petition_print page='workflow/system/petition_print' image='print20.gif' cid=$category_id fid=$form_id pid=$petition_id simple=$simple element_id="workflow/system/petition_print"}</span>
    <span class="menu_item">{capture name='grn_workflow_system_w_do_delete'}{cb_msg module='grn.workflow.system' key='w_do_delete' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_delete page='workflow/system/petition_delete' image='delete20.gif' cid=$category_id fid=$form_id pid=$petition_id element_id="workflow/system/petition_delete"}</span>
</div>
<p></p>
<!--menubar end-->

{* 取り戻し *}
{if GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $petition.status}
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow.system' key='key_123_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow.system' key='key_123_2' replace='true'}</span>{cb_msg module='grn.workflow.system' key='key_123_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow.system' key='w_processor_y' replace='true'}</th>
                <td>{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid}</td>
                <th align="left" nowrap>{cb_msg module='grn.workflow.system' key='w_date_and_time_y' replace='true'}</th>
                <td>{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ptime}</td>
            </tr>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow.system' key='w_comment' replace='true'}</th>
                <td colspan="3">{$petition.comment|escape|nl2br}</td>
            </tr>
        </table>
    </div>
    <p></p>
    <hr>
{* 取り消し *}
{elseif GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status}
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow.system' key='key_124_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow.system' key='key_124_2' replace='true'}</span>{cb_msg module='grn.workflow.system' key='key_124_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow.system' key='w_processor_y' replace='true'}</th>
                <td>{grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid}</td>
                <th align="left" nowrap>{cb_msg module='grn.workflow.system' key='w_date_and_time_y' replace='true'}</th>
                <td>{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ptime}</td>
            </tr>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow.system' key='w_comment' replace='true'}</th>
                <td colspan="3">{$petition.comment|escape|nl2br}</td>
            </tr>
        </table>
    </div>
    <p></p>
    <hr>
{/if}

<div class="marginHalf">
    {grn_workflow_priority value=$petition.priority mode="view"}
    {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if}
    <font size="+1"><span class="bold">{$petition.form_name|escape}{cb_msg module='grn.workflow.system' key='w_bracket_left' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}</span></font>
</div>


    <hr>
    <span class="sub_title">{cb_msg module='grn.workflow.system' key='w_application_contents_y' replace='true'}</span>
    <table class="view_table" width="100%">
        <tr valign="top">
            <th rowspan="1" align="left">{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}</th>
            <td nowrap>
                {grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid}
                {if $petition.agent_user || $petition.agent_user_name}
                    {cb_msg module='grn.workflow.system' key='w_substitute_applicant' replace='true'}
                    {grn_user_name uid=$petition.agent_user name=$petition.agent_user_name valid=$petition.agent_user_valid}
                    {cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}
                {/if}
            </td>
        </tr>
        <tr valign="top">
            <th rowspan="1" align="left">{cb_msg module='grn.workflow.system' key='w_application_date_y' replace='true'}</th>
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
                                    {grn_workflow_include_item category_id=$category_id folder_id=$foler_id petition_id=$petition_id iid=$item_data_line.iid item=$item_data_line display="view-system"}
                                    {foreach from=$item_data_line.sub_item_data_list item=sub_item_data}
                                        {grn_workflow_include_item category_id=$category_id folder_id=$foler_id petition_id=$petition_id iid=$sub_item_data.iid item=$sub_item_data display="view-system"}
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
                        {grn_workflow_include_item category_id=$category_id folder_id=$foler_id petition_id=$petition_id iid=$item_data_line.iid item=$item_data_line display="view-system"}
                    {else}
                        <td>
                            {if $item_data_line.right_align_flag == 1}
                                <table class="layout-border-none-full-width">
                            {else}
                                <table class="layout-border-none" width="100%">
                            {/if}
                            <tr>
                                {grn_workflow_include_item category_id=$category_id folder_id=$foler_id petition_id=$petition_id iid=$item_data_line.iid item=$item_data_line display="view-system"}
                                {foreach from=$item_data_line.sub_item_data_list item=sub_item_data}
                                    {grn_workflow_include_item category_id=$category_id folder_id=$foler_id petition_id=$petition_id iid=$sub_item_data.iid item=$sub_item_data display="view-system"}
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
    <p></p>
    {if $simple}
        <span class="sub_title">{cb_msg module='grn.workflow.system' key='w_progress_state_y' replace='true'}</span>
        <span class="menu_item">
            <small>{cb_msg module='grn.workflow.system' key='w_bracket_arrow_right' replace='true'}{capture name='grn_workflow_system_w_show_all_progress_state_y'}{cb_msg module='grn.workflow.system' key='w_show_all_progress_state_y' replace='true'}{/capture}{grn_link page='workflow/system/petition_view' caption=$smarty.capture.grn_workflow_system_w_show_all_progress_state_y cid=$category_id fid=$form_id pid=$petition_id simple=0}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}</small>
        </span>
        {if GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID != $folder.col_folder_type}
            <div id="main_menu_part">
                <span class="menu_item">
                    {capture name='grn_workflow_system_petition_change_path_history_list'}{cb_msg module='grn.workflow.system' key='petition_change_path_history_list' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_petition_change_path_history_list page='workflow/system/petition_change_path_history_list' image='view20.gif' cid=$category_id fid=$form_id pid=$petition_id disabled=$no_change_path_history}
                    {if !$no_change_path_history}
                        <span class="inline_block_grn mTop7 mBottom3 mLeft15"><span class="information_strong_grn"><span class="icon_information_grn attention_message_sub_grn bold_grn">{cb_msg module='grn.workflow' key='route_changed' replace='true'}</span></span></span>
                    {/if}
                </span>
            </div>
        {/if}
        <div class="wf_path_table_simple">
            <table class="list_column">
                <colgroup>
                    {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}<col width="1%">{/if}
                    <col width="10%">
                    <col width="85%">
                    <col width="4%">
                </colgroup>
                <tr>
                    {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}<th></th>{/if}
                    <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn.workflow.system' key='w_result_datetime_processor_y' replace='true'}</th>
                </tr>
                {assign var=not_first value=true}
                {foreach name=path_step from=$path_steps item=path_step}
                    {if $path_step.col_activate}
                        <tr>
                            {* 状況アイコン *}
                            {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}
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
                                <td nowrap>{cb_msg module='grn.workflow.system' key='w_circular' replace='true'}</td>
                            {else}
                                {if $path_step.last_acceptance}
                                    <td class="last_decision" nowrap><span class="kind">{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</span></td>
                                {else}
                                    <td nowrap>{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</td>
                                {/if}
                            {/if}
                            {* 経路ステップ名 *}
                            <td>{grn_link caption=$path_step.col_role page='workflow/system/petition_path_step_view' cid=$category_id fid=$form_id pid=$petition_id psid=$path_step._id br=true}</td>
                            {* 処理者/結果/コメント/日時 *}
                            {if $not_first}
                                {assign var=not_first value=false}
                                <td rowspan="{$path_step_total|escape}" nowrap>
                                    <small>{cb_msg module='grn.workflow.system' key='w_bracket_arrow_right' replace='true'}{capture name='grn_workflow_system_w_show_all_progress_state_y'}{cb_msg module='grn.workflow.system' key='w_show_all_progress_state_y' replace='true'}{/capture}{grn_link page='workflow/system/petition_view' caption=$smarty.capture.grn_workflow_system_w_show_all_progress_state_y cid=$category_id fid=$form_id pid=$petition_id simple=0}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}</small>
                                </td>
                            {/if}
                        </tr>
                    {/if}
                {/foreach}
            </table>
        </div>
    {else}
        <span class="sub_title">{cb_msg module='grn.workflow.system' key='w_progress_state_y' replace='true'}</span>
        <span class="menu_item">
            <small>{cb_msg module='grn.workflow.system' key='w_bracket_arrow_left' replace='true'}{capture name='grn_workflow_system_w_display_patheway_step_name_and_pathway_type'}{cb_msg module='grn.workflow.system' key='w_display_patheway_step_name_and_pathway_type' replace='true'}{/capture}{grn_link page='workflow/system/petition_view' caption=$smarty.capture.grn_workflow_system_w_display_patheway_step_name_and_pathway_type cid=$category_id fid=$form_id pid=$petition_id simple=1}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}</small>
        </span>
        {if GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID != $folder.col_folder_type}
            <div id="main_menu_part">
                <span class="menu_item">
                    {capture name='grn_workflow_system_petition_change_path_history_list'}{cb_msg module='grn.workflow.system' key='petition_change_path_history_list' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_petition_change_path_history_list page='workflow/system/petition_change_path_history_list' image='view20.gif' cid=$category_id fid=$form_id pid=$petition_id disabled=$no_change_path_history}
                    {if !$no_change_path_history}
                        <span class="inline_block_grn mTop7 mBottom3 mLeft15"><span class="information_strong_grn"><span class="icon_information_grn attention_message_sub_grn bold_grn">{cb_msg module='grn.workflow' key='route_changed' replace='true'}</span></span></span>
                    {/if}
                </span>
            </div>
        {/if}
        <div class="wf_path_table">
            <table class="list_column">
                <colgroup>
                    {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}<col width="1%">{/if}
                    <col width="10%">
                    <col width="25%">
                    <col width="5%">
                    <col width="15%">
                    <col width="44%">
                </colgroup>
                <tr>
                    {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}<th></th>{/if}
                    <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn.workflow.system' key='w_result_y' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn.workflow.system' key='w_date_and_time_y' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn.workflow.system' key='w_processor_comment_y' replace='true'}</th>
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
                                        {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}
                                            <td rowspan="{$path_step.user_count|escape}" align="center">
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
                                            <td rowspan="{$path_step.user_count|escape}" nowrap>{cb_msg module='grn.workflow.system' key='w_circular' replace='true'}</td>
                                        {else}
                                            {if $path_step.last_acceptance}
                                                <td class="last_decision" rowspan="{$path_step.user_count|escape}" nowrap><span class="kind">{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</span></td>
                                            {else}
                                                <td rowspan="{$path_step.user_count|escape}" nowrap>{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</td>
                                            {/if}
                                        {/if}
                                        {* 経路ステップ名 *}
                                        <td rowspan="{$path_step.user_count|escape}">{grn_link caption=$path_step.col_role page='workflow/system/petition_path_step_view' cid=$category_id fid=$form_id pid=$petition_id psid=$path_step._id br=true}</td>
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
                                                    {grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid}
                                                    {cb_msg module='grn.workflow.system' key='w_substitute_approver' replace='true'}{grn_user_name uid=$user._agent_id name=$user.col_agent_display_name valid=$user.col_agent_valid}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}
                                                {else}
                                                    {grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid}
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
                                                                    {cb_msg module='grn.workflow.system' key='w_substitute_approver' replace='true'}{grn_user_name uid=$log.col_agent name=$log.col_agent_name}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}
                                                                {/if}
                                                                {if GRN_WORKFLOW_RESULT_REMAND == $log.col_result}
                                                                    {if 'applicant' == $log.destination}
                                                                        {cb_msg module='grn.workflow.system' key='w_bracket_arrow_right_applicant' replace='true'}
                                                                    {else}
                                                                        {assign var='destination' value=$log.destination}
                                                                        {cb_msg module='grn.workflow.system' key='w_bracket_arrow_right' replace='true'}{$path_steps.$destination.col_role|escape}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}
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
                                {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}<td align="center">&nbsp;</td>{/if}
                                {* 経路種別 *}
                                <td nowrap>
                                    {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                                       {cb_msg module='grn.workflow.system' key='w_circular' replace='true'}
                                    {else}
                                       {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
                                    {/if}
                                </td>
                                {* 経路ステップ名 *}
                                <td>{grn_link caption=$path_step.col_role page='workflow/system/petition_path_step_view' cid=$category_id fid=$form_id pid=$petition_id psid=$path_step._id disabled=$path_step.not_modify br=true}</td>
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
            <small>{cb_msg module='grn.workflow.system' key='w_bracket_arrow_left' replace='true'}{capture name='grn_workflow_system_display_patheway_step_name_and_pathway_type'}{cb_msg module='grn.workflow.system' key='w_display_patheway_step_name_and_pathway_type' replace='true'}{/capture}{grn_link page='workflow/system/petition_view' caption=$smarty.capture.grn_workflow_system_display_patheway_step_name_and_pathway_type cid=$category_id fid=$form_id pid=$petition_id simple=1}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}</small>
        </span>
    {/if}


{if $apply_customization}
    {grn_load_customization_js_css}
{/if}

{include file="grn/system_footer.tpl"}
