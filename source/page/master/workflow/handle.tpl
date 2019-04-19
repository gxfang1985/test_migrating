{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{include file="grn/common.tpl"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="grn/html/page/workflow/update_automated_calculation.js"}

{assign var='form_name' value=$smarty.template|basename|cat:$tmp_key}

{if 0 >= $change_path_history_total}
    {assign var=no_change_path_history value=true}
{/if}

<form id="wf_request" name="{$form_name}" method="post" action="{grn_pageurl page='workflow/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{literal}
<script language="Javascript" type="text/javascript">
<!--
function onBatch()
{
    var form = document.forms['{/literal}{$form_name|escape}{literal}'];
    form.cmd.value = 'next';
    grn.page.workflow.ajax_submit.workflow_submit('{/literal}{$form_name|escape}{literal}', '{/literal}{grn_pageurl page=workflow/command_`$page_info.last`}{literal}');
}

(function()
{
    var Y = YAHOO.util;
    var Dom = Y.Dom;
    var Selector = Y.Selector;
    Y.Event.onDOMReady(function()
    {
        var table = Selector.query('div.workflow_attention > table', null, true);
        var region = Dom.getRegion(table);
        var div = Selector.query('div.workflow_attention', null, true);
        Dom.setStyle(div,'width',region.width + "px");
    });
})();
//-->
</script>
{/literal}

{if $cpsf}
    <div class="series_processing_navi"><span class="bold">{cb_msg module='grn.workflow' key='leave_this_application_go_next' replace='true'}</span><a href="javascript:onBatch();">{cb_msg module='grn.workflow' key='next' replace='true'} >></a></span></div>
{/if}

{if GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $petition.status}
    <!-- 取り戻し -->
    {grn_title title=$workflow_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {if 'view_only' != $handle_mode}
        <div class="explanation mTop15 mBottom15">{cb_msg module='grn.workflow' key='click_confirm_button_after_confirming_notice' replace='true'}</div>
    {/if}
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow' key='key_5_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_5_2' replace='true'}</span>{cb_msg module='grn.workflow' key='key_5_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
                <td>
                    {if $petition.agent_transactor || $petition.agent_transactor_name}
                         {grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid}
                         {cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_transactor name=$petition.agent_transactor_name valid=$petition.agent_transactor_valid}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                    {else}
                        {grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid}
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
    {if 'view_only' != $handle_mode}
        <div class="mTop10">
            {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
            {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
            {grn_button id=`$page_info.last`_submit_confirmation ui='main' caption=$smarty.capture.grn_workflow_confirm
            onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
        </div>
    {/if}
{elseif GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status}
    <!-- 取り消し -->
    <div id="main_menu_part">
        <span class="menu_item">
            {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple cpsf=$cpsf tmp_key=$tmp_key alt=''}
        </span>
    </div>
    {grn_title title=$workflow_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {if 'view_only' != $handle_mode}
        <div class="explanation mTop15 mBottom15">{cb_msg module='grn.workflow' key='click_confirm_button_after_confirming_notice' replace='true'}</div>
    {/if}
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow' key='key_6_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_6_2' replace='true'}</span>{cb_msg module='grn.workflow' key='key_6_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
                <td>
                    {if $petition.agent_transactor || $petition.agent_transactor_name}
                        {grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid}
                        {cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_transactor name=$petition.agent_transactor_name valid=$petition.agent_transactor_valid}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                    {else}
                        {grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid}
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
    {if 'view_only' != $handle_mode}
        <div class="mTop10 mBottom15">
            {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
            {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
            {grn_button id=`$page_info.last`_submit_confirmation ui='main' caption=$smarty.capture.grn_workflow_confirm
            onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
        </div>
    {/if}
{elseif 'change_transactor' == $handle_mode}
    <!-- 経路変更 -->
    {assign var=path_step_id value=$change_path_history.col_path_step_data}
    {assign var=path_step value=$path_steps.$path_step_id}
    <div id="main_menu_part">
        <span class="menu_item">
            {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple cpsf=$cpsf tmp_key=$tmp_key alt=''}
        </span>
    </div>
    {grn_title title=$workflow_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {if 'view_only' != $handle_mode}
        <div class="explanation mTop15 mBottom15">{cb_msg module='grn.workflow' key='click_confirm_button_after_confirming_notice' replace='true'}</div>
    {/if}
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow' key='key_50_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_50_2' replace='true'}</span>{cb_msg module='grn.workflow' key='key_50_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
                <td nowrap>{grn_user_name uid=$change_path_history.col_creator name=$change_path_history.col_creator_name valid=$change_path_history.col_valid}</td>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='date_time' replace='true'}</th>
                <td>{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$change_path_history.col_ctime}</td>
            </tr>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='path_step_name' replace='true'}</th><td colspan="3">{$path_step.col_role|escape}</td>
            </tr>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='path_class' replace='true'}</th>
                <td colspan="3">
                    {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                        {cb_msg module='grn.workflow' key='pass_along' replace='true'}
                    {else}
                        {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
                    {/if}
                </td>
            </tr>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='add' replace='true'}</th>
                <td colspan="3">
                    <table class="layout" width="100%">
                        <tr>
                            <td valign="top">
                                {foreach from=$change_path_history.add_users item=user}
                                    {grn_user_name uid=$user.col_user name=$user.col_old_display_name valid=$user.col_valid}
                                {/foreach}
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='delete_3' replace='true'}</th>
                <td colspan="3">
                    <table class="layout" width="100%">
                        <tr>
                            <td valign="top">
                                {foreach from=$change_path_history.deleted_users item=user}
                                    {grn_user_name uid=$user.col_user name=$user.col_old_display_name valid=$user.col_valid}
                                {/foreach}
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='comment' replace='true'}</th>
                <td colspan="3">{grn_format body=$change_path_history.col_comment}</td>
            </tr>
        </table>
    </div>
    {if 'view_only' != $handle_mode}
        <div class="mTop10 mBottom15">
            {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
            {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
            {grn_button id=`$page_info.last`_submit_confirmation ui='main' caption=$smarty.capture.grn_workflow_confirm
            onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
        </div>
    {/if}
{elseif GRN_WORKFLOW_STATUS_REMAND == $petition.status}
    <!-- 差し戻し -->
    <div id="main_menu_part">
        <span class="menu_item">
            {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple cpsf=$cpsf tmp_key=$tmp_key alt=''}
        </span>
    </div>
    {grn_title title=$workflow_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {if 'confirm' == $handle_mode}
        <div class="explanation mTop15 mBottom15">{cb_msg module='grn.workflow' key='click_confirm_button_after_confirming_notice' replace='true'}</div>
    {elseif 'view_only' != $handle_mode}
        <div class="explanation mTop15 mBottom15">{cb_msg module='grn.workflow' key='confirm_application_contents' replace='true'}</div>
    {/if}
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow' key='key_13_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_13_2' replace='true'}</span>{cb_msg module='grn.workflow' key='key_13_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
                <td>
                    {if $petition.agent_transactor || $petition.agent_transactor_name}
                        {grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid}
                        {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$petition.agent_transactor name=$petition.agent_transactor_name  valid=$petition.agent_transactor_valid}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                    {else}
                        {grn_user_name uid=$petition.transactor name=$petition.transactor_name valid=$petition.transactor_valid}
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
    {if 'confirm' == $handle_mode || 'reapply' == $handle_mode}
        <div class="mTop10 mBottom15">
            {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
            {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
            {grn_button id=`$page_info.last`_submit_confirmation ui='main' caption=$smarty.capture.grn_workflow_confirm
            onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
        </div>
    {/if}
{elseif 'reapply' == $handle_mode}
    <!-- 再申請 -->
    <div id="main_menu_part">
        <span class="menu_item">
            {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple cpsf=$cpsf tmp_key=$tmp_key alt=''}
        </span>
    </div>
    {grn_title title=$workflow_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    <div class="explanation mTop15 mBottom15">{cb_msg module='grn.workflow' key='click_confirm_button_after_confirming_notice' replace='true'}</div>
    <div class="workflow_attention">
        <span class="message">{cb_msg module='grn.workflow' key='key_7_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_7_2' replace='true'}</span>{cb_msg module='grn.workflow' key='key_7_3' replace='true'}</span>
        <table>
            <tr>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</th>
                <td>{grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid}</td>
                <th align="left" nowrap>{cb_msg module='grn.workflow' key='date_time' replace='true'}</th>
                <td>{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$petition.ctime}</td>
            </tr>
        </table>
    </div>
    {if 'view_only' != $handle_mode}
        <div class="mTop10 mBottom15">
            {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
            {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
            {grn_button id='workflow_button_acknowledge_upper' ui='main' caption=$smarty.capture.grn_workflow_confirm
            onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
        </div>
    {/if}
{elseif 'confirm' == $handle_mode}
<!-- その他 -->
    {if $error}
        {grn_title title=$workflow_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
        <div class="explanation mTop15 mBottom15">{cb_msg module='grn.workflow' key='processing_or_sent_back' replace='true'}<br>{cb_msg module='grn.workflow' key='click_confirm_button' replace='true'}</div>
    {else}
        <div id="main_menu_part">
            <span class="menu_item">
                {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple cpsf=$cpsf tmp_key=$tmp_key alt=''}
            </span>
        </div>
        {grn_title title=$workflow_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
        <div class="explanation mTop15 mBottom15">
          {if $schedule_available_for_external}
            {if $auto_register_status=="success"}
                <div class="mBottom10"><span class="icon_information_grn">{cb_msg module='grn.workflow' key='auto_schedule_confirm_success' replace='true'}({capture name='grn_workflow_auto_schedule_link'}{cb_msg module='grn.workflow' key='auto_schedule_confirm_success_link' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_auto_schedule_link page='schedule/view' event=$schedule_id})</span></div>
            {elseif $auto_register_status=="failed"}
                <div class="mBottom10"><span class="icon_attention_grn"><span class="attentionMessage-grn">{cb_msg module='grn.workflow' key='auto_schedule_confirm_failed' replace='true'}</span></span></div>
            {/if}
            {cb_msg module='grn.workflow' key='click_confirm_button' replace='true'}
          {/if}
        </div>
    {/if}
    {if 'view_only' != $handle_mode}
        <div class="mTop10 mBottom15">
            {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
            {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
            {grn_button id='workflow_button_acknowledge_upper' ui='main' caption=$smarty.capture.grn_workflow_confirm
            onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
        </div>
    {/if}
{else}
    <!-- 進行中、承認 -->
    <div id="main_menu_part">
        <span class="menu_item">
            {capture name='grn_workflow_print_screen'}{cb_msg module='grn.workflow' key='print_screen' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_print_screen page='workflow/print' image='print20.gif' fid=$fid pid=$pid simple=$simple cpsf=$cpsf tmp_key=$tmp_key alt=''}
        </span>
    </div>
    {grn_title title=$workflow_title class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {if 'view_only' != $handle_mode}
        <div class="explanation mTop15 mBottom15">
          {if $schedule_available_for_external}
            {if $auto_register_status=="success"}
                <div class="mBottom10"><span class="icon_information_grn">{cb_msg module='grn.workflow' key='auto_schedule_confirm_success' replace='true'}({capture name='grn_workflow_auto_schedule_link'}{cb_msg module='grn.workflow' key='auto_schedule_confirm_success_link' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_auto_schedule_link page='schedule/view' event=$schedule_id})</span></div>
            {elseif $auto_register_status=="failed"}
                <div class="mBottom10"><span class="icon_attention_grn"><span class="attentionMessage-grn">{cb_msg module='grn.workflow' key='auto_schedule_confirm_failed' replace='true'}</span></span></div>
            {/if}
          {/if}
            {cb_msg module='grn.workflow' key='confirm_application_contents' replace='true'}
        </div>
    {/if}
{/if}

<!-- 申請内容 -->
{include file='grn/_ajax_submit_check_error.tpl'}
<div class="border-partition-common-grn"></div>
<div class="marginHalf">
    {grn_workflow_priority value=$petition.priority mode="view"}
    {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if}
    <font size="+1"><span class="bold">{$petition.form_name|escape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</span></font>
</div>
{if $view}
    <div class="border-partition-common-grn"></div>
    <span class="sub_title">{cb_msg module='grn.workflow' key='application_contents' replace='true'}</span>
    <table class="view_table" width="100%">
        <col width="15%">
        <col width="85%">
        <tr valign="top">
            <th rowspan="1" align="left">{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</th>
            <td nowrap>{grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid}
                {if $petition.agent_user || $petition.agent_user_name}
                    {cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_user name=$petition.agent_user_name valid=$petition.agent_user_valid}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                {/if}
            </td>
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
                        {if $item_data_line.view_mode == 'edit'}
                            {grn_show_input_title title=$item_data_line.display_name necessary=$item_data_line.total_required}
                        {else}
                            {$item_data_line.display_name|escape}
                        {/if}
                    </th>
                    {/if}
                    {assign var="current_display_name" value=$item_data_line.display_name}
                    {assign var="delete_image_align" value="bottom"}
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
    <p></p>
    {if $simple}
        <span class="sub_title">{cb_msg module='grn.workflow' key='process_status' replace='true'}</span>
        <span class="menu_item">
            <small>{cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{capture name='grn_workflow_show_all_process_status'}{cb_msg module='grn.workflow' key='show_all_process_status' replace='true'}{/capture}{grn_link page='workflow/handle' caption=$smarty.capture.grn_workflow_show_all_process_status fid=$fid pid=$pid simple=0 cpsf=$cpsf tmp_key=$tmp_key}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</small>
        </span>
        {if GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID != $folder.col_folder_type}
            <div id="main_menu_part">
                <span class="menu_item">
                    {capture name='grn_workflow_change_path_history_list'}{cb_msg module='grn.workflow' key='change_path_history_list' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_change_path_history_list page='workflow/change_path_history_list' image='view20.gif' fid=$fid pid=$pid simple=$simple disabled=$no_change_path_history cpsf=$cpsf tmp_key=$tmp_key alt=''}
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
                    <th nowrap>{cb_msg module='grn.workflow' key='path_class' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn.workflow' key='path_step' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn.workflow' key='result_datetime_processor' replace='true'}</th>
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
                                <td nowrap>{cb_msg module='grn.workflow' key='pass_along' replace='true'}</td>
                            {else}
                                {if $path_step.last_acceptance}
                                    <td class="last_decision" nowrap><span class="kind">{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</span></td>
                                {else}
                                    <td nowrap>{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</td>
                                {/if}
                            {/if}
                            {* 経路ステップ名 *}
                            <td>{grn_link caption=$path_step.col_role page='workflow/path_step_view' fid=$fid pid=$pid simple=$simple psid=$path_step._id cpsf=$cpsf tmp_key=$tmp_key br=true}</td>
                            {* 処理者/結果/コメント/日時 *}
                            {if $not_first}
                                {assign var=not_first value=false}
                                <td rowspan="{$path_step_total}" nowrap>
                                    <small>{cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{capture name='grn_workflow_show_all_process_status'}{cb_msg module='grn.workflow' key='show_all_process_status' replace='true'}{/capture}{grn_link page='workflow/handle' caption=$smarty.capture.grn_workflow_show_all_process_status fid=$fid pid=$pid simple=0 cpsf=$cpsf tmp_key=$tmp_key}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</small>
                                </td>
                            {/if}
                        </tr>
                    {/if}
                {/foreach}
            </table>
        </div>
    {else}
        <span class="sub_title">{cb_msg module='grn.workflow' key='process_status' replace='true'}</span>
        <span class="menu_item">
            <small>{cb_msg module='grn.workflow' key='bracket_arrow_left' replace='true'}{capture name='grn_workflow_show_path_step_path_type'}{cb_msg module='grn.workflow' key='show_path_step_path_type' replace='true'}{/capture}{grn_link page='workflow/handle' caption=$smarty.capture.grn_workflow_show_path_step_path_type fid=$fid pid=$pid simple=1 cpsf=$cpsf tmp_key=$tmp_key}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</small>
        </span>
        {if GRN_WORKFLOW_FOLDER_TYPE_TEMP_ID != $folder.col_folder_type}
            <div id="main_menu_part">
                <span class="menu_item">
                    {capture name='grn_workflow_change_path_history_list'}{cb_msg module='grn.workflow' key='change_path_history_list' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_change_path_history_list page='workflow/change_path_history_list' image='view20.gif' fid=$fid pid=$pid simple=$simple disabled=$no_change_path_history cpsf=$cpsf tmp_key=$tmp_key alt=''}
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
                                        {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}
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
                                        <td rowspan="{$path_step.user_count}">{grn_link caption=$path_step.col_role page='workflow/path_step_view' fid=$fid pid=$pid simple=$simple psid=$path_step._id cpsf=$cpsf tmp_key=$tmp_key br=true}</td>
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
                                                    {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$user._agent_id name=$user.col_agent_display_name valid=$user.col_agent_valid}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
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
                                                                    {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$log.col_agent name=$log.col_agent_name}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
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
                                {if GRN_WORKFLOW_STATUS_REMAND >= $petition.status}<td align="center">&nbsp;</td>{/if}
                                {* 経路種別 *}
                                <td nowrap>
                                    {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                                        {cb_msg module='grn.workflow' key='pass_along' replace='true'}
                                    {else}
                                        {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
                                    {/if}
                                </td>
                                {* 経路ステップ名 *}
                                <td>{grn_link caption=$path_step.col_role page='workflow/path_step_view' fid=$fid pid=$pid simple=$simple psid=$path_step._id disabled=$path_step.not_modify cpsf=$cpsf tmp_key=$tmp_key br=true}</td>
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
            <small>{cb_msg module='grn.workflow' key='bracket_arrow_left' replace='true'}{capture name='grn_workflow_show_path_step_path_type'}{cb_msg module='grn.workflow' key='show_path_step_path_type' replace='true'}{/capture}{grn_link page='workflow/handle' caption=$smarty.capture.grn_workflow_show_path_step_path_type fid=$fid pid=$pid simple=1 cpsf=$cpsf tmp_key=$tmp_key}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</small>
        </span>
    {/if}

    {if $view}
        {* 却下 *}
        {if GRN_WORKFLOW_STATUS_REJECTION > $petition.status}
            {if ! $handle_mode}
                {* 承認 *}
                {if GRN_WORKFLOW_ACCEPTANCE == $path_steps.$in_process.col_type}
                    {if 'view_only' != $handle_mode}
                        <div class="explanation mTop10">
                            {cb_msg module='grn.workflow' key='key_14_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_14_2' replace='true'}</span>{if $is_remand}{cb_msg module='grn.workflow' key='key_14_3' replace='true'}{else if}{cb_msg module='grn.workflow' key='key_14_4' replace='true'}{/if}{cb_msg module='grn.workflow' key='key_14_5' replace='true'}
                        </div>
                        <table class="std_form">
                            <tr>
                                <th rowspan="1" align="left"  nowrap>{cb_msg module='grn.workflow' key='name' replace='true'}</th>
                                <td>
                                    {if $agent_id}
                                        {grn_user_name uid=$user_id}
                                        {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$agent_id}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                    {else}
                                        {grn_user_name uid=$login.id name=$login.name}
                                    {/if}
                                </td>
                            </tr>
                            <tr valign="top">
                                <th rowspan="1" align="left" nowrap>{cb_msg module='grn.workflow' key='comment' replace='true'}</th>
                                <td>
                                    {grn_textarea name='col_comment' rows=5 cols=60 value=$col_comment}
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    {capture name='grn_workflow_accept'}{cb_msg module='grn.workflow' key='accept' replace='true'}{/capture}
                                    {capture name='grn_workflow_reject_2'}{cb_msg module='grn.workflow' key='reject_2' replace='true'}{/capture}
                                    {capture name='grn_workflow_key_15_4'}{cb_msg module='grn.workflow' key='key_15_4' replace='true'}{/capture}
                                    {capture name='grn_workflow_pageurl_command_send_path'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
                                    <div class="mTop10">
                                        {strip}
                                            {grn_button id=`$page_info.last`_submit_acceptance ui='main' spacing='loose' caption=$smarty.capture.grn_workflow_accept
                                            onclick="document.forms['$form_name'].cmd.value='acceptance'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_workflow_pageurl_command_send_path`', this);"}
                                            {grn_button id=`$page_info.last`_submit_reject ui='attention' spacing='tight' caption=$smarty.capture.grn_workflow_reject_2
                                            onclick="document.forms['$form_name'].cmd.value='reject'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_workflow_pageurl_command_send_path`', this);"}
                                            {if $is_remand}
                                                <select name="destination" class="mRight5">
                                                    {html_options options=$remand_options}
                                                </select>
                                                {grn_button id=`$page_info.last`_submit_remand caption=$smarty.capture.grn_workflow_key_15_4
                                                onclick="document.forms['$form_name'].cmd.value='remand'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_workflow_pageurl_command_send_path`', this);"}
                                            {/if}
                                        {/strip}
                                    </div>
                                </td>
                            </tr>
                        </table>
                    {/if}
                {else}
                    {* 確認 *}
                    {if 'view_only' != $handle_mode}
                        <div class="explanation mTop10">
                            {cb_msg module='grn.workflow' key='click_confirm_button_after_confirming_application' replace='true'}
                        </div>
                        <table class="std_form">
                            <tr>
                                <th rowspan="1" align="left"  nowrap>{cb_msg module='grn.workflow' key='name' replace='true'}</th>
                                <td>{grn_user_name uid=$login.id name=$login.name}</td>
                            </tr>
                            <tr valign="top">
                                <th rowspan="1" align="left" nowrap>{cb_msg module='grn.workflow' key='comment' replace='true'}</th>
                                <td>
                                    {grn_textarea name='col_comment' rows=5 cols=60 value=$col_comment}
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <div class="mTop10">
                                        {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
                                        {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
                                        {grn_button id='workflow_button_acknowledge_upper' ui='main' caption=$smarty.capture.grn_workflow_confirm
                                        onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
                                    </div>
                                </td>
                            </tr>
                        </table>
                    {/if}
                {/if}
            {/if}
        {elseif GRN_WORKFLOW_STATUS_REMAND == $petition.status}
            {* 申請者本人に差し戻し *}
            {if ! $handle_mode && 'view_only' != $handle_mode}
                {if ! $in_process && ($login.id == $petition.user || $login.id == $petition.agent_user) }
                    {strip}
                        <div class="mTop15 mBottom15">
                            {capture name='grn_workflow_apply_again'}{cb_msg module='grn.workflow' key='apply_again' replace='true'} >>{/capture}
                            {capture name='grn_workflow_cancel_message_1'}{cb_msg module='grn.workflow' key='cancel_message_1' replace='true'}{/capture}
                            {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
                            {grn_button id=`$page_info.last`_submit_reapply ui='main' spacing='normal' caption=$smarty.capture.grn_workflow_apply_again onclick="document.forms['$form_name'].cmd.value='reapply'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
                            {grn_button id='workflow_button_cancel' caption=$smarty.capture.grn_workflow_cancel_message_1 onclick="document.forms['$form_name'].cmd.value='cancel'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
                        </div>
                    {/strip}
                {else}
                    <div class="explanation mTop10">
                        {cb_msg module='grn.workflow' key='key_14_1' replace='true'}<span class="bold">{cb_msg module='grn.workflow' key='key_14_2' replace='true'}</span>{if $is_remand}{cb_msg module='grn.workflow' key='key_14_3' replace='true'}{else if}{cb_msg module='grn.workflow' key='key_14_4' replace='true'}{/if}{cb_msg module='grn.workflow' key='key_14_5' replace='true'}
                    </div>
                    <table class="std_form">
                        <tr>
                            <th rowspan="1" align="left"  nowrap>{cb_msg module='grn.workflow' key='name' replace='true'}</th>
                            <td>
                                {*grn_user_name uid=$login.id name=$login.name*}
                                {if $agent_id}
                                    {grn_user_name uid=$user_id}
                                    {cb_msg module='grn.workflow' key='per_pro_accept_bracket' replace='true'}{grn_user_name uid=$agent_id}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
                                {else}
                                    {grn_user_name uid=$login.id name=$login.name}
                                {/if}
                            </td>
                        </tr>
                        <tr valign="top">
                            <th rowspan="1" align="left" nowrap>{cb_msg module='grn.workflow' key='comment' replace='true'}</th>
                            <td>
                                {grn_textarea name='col_comment' rows=5 cols=60 value=$col_comment}
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                {capture name='grn_workflow_accept'}{cb_msg module='grn.workflow' key='accept' replace='true'}{/capture}
                                {capture name='grn_workflow_reject_2'}{cb_msg module='grn.workflow' key='reject_2' replace='true'}{/capture}
                                {capture name='grn_workflow_key_15_4'}{cb_msg module='grn.workflow' key='key_15_4' replace='true'}{/capture}
                                {capture name='grn_workflow_pageurl_command_send_path'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
                                <div class="mTop10">
                                    {strip}
                                        {grn_button id=`$page_info.last`_submit_acceptance ui='main' spacing='loose' caption=$smarty.capture.grn_workflow_accept
                                        onclick="document.forms['$form_name'].cmd.value='acceptance'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_workflow_pageurl_command_send_path`', this);"}
                                        {grn_button id=`$page_info.last`_submit_reject ui='attention' spacing='tight' caption=$smarty.capture.grn_workflow_reject_2
                                        onclick="document.forms['$form_name'].cmd.value='reject'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_workflow_pageurl_command_send_path`', this);"}
                                        {if $is_remand}
                                            <select name="destination" class="mRight5">
                                                {html_options options=$remand_options}
                                            </select>
                                            {grn_button id=`$page_info.last`_submit_remand caption=$smarty.capture.grn_workflow_key_15_4
                                            onclick="document.forms['$form_name'].cmd.value='remand'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_workflow_pageurl_command_send_path`', this);"}
                                        {/if}
                                    {/strip}
                                </div>
                            </td>
                        </tr>
                    </table>
                {/if}
            {/if}
        {/if}
    {/if}
{else}
    <p class="comment">{cb_msg module='grn.workflow' key='cannot_show_contents' replace='true'}</p>
{/if}
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="pid" value="{$pid|escape}">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="cpsf" value="{$cpsf|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
<input type="hidden" name="in_process" value="{$in_process|escape}">

{if $cpsf}
    <div class="series_processing_navi mTop10"><span class="bold">{cb_msg module='grn.workflow' key='leave_this_application_go_next' replace='true'}</span><a href="javascript:onBatch();">{cb_msg module='grn.workflow' key='next' replace='true'} >></a></span></div>
{/if}

{capture name='grn_workflow_destination_unselected'}{cb_msg module='grn.workflow' key='destination_unselected' replace='true'}{/capture}{validate form=$form_name field="destination" criteria="notEmpty" message=$smarty.capture.grn_workflow_destination_unselected transform="cb_trim" append="validation_errors"}
{if GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $petition.status || GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status || 'change_transactor' == $handle_mode}
    {if 'view_only' != $handle_mode}
        <div class="explanation mTop10">{cb_msg module='grn.workflow' key='click_confirm_button_after_confirming_notice' replace='true'}</div>
        <div class="mTop10 mBottom15">
            {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
            {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
            {grn_button ui='main' caption=$smarty.capture.grn_workflow_confirm
            onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
        </div>
    {/if}
{elseif GRN_WORKFLOW_STATUS_REMAND == $petition.status}
    {if 'confirm' == $handle_mode}
        <div class="explanation mTop10">{cb_msg module='grn.workflow' key='click_confirm_button_after_confirming_notice' replace='true'}</div>
    {elseif 'view_only' != $handle_mode}
        <div class="explanation mTop10">{cb_msg module='grn.workflow' key='confirm_application_contents' replace='true'}</div>
    {/if}
    {if 'confirm' == $handle_mode || 'reapply' == $handle_mode}
        <div class="mTop10 mBottom15">
            {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
            {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
            {grn_button ui='main' caption=$smarty.capture.grn_workflow_confirm onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
        </div>
    {/if}
{elseif 'reapply' == $handle_mode}
    <div class="explanation mTop10">{cb_msg module='grn.workflow' key='click_confirm_button_after_confirming_notice' replace='true'}</div>
    <div class="mTop10 mBottom15">
        {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
        {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
        {grn_button ui='main' caption=$smarty.capture.grn_workflow_confirm onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
    </div>
{elseif 'confirm' == $handle_mode}
    {if $error}
        <div class="explanation mTop10">{cb_msg module='grn.workflow' key='processing_or_sent_back' replace='true'}<br>{cb_msg module='grn.workflow' key='click_confirm_button' replace='true'}</div>
    {else}
        <div class="explanation mTop10">{cb_msg module='grn.workflow' key='click_confirm_button' replace='true'}</div>
    {/if}
    <div class="mTop10 mBottom15">
        {capture name='grn_workflow_confirm'}{cb_msg module='grn.workflow' key='confirm' replace='true'}{/capture}
        {capture name='grn_pageurl_command_handle'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
        {grn_button ui='main' caption=$smarty.capture.grn_workflow_confirm onclick="document.forms['$form_name'].cmd.value='confirmation'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_handle`', this);"}
    </div>
{/if}
</form>
{grn_load_javascript file="grn/html/component/ajax_submit_wf.js"}
{grn_load_javascript file="grn/html/component/pubsub.js"}
{grn_load_javascript file="js/dist/workflow.js"}
{grn_load_javascript file="grn/html/page/workflow/ajax_submit.js"}

{literal}
<script language="Javascript" type="text/javascript">
    var G = grn.component.ajax_submit_wf;
    G.commandAutoScheduleURL = {/literal}"{grn_pageurl page='workflow/command_auto_schedule'}"{literal};
    G.petition_id = {/literal}"{$pid}"{literal};
</script>
{/literal}

{if $apply_customization && $view}
    {grn_load_customization_js_css}
{/if}

{include file="grn/footer.tpl"}
