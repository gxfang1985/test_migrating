{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<script lang="javascript" type="text/javascript" src="{$app_path}/grn/html/wf_select_date.js?{$build_date}"></script>
{literal}
<script language="JavaScript" type="text/javascript">
<!--
var wday_name = new Array("{/literal}{cb_msg module='fw.date' key='WDayShort0'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort1'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort2'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort3'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort4'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort5'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort6'}{literal}");
var date_day_unit = '{/literal}{cb_msg module='fw.ui' key='date_day_unit'}{literal}';
var date_year_unit = '{/literal}{cb_msg module='fw.ui' key='date_year_unit'}{literal}';
//-->
</script>
{/literal}
{include file='grn/show_validation_errors.tpl'}
{include file="grn/indispensable.tpl"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <colgroup>
  <col style="width:15em">
 </colgroup>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_change_year_of_app_number_y'}{cb_msg module='grn.workflow.system' key='w_change_year_of_app_number_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_change_year_of_app_number_y}</th>
  <td>
   {grn_workflow_select_date form_name=$form_name date=$cutover necessary=false no_calendar=false date_order='nj' onchange="grn_workflow_select_date_init_day(this.form, '', true, true, this, '$locale');"}&nbsp;{grn_select_time prefix='' time=$cutover minute_interval=$set.unit use_24_hours=true}
    {if !is_null($cutover_UTC)}
    <span class="bold"> &nbsp;UTC : {$cutover_UTC.month}/{$cutover_UTC.day}  {$cutover_UTC.hour}:{$cutover_UTC.minute}</span>
    <div class="br">&nbsp;</div>
    <div class="sub_explanation"><span class="bold"> &nbsp;{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-99' replace='true'}</span></div>
    <div class="br">&nbsp;</div>
    <div class="sub_explanation"><span class="bold"> &nbsp;{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-100' replace='true'} &nbsp;{$default_timezone} &nbsp; {$cutover_default.month}/{$cutover_default.day}  {$cutover_default.hour}:{$cutover_default.minute}</span>
    </div>
    
  {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_allow_turn_down_y'}{cb_msg module='grn.workflow.system' key='w_allow_turn_down_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_allow_turn_down_y}</th>
  <td>
{if $remand}
{assign var='allow' value=true}
{assign var='deny' value=false}
{else}
{assign var='allow' value=false}
{assign var='deny' value=true}
{/if}
   {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='remand' id='allow_remand' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow}
   {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='remand' id='deny_renamd' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{capture name='grn_workflow_system_w_do_allow_change_route_by_applicant_y'}{cb_msg module='grn.workflow.system' key='w_do_allow_change_route_by_applicant_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_do_allow_change_route_by_applicant_y}</th>
  <td>
{if $change_path_info.applicant || $applicant}
{assign var='allow' value=true}
{assign var='deny' value=false}
{else}
{assign var='allow' value=false}
{assign var='deny' value=true}
{/if}
   {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='applicant' id='allow_applicant' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow}
   {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='applicant' id='deny_applicant' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{capture name='grn_workflow_system_w_permit_operations_management_change_pathway'}{cb_msg module='grn.workflow.system' key='w_permit_operations_management_change_pathway' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_permit_operations_management_change_pathway}</th>
  <td>
{if $change_path_info.operation_admin || $operation_admin}
{assign var='allow' value=true}
{assign var='deny' value=false}
{else}
{assign var='allow' value=false}
{assign var='deny' value=true}
{/if}
   {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='operation_admin' id='allow_operation_admin' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow}
   {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='operation_admin' id='deny_operation_admin' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{capture name='grn_workflow_system_w_permit_system_administrator_changing_pathway'}{cb_msg module='grn.workflow.system' key='w_permit_system_administrator_changing_pathway' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_permit_system_administrator_changing_pathway}</th>
  <td>
{if $change_path_info.system_admin || $system_admin}
{assign var='allow' value=true}
{assign var='deny' value=false}
{else}
{assign var='allow' value=false}
{assign var='deny' value=true}
{/if}
   {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='system_admin' id='allow_system_admin' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow}
   {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='system_admin' id='deny_system_admin' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{capture name='grn_workflow_system_w_allow_use_pending_approval_y'}{cb_msg module='grn.workflow.system' key='w_allow_use_pending_approval_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_allow_use_pending_approval_y}</th>
  <td>
{if $approval_plan}
{assign var='allow' value=true}
{assign var='deny' value=false}
{else}
{assign var='allow' value=false}
{assign var='deny' value=true}
{/if}
   {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='approval_plan' id='allow_approval_plan' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow}
   {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='approval_plan' id='deny_approval_plan' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{capture name='grn_workflow_system_w_allow_apply_on_behalf_of_y'}{cb_msg module='grn.workflow.system' key='w_allow_apply_on_behalf_of_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_allow_apply_on_behalf_of_y}</th>
  <td>
{if $substitute_application}
{assign var='allow' value=true}
{assign var='deny' value=false}
{else}
{assign var='allow' value=false}
{assign var='deny' value=true}
{/if}
   {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='substitute_application' id='allow_substitute_application' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow}
   {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='substitute_application' id='deny_substitute_application' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{capture name='grn_workflow_system_w_allow_approve_on_behalf_of__y'}{cb_msg module='grn.workflow.system' key='w_allow_approve_on_behalf_of__y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_allow_approve_on_behalf_of__y}</th>
  <td>
{if $substitute_approval}
{assign var='allow' value=true}
{assign var='deny' value=false}
{else}
{assign var='allow' value=false}
{assign var='deny' value=true}
{/if}
   {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='substitute_approval' id='allow_substitute_approval' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow}
   {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='substitute_approval' id='deny_substitute_approval' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{capture name='grn_workflow_system_w_permit_user_setting_substitute'}{cb_msg module='grn.workflow.system' key='w_permit_user_setting_substitute' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_permit_user_setting_substitute}</th>
  <td>
{if $personal_agent_setting}
{assign var='allow' value=true}
{assign var='deny' value=false}
{else}
{assign var='allow' value=false}
{assign var='deny' value=true}
{/if}
   {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='personal_agent_setting' id='allow_personal_agent_setting' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow}
   {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='personal_agent_setting' id='deny_personal_agent_setting' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny}
  </td>
 </tr>
 <tr>
    <th nowrap>{capture name='grn_workflow_system_allow_email_notification_x'}{cb_msg module='grn.workflow.system' key='allow_email_notification_x' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_allow_email_notification_x}</th>
    <td>
{if $mail_notification}
{assign var='allow' value=true}
{assign var='deny' value=false}
{else}
{assign var='allow' value=false}
{assign var='deny' value=true}
{/if}
   {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='mail_notification' id='allow_mail_notification' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow onclick="this.form.mail_notification_url.disabled=false;"}
   {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='mail_notification' id='deny_mail_notification' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny onclick="this.form.mail_notification_url.disabled=true;"}
   <div class="br">&nbsp;</div>
  {capture name='grn_workflow_system_product_url_required'}{cb_msg module='grn.workflow.system' key='product_url_required' replace='true'}{/capture}{validate form=$form_name field="mail_notification_url" criteria="notEmpty" message=$smarty.capture.grn_workflow_system_product_url_required transform="trim" append="validation_errors"}
  {capture name='grn_workflow_system_product_url_invalid'}{cb_msg module='grn.workflow.system' key='product_url_invalid' replace='true'}{/capture}{validate form=$form_name field="mail_notification_url" criteria="grn_isURL" message=$smarty.capture.grn_workflow_system_product_url_invalid transform="trim" append="validation_errors"}
  {capture name='grn_workflow_system_product_url'}{cb_msg module='grn.workflow.system' key='product_url' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_product_url necessary=true}{grn_text necessary=true name="mail_notification_url" id="mail_notification_url" value=$mail_notification_url size=100 maxlength="255" disable_return_key=true disabled=$deny}<br>
   <div class="sub_explanation">{cb_msg module='grn.workflow.system' key='ex_url' replace='true'}&nbsp;<b>{$sample_url|escape}</b></div>
   <div class="sub_explanation">{cb_msg module='grn.workflow.system' key='show_link_on_notification' replace='true'}</div>
  </td>
 </tr>
{if $smarty.const.ON_FOREST !== 1}
 <tr>
   <th nowrap valign="top">{capture name='grn_workflow_system_automatic_export_encoding'}{cb_msg module='grn.workflow.system' key='automatic_export_encoding' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_automatic_export_encoding}</th>
   <td>{grn_charset name='charset' default=$automatic_export_encoding}</td>
 </tr>
{/if}
    <tr>
        <th nowrap
            valign="top">{capture name='grn_workflow_system_w_permit_js_css_customization_setting'}{cb_msg module='grn.workflow.system' key='w_permit_jss_css_customization_setting' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_permit_js_css_customization_setting}</th>
        <td>
            {if $js_css_customization_setting}
                {assign var='allow' value=true}
                {assign var='deny' value=false}
            {else}
                {assign var='allow' value=false}
                {assign var='deny' value=true}
            {/if}
            {capture name='grn_workflow_system_w_permit'}{cb_msg module='grn.workflow.system' key='w_permit' replace='true'}{/capture}{grn_radio name='js_css_customization_setting' id='allow_js_css_customization_setting' value='1' caption=$smarty.capture.grn_workflow_system_w_permit checked=$allow}
            {capture name='grn_workflow_system_w_not_permit'}{cb_msg module='grn.workflow.system' key='w_not_permit' replace='true'}{/capture}{grn_radio name='js_css_customization_setting' id='deny_js_css_customization_setting' value='0' caption=$smarty.capture.grn_workflow_system_w_not_permit checked=$deny}
        </td>
    </tr>
 <tr>
  <td></td>
  <td>
   <input class="margin" type="submit" name="modify" value="{cb_msg module='grn.workflow.system' key='w_do_apply_y' replace='true'}">
   {grn_button_cancel}
  </td>
 </tr>
</table>
</form>
{include file='grn/system_footer.tpl'}
