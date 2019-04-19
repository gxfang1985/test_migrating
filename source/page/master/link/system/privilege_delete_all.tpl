{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.link.system' key='GRN_LNK_SY-144' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-145' replace='true'}
{cb_msg module='grn.link.system' key='GRN_LNK_SY-146' replace='true'}
</div>

<p>
{capture name='grn_link_system_GRN_LNK_SY_147'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-147' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_147}
{capture name='grn_link_system_GRN_LNK_SY_148'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-148' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_system_GRN_LNK_SY_148}
</p>
</form>

{include file='grn/system_footer.tpl'}
