{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-630' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.bulletin' key='GRN_BLLT-631' replace='true'}
{cb_msg module='grn.bulletin' key='GRN_BLLT-632' replace='true'}<span class="bold">{$count}</span>{cb_msg module='grn.bulletin' key='GRN_BLLT-633' replace='true'}
</div>

{capture name='grn_bulletin_GRN_BLLT_634'}{cb_msg module='grn.bulletin' key='GRN_BLLT-634' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_634}
{capture name='grn_bulletin_GRN_BLLT_635'}{cb_msg module='grn.bulletin' key='GRN_BLLT-635' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_bulletin_GRN_BLLT_635}

</form>

{include file="grn/footer.tpl"}
