{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-12' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-13' replace='true'}
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-14' replace='true'}<span class="bold">{$count}</span>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-15' replace='true'}
</div>

{capture name='grn_bulletin_system_GRN_BLLT_SYS_16'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-16' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_16}
{capture name='grn_bulletin_system_GRN_BLLT_SYS_17'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-17' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_17}

</form>

{include file='grn/system_footer.tpl'}
