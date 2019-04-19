{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-10' replace='true'}<span class="bold">{$delete_item.delete_numbers}</span>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-11' replace='true'}</p>
 <p>
  {capture name='grn_system_authentication_GRN_SY_AU_12'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-12' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_12}{capture name='grn_system_authentication_GRN_SY_AU_13'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-13' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_13}
 </p>
{foreach from=$delete_item.login_method item=eid}
 <input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}
