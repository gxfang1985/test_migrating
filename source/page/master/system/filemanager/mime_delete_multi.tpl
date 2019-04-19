{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{cb_pageurl page='system/filemanager/command_mime_delete_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-34' replace='true'}<span class="bold">{$deletion_info.number_of_deletion}</span>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-35' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-36' replace='true'}</p>
 <div class="sub_explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-37' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-38' replace='true'}<br>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-39' replace='true'}</div>
 <p>
  {capture name='grn_system_filemanager_GRN_SY_FI_40'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-40' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_40}
  {capture name='grn_system_filemanager_GRN_SY_FI_41'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-41' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_41}
 </p>
{foreach from=$deletion_info.list item=eid}
 <input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
{if $deletion_info.all}
 <input type="hidden" name="all" value=1>
{/if}
</form>
{include file="grn/system_footer.tpl"}
