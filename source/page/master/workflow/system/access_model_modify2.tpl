{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{capture name="grant_caption"}{cb_msg module='grn.workflow.system' key='w_grant' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.workflow.system' key='w_revoke' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}{/capture}

{cb_msg module='grn.workflow.system' key='key_145_1' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.workflow.system' key='key_145_2' replace='true'}
{cb_msg module='grn.workflow.system' key='key_145_3' replace='true'}<span class="bold">{if $security_model eq 'grant'}{$smarty.capture.grant_caption|grn_noescape}{elseif  $security_model eq 'revoke'}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.workflow.system' key='key_145_4' replace='true'}

<div class="attention">{cb_msg module='grn.workflow.system' key='key_146_1' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.workflow.system' key='key_146_2' replace='true'}</div>

</div>

<p>
{capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
{capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_workflow_system_w_no}
</p>
</form>

{include file='grn/system_footer.tpl'}
