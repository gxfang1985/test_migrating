{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{cb_pageurl page='system/filemanager/command_mime_delete_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-63' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-64' replace='true'}</p>
 <div class="sub_explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-65' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-66' replace='true'}<br>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-67' replace='true'}</div>
 <p>
  {capture name='grn_system_filemanager_GRN_SY_FI_68'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-68' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_68}
  {capture name='grn_system_filemanager_GRN_SY_FI_69'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-69' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_69}
 </p>
{foreach from=$deletion_info.list item=eid}
 <input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
{if $deletion_info.all}
 <input type="hidden" name="all" value=1>
{/if}
</form>
{include file="grn/system_footer.tpl"}
