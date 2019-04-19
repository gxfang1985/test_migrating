{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/sso/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.sso' key='GRN_SY_SS-18' replace='true'}<span class="bold">{$delete_item.delete_numbers}</span>{cb_msg module='grn.system.sso' key='GRN_SY_SS-19' replace='true'}</p>
 <p>
  {capture name='grn_system_sso_GRN_SY_SS_20'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-20' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_sso_GRN_SY_SS_20}{capture name='grn_system_sso_GRN_SY_SS_21'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-21' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_sso_GRN_SY_SS_21}
 </p>
{foreach from=$delete_item.sso_method item=eid}
 <input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}
