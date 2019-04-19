{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-201' replace='true'}</div></p>

{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_202'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-202' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_202 necessary=false}</th>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_203'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-203' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_address_system_GRN_ADDR_SYS_203 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_204'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-204' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_204 necessary=true}</th>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_205'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-205' replace='true'}{/capture}{validate form=$form_name field='id' criteria="notEmpty" message=$smarty.capture.grn_address_system_GRN_ADDR_SYS_205 transform="cb_trim" append="validation_errors"}{grn_text name='id' size='50' disable_return_key=true value=$id}<br>
      <div class="br">&nbsp;</div>
      <div class="sub_explanation">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-206' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_207'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-207' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_207}</th>
  <td>
      {grn_select name='type' options=$book_type_options}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_208'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-208' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_208 id="system_shared_address_book_add_submit"}
      {grn_button_cancel page='address/system/book_list'}
  </td>
 </tr>
</table>

</form>
{include file='grn/system_footer.tpl'}
