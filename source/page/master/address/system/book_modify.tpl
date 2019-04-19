{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-294' replace='true'}</div></p>

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_295'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-295' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_295 necessary=false}</th>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_296'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-296' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_address_system_GRN_ADDR_SYS_296 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_297'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-297' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_297 necessary=true}</th>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_298'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-298' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_address_system_GRN_ADDR_SYS_298 transform="cb_trim" append="validation_errors"}{grn_text name='id' size='50' disable_return_key=true value=$id}<br>
      <div class="br">&nbsp;</div>
      <div class="sub_explanation">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-299' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_300'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-300' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_300}</th>
  <td>
      {$type|escape}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_301'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-301' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_301}
      {grn_button_cancel page='address/system/book_view' bid=$oid}
  </td>
 </tr>
</table>

<input type="hidden" name="bid" value="{$oid}">
</form>
{include file='grn/system_footer.tpl'}
