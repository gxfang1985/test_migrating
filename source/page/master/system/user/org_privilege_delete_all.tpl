{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.user' key='GRN_SY_US-15' replace='true'}<span class="bold">{grn_image image='organize20.gif'}{$node.name|escape:"html"}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-16' replace='true'}</p>
 <p>
  {capture name='grn_system_user_GRN_SY_US_17'}{cb_msg module='grn.system.user' key='GRN_SY_US-17' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_17}
  {capture name='grn_system_user_GRN_SY_US_18'}{cb_msg module='grn.system.user' key='GRN_SY_US-18' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_user_GRN_SY_US_18}
 </p>
<input type="hidden" name="oid" value="{$node.id}">
<input type="hidden" name="poid" value="{$poid|escape}">
</form>
{include file="grn/system_footer.tpl"}
