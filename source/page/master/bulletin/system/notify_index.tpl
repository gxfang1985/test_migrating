{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{capture name="tmp"}{$page_title|grn_noescape}({$node.name|grn_noescape}){/capture}
{grn_title title=$smarty.capture.tmp class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/notify_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
<div class="explanation">
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-4' replace='true'}
</div>

<p>
{capture name='grn_bulletin_system_GRN_BLLT_SYS_6'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-6' replace='true'}{/capture}
{capture name='grn_bulletin_system_GRN_BLLT_SYS_7'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-7' replace='true'}{/capture}
{include file='grn/tree_notify_index_26.tpl'
         prop_name=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_6
         prop_code=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_7
         page_prefix='bulletin/system/'}

{include file="grn/system_footer.tpl"}
