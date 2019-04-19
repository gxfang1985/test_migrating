{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{if ! $privilege_info.count}
 <p>
{cb_msg module='grn.system.user' key='GRN_SY_US-607' replace='true'}
</p>
 <p>
  {capture name='grn_system_user_GRN_SY_US_608'}{cb_msg module='grn.system.user' key='GRN_SY_US-608' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_system_user_GRN_SY_US_608}
 </p>
{else}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.user' key='GRN_SY_US-609' replace='true'}<span class="bold">{grn_image image='organize20.gif'}{$node.name|escape:"html"}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-610' replace='true'}<span class="bold">{$privilege_info.count}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-611' replace='true'}</p>
 <p>
  {capture name='grn_system_user_GRN_SY_US_612'}{cb_msg module='grn.system.user' key='GRN_SY_US-612' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_612}
  {capture name='grn_system_user_GRN_SY_US_613'}{cb_msg module='grn.system.user' key='GRN_SY_US-613' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_user_GRN_SY_US_613}
 </p>
 {foreach from=$privilege_info.list item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
 {/foreach}
<input type="hidden" name="oid" value="{$node.id}">
<input type="hidden" name="poid" value="{$poid|escape}">

</form>
{/if}
{include file="grn/system_footer.tpl"}
