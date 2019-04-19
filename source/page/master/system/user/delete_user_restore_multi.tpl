{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}">
 <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$eid_list item=uid}
 <input type="hidden" name="eid[]" value="{$uid}">
{/foreach}
 <p>{cb_msg module='grn.system.user' key='GRN_SY_US-291' replace='true'}<span class="bold">{$eid_list|@count}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-292' replace='true'}</p>
 <p>
  {capture name='grn_system_user_GRN_SY_US_293'}{cb_msg module='grn.system.user' key='GRN_SY_US-293' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_293}
  {capture name='grn_system_user_GRN_SY_US_294'}{cb_msg module='grn.system.user' key='GRN_SY_US-294' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_user_GRN_SY_US_294}
 </p>
</form>

{include file="grn/system_footer.tpl"}
