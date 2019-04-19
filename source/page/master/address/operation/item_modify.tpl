{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-10' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{if ! $builtin_item_id}
 {assign var=necessary value=true}
{include file='grn/indispensable.tpl'}
{/if}

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_11'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-11' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_11 necessary=$necessary}</th>
  <td>{if $builtin_item_id}{$item.display_name|escape}{else}{capture name='grn_address_operation_GRN_ADDR_OP_12'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-12' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_address_operation_GRN_ADDR_OP_12 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' value=$item.display_name}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-13' replace='true'}</th>
     {assign var='item_type' value=$item.type}
  <td>{$item_type_options.$item_type.label|escape}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_14'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-14' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_14 necessary=$necessary}</th>
  <td>{if $builtin_item_id}{$item.id|escape}{else}{capture name='grn_address_operation_GRN_ADDR_OP_15'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-15' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_address_operation_GRN_ADDR_OP_15 transform="cb_trim" append="validation_errors"}{grn_text name='id' size='50' value=$item.id}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_16'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-16' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_16 necessary=false}</th>
  <td>{capture name='grn_address_operation_GRN_ADDR_OP_17'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-17' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_17 name='use' id='use' value='1' checked=$item.use}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_18'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-18' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_18 necessary=false}</th>
  <td>{capture name='grn_address_operation_GRN_ADDR_OP_19'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-19' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_19 name='display' id='display' value='1' checked=$item.display}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_20'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-20' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_20 necessarty=false}</th>
  <td>{capture name='grn_address_operation_GRN_ADDR_OP_21'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-21' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_21 name='necessary' id='necessary' value='1' checked=$item.necessary}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_22'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-22' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_22 necessary=false}</th>
  <td>{capture name='grn_address_operation_GRN_ADDR_OP_23'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-23' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_23 name='not_modify' id='not_modify' value='1' checked=$item.not_modify}</td>
 </tr>
 {if $smarty.const.ON_FOREST != 1}
 <tr valign="top">
  <th nowrap>{capture name='grn_address_operation_GRN_ADDR_OP_24'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-24' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_operation_GRN_ADDR_OP_24 necessary=false}</th>
  <td>
    {if $item.type == GRN_ADDRESS_ITEM_URL || $item.type == GRN_ADDRESS_ITEM_IMAGE_URL || $item.type == GRN_ADDRESS_ITEM_FILE || $item.id == 'subject' || $item.id == 'map' || $item.id == 'route'}
   {cb_msg module='grn.address.operation' key='GRN_ADDR_OP-25' replace='true'}<input type="hidden" name="sso" value="0">
    {else}
   {grn_select name='sso' options=$sso_options}
   <div class="margin_top">
    <span class="sub_explanation">{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-26' replace='true'}</span>
   </div>
    {/if}
  </td>
 </tr>
 {/if}
 <tr>
  <td></td>
  <td>
      {capture name='grn_address_operation_GRN_ADDR_OP_27'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-27' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_27}
      {grn_button_cancel}
  </td>
 </tr>
</table>

<input type="hidden" name="bid" value="{$book_id}">
{if $builtin_item_id}<input type="hidden" name="biid" value="{$builtin_item_id}">{/if}
{if $extended_item_id}<input type="hidden" name="eiid" value="{$extended_item_id}">{/if}
</form>

{include file='grn/footer.tpl'}
