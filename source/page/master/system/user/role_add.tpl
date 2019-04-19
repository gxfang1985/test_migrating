{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
 <div class="explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-531' replace='true'}</div>
</p>
<input type="hidden" name="role_id" value="{$role_id|escape}">

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
<tr valign="top">
<th>{capture name='grn_system_user_GRN_SY_US_532'}{cb_msg module='grn.system.user' key='GRN_SY_US-532' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_user_GRN_SY_US_532 necessary=TRUE}</th>
<td>{capture name='grn_system_user_GRN_SY_US_533'}{cb_msg module='grn.system.user' key='GRN_SY_US-533' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_system_user_GRN_SY_US_533 append="validation_errors"}{grn_text necessary=true name="title" value=$title size="50" disable_return_key=true}
 <div class="margin_top">
  <span class="sub_explanation">{cb_msg module='grn.system.user' key='GRN_SY_US-534' replace='true'}</span>
 </div>
</td>
</tr>
<tr valign="top">
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-535' replace='true'}</th>
<td>{grn_textarea name="memo" value=$memo rows="5"}</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_system_user_GRN_SY_US_536'}{cb_msg module='grn.system.user' key='GRN_SY_US-536' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_536 id="system-role-add-submit"}
{grn_button_cancel page='system/user/role_list' role_id=$role_id sf=1 id="system-role-add-cancel"}
</td>
</tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
