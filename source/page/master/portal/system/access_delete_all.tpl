{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{if 'portal' == $node.type}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-50' replace='true'}<span class="bold">{grn_image image='portal20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-51' replace='true'}
{else}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-52' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-53' replace='true'}
{/if}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-54' replace='true'}
</div>

{capture name='grn_portal_system_GRN_POT_SY_55'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-55' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_55}
{capture name='grn_portal_system_GRN_POT_SY_56'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-56' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_system_GRN_POT_SY_56}

{foreach from=$ours_params key=key item=item}
<input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}
</form>

{include file='grn/system_footer.tpl'}
