{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">
{foreach from=$ours_params key=key item=item}
<input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}

{capture name="grant_caption"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-21' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-22' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-23' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-24' replace='true'}{/capture}

<div class="explanation">
{if 'portal' == $node.type}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-25' replace='true'}<span class="bold">{grn_image image='portal20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-26' replace='true'}
{else}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-27' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-28' replace='true'}
{/if}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-29' replace='true'}<span class="bold">{if $security_model eq 'grant'}{$smarty.capture.grant_caption|grn_noescape}{elseif  $security_model eq 'revoke'}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-30' replace='true'}

<div class="attention">{cb_msg module='grn.portal.system' key='GRN_POT_SY-31' replace='true'}
{if 'portal' == $node.type}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-32' replace='true'}<span class="bold">{grn_image image='portal20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-33' replace='true'}
{else}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-34' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-35' replace='true'}
{/if}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-36' replace='true'}</div>
</div>

{capture name='grn_portal_system_GRN_POT_SY_37'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-37' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_37}
{capture name='grn_portal_system_GRN_POT_SY_38'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-38' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_38}

</form>

{include file='grn/system_footer.tpl'}
