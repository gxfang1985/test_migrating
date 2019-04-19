{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-95' replace='true'}</th>
  <td><input type="hidden" name="bid" value="{$book.oid}">{grn_sentence class='person20' caption=$book.display_name}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_96'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-96' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_96 necessary=true}</th>
  <td>{capture name='grn_address_operation_GRN_ADDR_OP_97'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-97' replace='true'}{/capture}{validate form=$form_name field='file:file' criteria='grn_notFileEmpty' message=$smarty.capture.grn_address_operation_GRN_ADDR_OP_97 append='validation_errors'}{grn_file name='file' size='50' disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-98' replace='true'}</th>
  <td>{grn_charset name='charset' default=$charset}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-99' replace='true'}</th>
  <td>{if $skip}{assign var='yes' value=true}{else}{assign var='no' value=true}{/if}{capture name='grn_address_operation_GRN_ADDR_OP_100'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-100' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_100 checked=$yes}&nbsp;{capture name='grn_address_operation_GRN_ADDR_OP_101'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-101' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_101 checked=$no}</td>
 </tr>
 <tr>
  <td></td>
  <td>
      <input class="margin" type="submit" name="send" value="{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-102' replace='true'} >>">
      {* {grn_button_submit class='margin' caption="次へ >>"} *}
      {grn_button_cancel class='margin' page='address/index'}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='address/_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='import'}

</form>

{include file='grn/footer.tpl'}
