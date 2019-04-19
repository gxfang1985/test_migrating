{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/privilege/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.system.privilege' key='GRN_SY_PR-6' replace='true'}<span class="bold">{$count}</span>{cb_msg module='grn.system.privilege' key='GRN_SY_PR-7' replace='true'}
</div>

<p>
{capture name='grn_system_privilege_GRN_SY_PR_8'}{cb_msg module='grn.system.privilege' key='GRN_SY_PR-8' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_privilege_GRN_SY_PR_8}
{capture name='grn_system_privilege_GRN_SY_PR_9'}{cb_msg module='grn.system.privilege' key='GRN_SY_PR-9' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_privilege_GRN_SY_PR_9}
</p>
</form>

{include file='grn/system_footer.tpl'}
