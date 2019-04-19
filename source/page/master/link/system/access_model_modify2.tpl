{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{capture name="grant_caption"}{cb_msg module='grn.link.system' key='GRN_LNK_SY-21' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.link.system' key='GRN_LNK_SY-22' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.link.system' key='GRN_LNK_SY-23' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.link.system' key='GRN_LNK_SY-24' replace='true'}{/capture}

{cb_msg module='grn.link.system' key='GRN_LNK_SY-25' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-26' replace='true'}
{cb_msg module='grn.link.system' key='GRN_LNK_SY-27' replace='true'}<span class="bold">{if $security_model eq 'grant'}{$smarty.capture.grant_caption|grn_noescape}{elseif  $security_model eq 'revoke'}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-28' replace='true'}

<div class="attention">{cb_msg module='grn.link.system' key='GRN_LNK_SY-29' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-30' replace='true'}</div>

</div>

<p>
{capture name='grn_link_system_GRN_LNK_SY_31'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-31' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_31}
{capture name='grn_link_system_GRN_LNK_SY_32'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-32' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_32}
</p>
</form>

{include file='grn/system_footer.tpl'}
