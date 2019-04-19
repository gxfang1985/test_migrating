{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.link.system' key='GRN_LNK_SY-103' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$category.name}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-104' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.link.system' key='GRN_LNK_SY-105' replace='true'}</p>
 <p>
  {capture name='grn_link_system_GRN_LNK_SY_106'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-106' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_106}
  {capture name='grn_link_system_GRN_LNK_SY_107'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-107' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_system_GRN_LNK_SY_107}
 </p>
<input type="hidden" name="cid" value="{$category.cid}">
{foreach from=$link item=id}
<input type="hidden" name="ids[]" value="{$id}">
{/foreach}
</form>
{include file="grn/system_footer.tpl"}
