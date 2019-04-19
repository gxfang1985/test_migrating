{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.user' key='GRN_SY_US-10' replace='true'}
<div class="attention">{cb_msg module='grn.system.user' key='GRN_SY_US-11' replace='true'}<br>{cb_msg module='grn.system.user' key='GRN_SY_US-12' replace='true'}</div>
</p>
 <p>
  {capture name='grn_system_user_GRN_SY_US_13'}{cb_msg module='grn.system.user' key='GRN_SY_US-13' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_13}
  {capture name='grn_system_user_GRN_SY_US_14'}{cb_msg module='grn.system.user' key='GRN_SY_US-14' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_user_GRN_SY_US_14}
 </p>
</form>
{include file="grn/system_footer.tpl"}
