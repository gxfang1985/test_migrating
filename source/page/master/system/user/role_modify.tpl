{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <input type="hidden" name="role_id" value="{$role.rid|escape}">

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
<tr valign="top">
<th>{capture name='grn_system_user_GRN_SY_US_614'}{cb_msg module='grn.system.user' key='GRN_SY_US-614' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_614 necessary=TRUE}</th>
<td>{capture name='grn_system_user_GRN_SY_US_615'}{cb_msg module='grn.system.user' key='GRN_SY_US-615' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_615 append="validation_errors"}{grn_text necessary=true name="title" value=$role.title size="50" disable_return_key=true}
 <div class="margin_top">
  <span class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-616' replace='true'}</span>
 </div>
</td>
</tr>
<tr valign="top">
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-617' replace='true'}</th>
<td>{grn_textarea name="memo" value=$role.memo rows="5"}</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_system_user_GRN_SY_US_618'}{cb_msg module='grn.system.user' key='GRN_SY_US-618' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_618}
{grn_button_cancel page='system/user/role_view' role_id=$role.rid}
</td>
</tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
