{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-78' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{if ! $builtin_item_id}
 {assign var=necessary value=true}
 {include file='grn/indispensable.tpl'}
{/if}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_79'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-79' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_79 necessary=$necessary}</th>
  <td>{if $builtin_item_id}{$item.display_name|escape}{else}{capture name='grn_address_system_GRN_ADDR_SYS_80'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-80' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_address_system_GRN_ADDR_SYS_80 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' value=$item.display_name}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-81' replace='true'}</th>
     {assign var='item_type' value=$item.type}
  <td>{$item_type_options.$item_type.label|escape}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_82'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-82' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_82 necessary=$necessary}</th>
  <td>{if $builtin_item_id}{$item.id|escape}{else}{capture name='grn_address_system_GRN_ADDR_SYS_83'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-83' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_address_system_GRN_ADDR_SYS_83 transform="cb_trim" append="validation_errors"}{grn_text name='id' size='50' value=$item.id}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_84'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-84' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_84 necessary=false}</th>
  <td>{capture name='grn_address_system_GRN_ADDR_SYS_85'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-85' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_85 name='use' id='use' value='1' checked=$item.use}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_86'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-86' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_86 necessary=false}</th>
  <td>{capture name='grn_address_system_GRN_ADDR_SYS_87'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-87' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_87 name='display' id='display' value='1' checked=$item.display}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_88'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-88' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_88 necessarty=false}</th>
  <td>{capture name='grn_address_system_GRN_ADDR_SYS_89'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-89' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_89 name='necessary' id='necessary' value='1' checked=$item.necessary}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_90'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-90' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_90 necessary=false}</th>
  <td>{capture name='grn_address_system_GRN_ADDR_SYS_91'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-91' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_91 name='not_modify' id='not_modify' value='1' checked=$item.not_modify}</td>
 </tr>
 {if $smarty.const.ON_FOREST !== 1 }
 <tr valign="top">
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_92'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-92' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_92 necessary=false}</th>
   <td>{if $item.type == GRN_ADDRESS_ITEM_URL || $item.type == GRN_ADDRESS_ITEM_IMAGE_URL || $item.type == GRN_ADDRESS_ITEM_FILE || $item.id == 'subject' || $item.id == 'map' || $item.id == 'route'}
  {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-93' replace='true'}<input type="hidden" name="sso" value="0">
    {else}
  {grn_select name='sso' options=$sso_options}<br>
    <div class="br">&nbsp;</div>
    <div class="sub_explanation">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-94' replace='true'}</div>
    {/if}
   </td>
 </tr>
 {/if}
 <tr>
  <td></td>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_95'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-95' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_95}
      {grn_button_cancel}
  </td>
 </tr>
</table>

<input type="hidden" name="bid" value="{$book_id}">
{if $builtin_item_id}<input type="hidden" name="biid" value="{$builtin_item_id}">{/if}
{if $extended_item_id}<input type="hidden" name="eiid" value="{$extended_item_id}">{/if}
</form>

{include file='grn/system_footer.tpl'}
