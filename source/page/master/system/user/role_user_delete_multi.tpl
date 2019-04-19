{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.user' key='GRN_SY_US-543' replace='true'}<span class="bold">{grn_image image='role20.gif'}{grn_role_name rid=$role_id}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-544' replace='true'}<span class="bold">{$users.total_count|escape}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-545' replace='true'}</p>
 <p>
  {capture name='grn_system_user_GRN_SY_US_546'}{cb_msg module='grn.system.user' key='GRN_SY_US-546' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_546}
  {capture name='grn_system_user_GRN_SY_US_547'}{cb_msg module='grn.system.user' key='GRN_SY_US-547' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_user_GRN_SY_US_547}
 </p>
 <input type="hidden" name="role_id" value="{$role_id}">
{foreach from=$users.uids item=uid}
 <input type="hidden" name="eid[]" value="{$uid}">
{/foreach}
</form>
{include file="grn/system_footer.tpl"}
