{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-230' replace='true'}</th>
  <td>{capture name='page_path'}{grn_pageurl page='address/system/import1'}{/capture}{assign var='page_path' value=$smarty.capture.page_path}{grn_select name='bid' options=$book_options onchange="form.action='$page_path';form.submit();"}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_231'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-231' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_231 necessary=true}</th>
  <td>{capture name='grn_address_system_GRN_ADDR_SYS_232'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-232' replace='true'}{/capture}{validate form=$form_name field='file:file' criteria='grn_notFileEmpty' message=$smarty.capture.grn_address_system_GRN_ADDR_SYS_232 append='validation_errors'}{grn_file name='file' size='50' disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-233' replace='true'}</th>
  <td>{grn_charset name='charset' default=$charset}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-234' replace='true'}</th>
  <td>{if $skip}{assign var='yes' value=true}{else}{assign var='no' value=true}{/if}{capture name='grn_address_system_GRN_ADDR_SYS_235'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-235' replace='true'}{/capture}{grn_radio name="skip" id="skip1" value="1" caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_235 checked=$yes}&nbsp;{capture name='grn_address_system_GRN_ADDR_SYS_236'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-236' replace='true'}{/capture}{grn_radio name="skip" id="skip0" value="0" caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_236 checked=$no}</td>
 </tr>
 <tr>
  <td></td>
  <td>
      <input class="margin" type="submit" name="send" value="{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-237' replace='true'} >>">
      {* {grn_button_submit class='margin' caption="次へ >>"} *}
      {grn_button_cancel class='margin' page='address/system/import_index'}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='address/_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='import'}

</form>

{include file='grn/system_footer.tpl'}
