{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last postfix=$filename}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-238' replace='true'}</th>
  <td>{grn_select name='bid' options=$book_options onchange="form.action='$page_path';form.submit();"}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-239' replace='true'}</th>
  <td>{grn_charset name='charset' default=$charset bom='TRUE'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-240' replace='true'}</th>
  <td>{if $title}{assign var='yes' value=true}{else}{assign var='no' value=true}{/if}{capture name='grn_address_system_GRN_ADDR_SYS_241'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-241' replace='true'}{/capture}{grn_radio name='title' id='yes' value='1' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_241 checked=$yes}&nbsp;{capture name='grn_address_system_GRN_ADDR_SYS_242'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-242' replace='true'}{/capture}{grn_radio name='title' id='no' value='0' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_242 checked=$no}</td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_243'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-243' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_243}
      {grn_button_cancel page='address/system/export_index'}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='address/_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}

<input type="hidden" name="filename" value="{$filename}">
</form>

{include file='grn/system_footer.tpl'}
