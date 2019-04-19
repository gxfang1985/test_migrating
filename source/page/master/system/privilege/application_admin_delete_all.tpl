{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/privilege/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.system.privilege' key='GRN_SY_PR-1' replace='true'}
</div>

<p>
{capture name='grn_system_privilege_GRN_SY_PR_2'}{cb_msg module='grn.system.privilege' key='GRN_SY_PR-2' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_privilege_GRN_SY_PR_2}
{capture name='grn_system_privilege_GRN_SY_PR_3'}{cb_msg module='grn.system.privilege' key='GRN_SY_PR-3' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_privilege_GRN_SY_PR_3}
</p>

</form>

{include file='grn/system_footer.tpl'}
