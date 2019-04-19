{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{capture name='grn_message_system_GRN_MSG_SY_81'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-81' replace='true'}{/capture}{grn_title title=$smarty.capture.grn_message_system_GRN_MSG_SY_81 class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="mid" value="{$mid}">
<input type="hidden" name="rfid" value="{$rfid}">
<input type="hidden" name="frm" value="{$frm}">
{include file='grn/file_restore.tpl' download_page='message/system/inspection_file_download' linkparams=$linkparams}
</form>
{include file='grn/system_footer.tpl'}
