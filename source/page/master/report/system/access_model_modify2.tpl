{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{capture name="grant_caption"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-474' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-475' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-476' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-477' replace='true'}{/capture}

{cb_msg module='grn.report.system' key='GRN_RPRT_SY-478' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-479' replace='true'}
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-480' replace='true'}<span class="bold">{if $security_model eq 'grant'}{$smarty.capture.grant_caption|grn_noescape}{elseif  $security_model eq 'revoke'}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-481' replace='true'}

<div class="attention">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-482' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-483' replace='true'}</div>

</div>

<p>
{capture name='grn_report_system_GRN_RPRT_SY_484'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-484' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_484}
{capture name='grn_report_system_GRN_RPRT_SY_485'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-485' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_485}
</p>
</form>

{include file='grn/system_footer.tpl'}
