{assign var="is_print_page" value=true}
{capture name="print_page_name"}{grn_appname app_id='workflow'} {cb_msg module='grn.workflow.system' key='petition_print' replace='true'}{/capture}
{assign var="page_title" value=$smarty.capture.print_page_name}
{include file="grn/head.tpl"}
{grn_load_javascript file="grn/html/component/ajax/error_default_view.js"}

<script language="JavaScript" type="text/javascript">
<!--
{literal}
function setAlign(value)
{
    jQuery(".view_table_for_print table td").each( function() {
        jQuery(this).toggleClass("align_table");
    });
}
function onPrint(form)
{
    form.cmd.value = "print";
}
{/literal}
// -->
</script>
<style type="text/css">
<!--
{literal}
.align_table {
  width:110px !important;
}
{/literal}

{if $cmd == "print"}{literal}
#view {
  font-size:{/literal}{$font_size}{literal};
}
{/literal}{/if}

{if $cmd == "print" && $align_items}{literal}
.view_table_for_print table td{
  width:110px;
}
{/literal}{/if}
-->
</style>
<body bgcolor="#ffffff" link="#000000" vlink="#000000" topmargin="0" marginheight="0"{if 'print' == $cmd} onLoad="window.print();"{/if} class="print_body_grn">
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/petition_print'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="div_print_setting">
    {if 'print' != $cmd}
        <table class="table_plain_grn print_action_base_grn">
            <tr>
                <td nowrap>
                    <table border="0" cellspacing="0" cellpadding="4" width="100%">
                        <tr>
                            <td nowrap>
                                <font size="+1">{cb_msg module='grn.workflow' key='print_setting' replace='true'}</font>
                                <font size="-1">{cb_msg module='grn.workflow.system' key='w_notprint_area' replace='true'}</font>
                            </td>
                        </tr>
                    </table>
                    <br>
                    <table border="0" cellspacing="0" cellpadding="4">
                        <tr valign="top">
                            <td nowrap>{cb_msg module='grn.workflow.system' key='w_char_size_y' replace='true'}</td>
                            <td nowrap>&nbsp;:&nbsp;</td>
                            <td nowrap>
                                <select name="font_size" onChange="setFontSize(this.value);">
                                    {html_options options=$font_sizes selected='12pt'}
                                </select>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td nowrap>{cb_msg module='grn.workflow.system' key='w_cells_width_y' replace='true'}</td>
                            <td nowrap>&nbsp;:&nbsp;</td>
                            <td nowrap>
                                {capture name='grn_workflow_system_w_align_y'}{cb_msg module='grn.workflow.system' key='w_align_y' replace='true'}{/capture}{grn_checkbox id="align_items" name="align_items" value="1" checked=$align_items caption=$smarty.capture.grn_workflow_system_w_align_y onclick="setAlign(this.value);"}
                            </td>
                        </tr>
                        <tr>
                            <td align="right">{cb_msg module="grn.workflow" key="LOCALE_SETTING" replace="true"}</td>
                            <td nowrap>&nbsp;:&nbsp;</td>
                            <td>
                                <select onchange="setLocale(this.value)" id="Locale" name="locale">
                                    <option value="user">{cb_msg module="grn.workflow" key="USER_SETTING" replace="true"}</option>
                                    <option value="system">{cb_msg module="grn.workflow" key="SYSTEM_SETTING" replace="true"}</option>
                                </select>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td nowrap>
                                {strip}
                                    <div class="mTop10 mBottom5">
                                        {capture name='grn_workflow_system_w_print'}{cb_msg module='grn.workflow.system' key='w_print' replace='true'}{/capture}
                                        {grn_button id='' action="submit" ui="main" spacing="normal" caption=$smarty.capture.grn_workflow_system_w_print onclick="onPrint(document.forms['`$form_name`']); document.forms['`$form_name`'].submit();"}
                                        {capture name='grn_workflow_system_w_back_y'}{cb_msg module='grn.workflow.system' key='w_back_y' replace='true'}{/capture}
                                        {grn_button id='' action="cancel" page='workflow/system/petition_view' page_param_cid=$category_id page_param_fid=$form_id page_param_pid=$petition_id page_param_sf=1 caption=$smarty.capture.grn_workflow_system_w_back_y}
                                    </div>
                                {/strip}
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    {/if}
</div>
<div id="view">
    <p>
        {if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if}
        <span class="wf_petition_title">{$petition.form_name|escape}{grn_msg_switch module='grn.workflow' key='w_bracket_left' locale=$locale}{$petition.name|escape}{grn_msg_switch module='grn.workflow' key='w_bracket_right' locale=$locale}</span>
    </p>

        <p></p>
        <span class="table_title_for_print">{grn_msg_switch module='grn.workflow' key='w_application_contents_y' locale=$locale}</span>
        <table class="view_table_for_print" style="border-collapse:collapse;font-size:100%;">
            <tr>
                <th class="border">{grn_msg_switch module='grn.workflow' key='w_applicant_y' locale=$locale}</th>
                <td class="border">
                    <table>
                        <tr>
                            <td>
                                <span class="no-wrap">
                                    {if $petition.agent_user || $petition.agent_user_name}
                                        {grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid noimage=true nolink=true}
                                        {grn_msg_switch module='grn.workflow' key='w_substitute_applicant' locale=$locale}{grn_user_name uid=$petition.agent_user name=$petition.agent_user_name  valid=$petition.agent_user_valid noimage=true nolink=true}{grn_msg_switch module='grn.workflow' key='w_bracket_right' locale=$locale}
                                    {else}
                                        {grn_user_name uid=$petition.user name=$petition.user_name valid=$petition.user_valid noimage=true nolink=true}
                                    {/if}
                                </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <th class="border">{grn_msg_switch module='grn.workflow' key='w_application_date_y' locale=$locale}</th>
                <td class="border">
                    <table>
                        <tr>
                            <td><span class="no-wrap">{grn_date_format_switch format='DateTimeMiddle_YMDW_HM' date=$petition.ctime locale=$locale}</span></td>
                        </tr>
                    </table>
                </td>
            </tr>
<!-- start item section -->
            {foreach from=$item_data_list item=item_data_line}
                {if $item_data_line.type == 2}
                    <tr>
                        <td colspan="2"><div class="view_table_for_print_emptyline"></div></td>
                    </tr>
                {elseif $item_data_line.type == 3}
                    <tr valign="top">
                        <td colspan="2" class="border">
                            {if $item_data_line.sub_item_data_count == 0}
                                <div id="js_customization_item_{$item_data_line.code}"></div>
                            {else}
                                <table width="100%">
                                    <tr>
                                        {assign var='item_class' value=''}
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
                    <tr>
                        {if $item_data_line.type != 3}
                            <th class="border">{$item_data_line.display_name|escape}</th>
                        {/if}
                        {if $item_data_line.sub_item_data_count == 0}
                            {assign var='item_class' value='border'}
                            {grn_workflow_include_item category_id=$category_id folder_id=$foler_id petition_id=$petition_id iid=$item_data_line.iid item=$item_data_line display="view-system"}
                        {else}
                            <td class="border">
                                {if $item_data_line.right_align_flag == 1}
                                    <table class="layout-border-none-full-width">
                                {else}
                                    <table width="100%">
                                {/if}
                                <tr>
                                    {assign var='item_class' value=''}
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

        <br>
        <span class="table_title_for_print">{grn_msg_switch module='grn.workflow' key='w_progress_state_y' locale=$locale}</span>
        {if $simple}
            <table class="path_table_for_print" border="2" bordercolor="#000000" style="border-collapse:collapse;font-size:100%;">
                <colgroup>
                    <col width="10%">
                    <col width="85%">
                    <col width="5%">
                </colgroup>
                <tr>
                    <th nowrap>{grn_msg_switch module='grn.workflow' key='w_route_type_y' locale=$locale}</th>
                    <th nowrap>{grn_msg_switch module='grn.workflow' key='w_pathway_step' locale=$locale}</th>
                    <th nowrap>{grn_msg_switch module='grn.workflow' key='w_result_datetime_processor_y' locale=$locale}</th>
                </tr>
                {assign var=not_first value=true}
                {foreach name=path_step from=$path_steps item=path_step}
                    {if $path_step.col_activate}
                        <tr>
                            {* 経路種別 *}
                            {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                                <td nowrap>{grn_msg_switch module='grn.workflow' key='w_circular' locale=$locale}</td>
                            {else}
                                {if $path_step.last_acceptance}
                                    <td class="last_decision" nowrap><span class="kind">{grn_msg_switch module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`" locale=$locale}</span></td>
                                {else}
                                    <td nowrap>{grn_msg_switch module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`" locale=$locale}</td>
                                {/if}
                            {/if}
                            {* 経路ステップ名 *}
                            <td>{$path_step.col_role|escape}</td>
                            {* 処理者/結果/コメント/日時 *}
                            {if $not_first}
                                {assign var=not_first value=false}
                                <td rowspan="{$path_step_total|escape}" valign="middle" align="center" nowrap>
                                    <small>{grn_msg_switch module='grn.workflow' key='w_bracket_omit_y' locale=$locale}</small>
                                </td>
                            {/if}
                        </tr>
                    {/if}
                {/foreach}
            </table>
        {else}
            <table class="path_table_for_print" border="2" bordercolor="#000000" style="border-collapse:collapse;font-size:100%;">
                <colgroup>
                    <col width="10%">
                    <col width="20%">
                    <col width="5%">
                    <col width="15%">
                    <col width="50%">
                </colgroup>
                <tr>
                    <th nowrap>{grn_msg_switch module='grn.workflow' key='w_route_type_y' locale=$locale}</th>
                    <th nowrap>{grn_msg_switch module='grn.workflow' key='w_pathway_step' locale=$locale}</th>
                    <th nowrap>{grn_msg_switch module='grn.workflow' key='w_result_y' locale=$locale}</th>
                    <th nowrap>{grn_msg_switch module='grn.workflow' key='w_date_and_time_y' locale=$locale}</th>
                    <th nowrap>{grn_msg_switch module='grn.workflow' key='w_processor_comment_y' locale=$locale}</th>
                </tr>
                {foreach name=path_step from=$path_steps item=path_step}
                    {if $path_step.col_activate}
                        {if ! $path_step.col_skip || 0 < $path_step.user_count}
                            {assign var=not_first value=true}
                            {foreach name=user from=$path_step.users item=user}
                                <tr>
                                    {if $not_first}
                                        {assign var=not_first value=false}
                                        {* 経路種別 *}
                                        {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                                            <td rowspan="{$path_step.user_count|escape}" nowrap>{grn_msg_switch module='grn.workflow' key='w_circular' locale=$locale}</td>
                                        {else}
                                            {if $path_step.last_acceptance}
                                                <td class="last_decision" rowspan="{$path_step.user_count|escape}" nowrap><span class="kind">{grn_msg_switch module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`" locale=$locale}</span></td>
                                            {else}
                                                <td rowspan="{$path_step.user_count|escape}" nowrap>{grn_msg_switch module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`" locale=$locale}</td>
                                            {/if}
                                        {/if}
                                        {* 経路ステップ名 *}
                                        <td rowspan="{$path_step.user_count|escape}">{$path_step.col_role|escape}</td>
                                    {/if}
                                    {* 結果 *}
                                    <td class="tAlignCenter-grn" nowrap>
                                        {if $path_step.last_acceptance}
                                            <span class="result">{grn_msg_switch module='grn.workflow' key="col_result_`$user.col_result`" locale=$locale}</span>
                                        {else}
                                            {grn_msg_switch module='grn.workflow' key="col_result_`$user.col_result`" locale=$locale}
                                        {/if}
                                    </td>
                                    {* 日時 *}
                                    <td nowrap>{if GRN_WORKFLOW_RESULT_UNPROCESSING != $user.col_result}{grn_date_format_switch format='DateLong_YMDW' date=$user.col_ptime locale=$locale}<br>{grn_date_format_switch format='TimeLong_HM' date=$user.col_ptime locale=$locale}{/if}</td>
                                    {* 処理者 *}
                                    <td class="wfRouteHistoryUserComment-grn">
                                        <div class="wfRouteHistory-grn">
                                            <span class="wfRouteHistoryUser-grn">
                                                {if $user.col_agent_user || $user.col_agent_display_name}
                                                    {grn_user_name uid=$user._id name=$user.col_display_name noimage=true nolink=true}
                                                    {grn_msg_switch module='grn.workflow' key='w_substitute_approver' locale=$locale}{grn_user_name uid=$user._agent_id name=$user.col_agent_display_name  noimage=true nolink=true}{grn_msg_switch module='grn.workflow' key='w_bracket_right' locale=$locale}
                                                {else}
                                                    {grn_user_name uid=$user._id name=$user.col_display_name noimage=true nolink=true}
                                                {/if}
                                            </span>
                                            {* コメント *}
                                            <div class="wfRouteHistoryComment-grn">{grn_format span_mode=true body=$user.col_comment.current nolink=true}</div>
                                            {if 0 < $user.col_comment.log_total}
                                                {foreach from=$user.col_comment.logs item=log}
                                                    <div class="wfRouteHistoryTitle-grn">
                                                        <div class="wfRouteHistoryCommentAction-grn">
                                                            <span class="nowrap-grn">
                                                                {grn_msg_switch module='grn.workflow' key="col_result_`$log.col_result`" locale=$locale}
                                                                {if $log.col_agent}
                                                                    {grn_msg_switch module='grn.workflow' key='w_substitute_approver' locale=$locale}{grn_user_name uid=$log.col_agent name=$log.col_agent_name noimage=true nolink=true}{grn_msg_switch module='grn.workflow' key='w_bracket_right' locale=$locale}
                                                                {/if}
                                                                {if GRN_WORKFLOW_RESULT_REMAND == $log.col_result}
                                                                    {if 'applicant' == $log.destination}
                                                                        {grn_msg_switch module='grn.workflow' key='w_bracket_arrow_right_applicant' locale=$locale}
                                                                    {else}
                                                                        {assign var='destination' value=$log.destination}
                                                                        {grn_msg_switch module='grn.workflow' key='w_bracket_arrow_right' locale=$locale}{$path_steps.$destination.col_role|escape}{grn_msg_switch module='grn.workflow' key='w_bracket_right' locale=$locale}
                                                                    {/if}
                                                                {/if}
                                                            </span>
                                                            <span class="wfRouteHistoryCommentDate-grn">
                                                                {grn_date_format_switch format='DateTimeMiddle_YMDW_HM' date=$log.col_ptime locale=$locale}
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="wfRouteHistoryComment-grn">{grn_format span_mode=true body=$log.col_comment nolink=true}</div>
                                                {/foreach}
                                            {/if}
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}
                        {else}
                            {* （省略） *}
                            <tr>
                                {* 経路種別 *}
                                <td nowrap>
                                    {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
                                        {grn_msg_switch module='grn.workflow' key='w_circular' locale=$locale}
                                    {else}
                                        {grn_msg_switch module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`" locale=$locale}
                                    {/if}
                                </td>
                                {* 経路ステップ名 *}
                                <td>{$path_step.col_role|escape}</td>
                                {* 結果 *}
                                <td nowrap>{grn_msg_switch module='grn.workflow' key='skip_result' locale=$locale}</td>
                                {* 日時 *}
                                <td nowrap>&nbsp;</td>
                                {* 処理者&コメント *}
                                <td class="wfRouteHistoryUserComment-grn" nowrap>{grn_msg_switch module='grn.workflow' key='skip' locale=$locale}</td>
                            </tr>
                        {/if}
                    {/if}
                {/foreach}
            </table>
        {/if}
    <input type="hidden" name="cid" value="{$category_id|escape}">
    <input type="hidden" name="fid" value="{$form_id|escape}">
    <input type="hidden" name="pid" value="{$petition_id|escape}">
    <input type="hidden" name="cmd" value="">
    <div id="timezone-name"><span id="timezone-name-title">{grn_msg_switch module='grn.workflow' key='TIMEZONE' locale=$locale}</span><span id="timezone-name-data">{grn_msg_switch module='fw.timezone' key=$timezone_name locale=$locale}</span></div>
</div>
</form>

{if $apply_customization}
    {grn_load_customization_js_css}
{/if}

</body>
</html>
