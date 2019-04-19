{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}">
 <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{foreach from=$eid_list item=uid}
 <input type="hidden" name="eid[]" value="{$uid}">
{/foreach}
 <p>{cb_msg module='grn.system.user' key='GRN_SY_US-491' replace='true'}<span class="bold">{$eid_list|@count}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-492' replace='true'}</p>
 <p>{cb_msg module='grn.system.user' key='GRN_SY_US-493' replace='true'}</p>
 <p>
  {capture name='grn_system_user_GRN_SY_US_494'}{cb_msg module='grn.system.user' key='GRN_SY_US-494' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_494}
  {capture name='grn_system_user_GRN_SY_US_495'}{cb_msg module='grn.system.user' key='GRN_SY_US-495' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_user_GRN_SY_US_495}
 </p>
</form>

{include file="grn/system_footer.tpl"}
