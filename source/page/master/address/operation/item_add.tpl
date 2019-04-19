{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-28' replace='true'}<br>
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-29' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_30'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-30' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_30 necessary=true}</th>
  <td>
      {capture name='grn_address_operation_GRN_ADDR_OP_31'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-31' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_address_operation_GRN_ADDR_OP_31 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$display_name}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-32' replace='true'}</th>
  <td>
     {capture name='page_path'}{grn_pageurl page='address/operation/item_add'}{/capture}
     {assign var='page_path' value=$smarty.capture.page_path}
     {grn_select name='type' options=$item_type_options default=$item_type onchange="form.action='$page_path';form.submit();"}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_33'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-33' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_33 necessary=true}</th>
  <td>
      {if $builtin}{$item.item_id|escape}{else}{capture name='grn_address_operation_GRN_ADDR_OP_34'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-34' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_address_operation_GRN_ADDR_OP_34 transform="cb_trim" append="validation_errors"}{grn_text name='id' size='50' value=$id}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_35'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-35' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_35 necessary=false}</th>
  <td>{capture name='grn_address_operation_GRN_ADDR_OP_36'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-36' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_36 name='use' id='use' value='1' checked=$use}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_37'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-37' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_37 necessary=false}</th>
  <td>{capture name='grn_address_operation_GRN_ADDR_OP_38'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-38' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_38 name='display' id='display' value='1' checked=$display}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_39'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-39' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_39 necessarty=false}</th>
  <td>{capture name='grn_address_operation_GRN_ADDR_OP_40'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-40' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_40 name='necessary' id='necessary' value='1' checked=$necessary}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_41'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-41' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_41 necessary=false}</th>
  <td>{capture name='grn_address_operation_GRN_ADDR_OP_42'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-42' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_42 name='not_modify' id='not_modify' value='1' checked=$not_modify}</td>
 </tr>
 {if $smarty.const.ON_FOREST != 1}
 <tr valign="top">
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_43'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-43' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_43 necessary=false}</th>
  <td>
    {if $type == GRN_ADDRESS_ITEM_URL || $type == GRN_ADDRESS_ITEM_IMAGE_URL || $type == GRN_ADDRESS_ITEM_FILE}
     {cb_msg module='grn.address.operation' key='GRN_ADDR_OP-44' replace='true'}<input type="hidden" name="sso" value="0">
    {else}
     {grn_select name='sso' options=$sso_options}
    {/if}
    <div class="margin_top">
    <span class="sub_explanation">{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-45' replace='true'}</span>
    </div>
  </td>
 </tr>
 {/if}
 <tr>
  <td></td>
  <td>
      {capture name='grn_address_operation_GRN_ADDR_OP_46'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-46' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_46}
      {grn_button_cancel page='address/operation/item_list' bid=$book_id}
  </td>
 </tr>
</table>

<input type="hidden" name="bid" value="{$book_id}">
</form>

{include file='grn/footer.tpl'}
