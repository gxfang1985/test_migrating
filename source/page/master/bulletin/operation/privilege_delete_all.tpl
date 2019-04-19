{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">

<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-625' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.bulletin' key='GRN_BLLT-626' replace='true'}
{cb_msg module='grn.bulletin' key='GRN_BLLT-627' replace='true'}
</div>

{capture name='grn_bulletin_GRN_BLLT_628'}{cb_msg module='grn.bulletin' key='GRN_BLLT-628' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_628}
{capture name='grn_bulletin_GRN_BLLT_629'}{cb_msg module='grn.bulletin' key='GRN_BLLT-629' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_bulletin_GRN_BLLT_629}

</form>

{include file="grn/footer.tpl"}