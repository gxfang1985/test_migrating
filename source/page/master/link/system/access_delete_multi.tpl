{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.link.system' key='GRN_LNK_SY-47' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-48' replace='true'}
{cb_msg module='grn.link.system' key='GRN_LNK_SY-49' replace='true'}<span class="bold">{$count}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-50' replace='true'}
</div>

<p>
{capture name='grn_link_system_GRN_LNK_SY_51'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-51' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_51}
{capture name='grn_link_system_GRN_LNK_SY_52'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-52' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_system_GRN_LNK_SY_52}
</p>

</form>

{include file='grn/system_footer.tpl'}
