{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">

<div class="explanation">
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-89' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-90' replace='true'}
{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-91' replace='true'}
</div>

{capture name='grn_bulletin_system_GRN_BLLT_SYS_92'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-92' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_92}
{capture name='grn_bulletin_system_GRN_BLLT_SYS_93'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-93' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_93}

</form>

{include file='grn/system_footer.tpl'}
