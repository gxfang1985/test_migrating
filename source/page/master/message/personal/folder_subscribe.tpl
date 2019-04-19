{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-42' replace='true'}<br>
{cb_msg module='grn.message.personal' key='GRN_MSG_PE-43' replace='true'}{$app_name}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-44' replace='true'}{$app_name}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-45' replace='true'}
</dvi>

<p>
{grn_message_select_folders select_name="cid" selected_folder_id=$cid hide_garbage_folder=1 hide_root_folder=1 need_checkbox=1}

{capture name='grn_message_personal_GRN_MSG_PE_46'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-46' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_46}
{grn_button_cancel}


</form>

{include file='grn/personal_footer.tpl'}
