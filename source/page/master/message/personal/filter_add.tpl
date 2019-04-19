{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-27' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_message_personal_GRN_MSG_PE_28'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-28' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_personal_GRN_MSG_PE_28 necessary=true}</th>
  <td>{capture name='grn_message_personal_GRN_MSG_PE_29'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-29' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_message_personal_GRN_MSG_PE_29 transform="cb_trim" append="validation_errors"}{capture name='grn_message_personal_GRN_MSG_PE_30'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-30' replace='true'}{/capture}{grn_text name="title" value=$filter.title size="50" title=$smarty.capture.grn_message_personal_GRN_MSG_PE_30 disable_return_key=true}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-31' replace='true'}</th>
  <td>
       <select name="kind">
{if $filter.kind == 2}
        <option value="1">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-32' replace='true'}
        <option value="2" selected>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-33' replace='true'}
{else}
        <option value="1" selected>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-34' replace='true'}
        <option value="2">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-35' replace='true'}
{/if}
       </select>
       <div class="margin_top">
       {include file="grn/message_filter.tpl"}
       </div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_message_personal_GRN_MSG_PE_36'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-36' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_personal_GRN_MSG_PE_36 necessary=true}</th>
  <td>
       {capture name='grn_message_personal_GRN_MSG_PE_37'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-37' replace='true'}{/capture}{validate form=$form_name field="folder" criteria="isNumber" message=$smarty.capture.grn_message_personal_GRN_MSG_PE_37 append="validation_errors"}{capture name='grn_message_personal_GRN_MSG_PE_38'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-38' replace='true'}{/capture}{capture name='grn_message_personal_GRN_MSG_PE_39'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-39' replace='true'}{/capture}{grn_message_select_folders select_name="folder" selected_folder_id=$filter.cid hide_root_folder="1" hide_garbage_folder="1" exception_value="-1" exception_item=$smarty.capture.grn_message_personal_GRN_MSG_PE_38 exception_value2="0" exception_item2=$smarty.capture.grn_message_personal_GRN_MSG_PE_39}
      <div class="margin_top">
       <span class="sub_explanation">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-40' replace='true'}</span>
      </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_message_personal_GRN_MSG_PE_41'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-41' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_41 id="personal_filter_add_submit"}
  {grn_button_cancel page="message/personal/filter" id="personal_filter_add_cancel"}
  </td>
 </tr>
</table>
<input type='hidden' name='fn' value="{$form_name}">
</form>

{include file='grn/personal_footer.tpl'}
