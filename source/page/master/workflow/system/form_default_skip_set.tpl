{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="psid" value="{$psid|escape}">

<p class="explanation">
{cb_msg module='grn.workflow.system' key='key_155_1' replace='true'}<span class="bold">{$col_role|escape}</span>{cb_msg module='grn.workflow.system' key='key_155_2' replace='true'}<span class="bold">{if GRN_WORKFLOW_CIRCULAR == $col_type}{cb_msg module='grn.workflow.system' key='key_155_3' replace='true'}{else}{cb_msg module='grn.workflow' key="col_acceptance_type_`$col_acceptance_type`"}{/if}</span>{cb_msg module='grn.workflow.system' key='key_155_4' replace='true'}<span class="bold">{cb_msg module='grn.workflow.system' key='key_155_5' replace='true'}</span>{cb_msg module='grn.workflow.system' key='key_155_6' replace='true'}
</p>

{capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
{capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_system_w_no page='workflow/system/form_default_list' poid=$poid cid=$cid fid=$fid psid=$psid}

</form>

{include file='grn/system_footer.tpl'}
