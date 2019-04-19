{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.portal.system' key='GRN_POT_SY-378' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-379' replace='true'}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-380' replace='true'}<span class="bold">{$count}</span> {cb_msg module='grn.portal.system' key='GRN_POT_SY-381' replace='true'} 
</div>

{capture name='grn_portal_system_GRN_POT_SY_382'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-382' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_382}
{capture name='grn_portal_system_GRN_POT_SY_383'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-383' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_system_GRN_POT_SY_383}

</form>

{include file='grn/system_footer.tpl'}
