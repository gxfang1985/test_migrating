{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-12' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_message_personal_GRN_MSG_PE_13'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-13' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_personal_GRN_MSG_PE_13 necessary=true}</th>
  <td>{capture name='grn_message_personal_GRN_MSG_PE_14'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-14' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_message_personal_GRN_MSG_PE_14 transform="cb_trim" append="validation_errors"}{capture name='grn_message_personal_GRN_MSG_PE_15'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-15' replace='true'}{/capture}{grn_text name="title" value=$filter.title size="50" title=$smarty.capture.grn_message_personal_GRN_MSG_PE_15 disable_return_key=true}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-16' replace='true'}</th>
  <td>
       <select name="kind">
{if $filter.kind == 2}
        <option value="1">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-17' replace='true'}
        <option value="2" selected>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-18' replace='true'}
{else}
        <option value="1" selected>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-19' replace='true'}
        <option value="2">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-20' replace='true'}
{/if}
       </select>
       <div class="margin_top">
       {include file="grn/message_filter.tpl"}
       </div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_message_personal_GRN_MSG_PE_21'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-21' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_personal_GRN_MSG_PE_21 necessary=true}</th>
  <td>
       {capture name='grn_message_personal_GRN_MSG_PE_22'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-22' replace='true'}{/capture}{validate form=$form_name field="folder" criteria="isNumber" message=$smarty.capture.grn_message_personal_GRN_MSG_PE_22 append="validation_errors"}{capture name='grn_message_personal_GRN_MSG_PE_23'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-23' replace='true'}{/capture}{capture name='grn_message_personal_GRN_MSG_PE_24'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-24' replace='true'}{/capture}{grn_message_select_folders select_name="folder" selected_folder_id=$filter.cid hide_root_folder="1" hide_garbage_folder="1" exception_value="-1" exception_item=$smarty.capture.grn_message_personal_GRN_MSG_PE_23 exception_value2="0" exception_item2=$smarty.capture.grn_message_personal_GRN_MSG_PE_24}
      <div class="margin_top">
       <span class="sub_explanation">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-25' replace='true'}</span>
      </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_message_personal_GRN_MSG_PE_26'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-26' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_26}
       {grn_button_cancel page="message/personal/filter_view" mfid=$filter_id}
  </td>
 </tr>
</table>
<input type="hidden" name="mfid" value="{$filter_id}">
<input type='hidden' name='fn' value="{$form_name}">
</form>

{include file='grn/personal_footer.tpl'}
