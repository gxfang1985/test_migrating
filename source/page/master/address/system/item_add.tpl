{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-96' replace='true'}<br>
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-97' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_98'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-98' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_98 necessary=true}</th>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_99'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-99' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_address_system_GRN_ADDR_SYS_99 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$display_name}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-100' replace='true'}</th>
  <td>
     {capture name='page_path'}{grn_pageurl page='address/system/item_add'}{/capture}
     {assign var='page_path' value=$smarty.capture.page_path}
     {grn_select name='type' options=$item_type_options default=$item_type onchange="form.action='$page_path';form.submit();"}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_101'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-101' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_101 necessary=true}</th>
  <td>
      {if $builtin}{$item.item_id|escape}{else}{capture name='grn_address_system_GRN_ADDR_SYS_102'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-102' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_address_system_GRN_ADDR_SYS_102 transform="cb_trim" append="validation_errors"}{grn_text name='id' size='50' value=$id}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_103'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-103' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_103 necessary=false}</th>
  <td>{capture name='grn_address_system_GRN_ADDR_SYS_104'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-104' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_104 name='use' id='use' value='1' checked=$use}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_105'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-105' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_105 necessary=false}</th>
  <td>{capture name='grn_address_system_GRN_ADDR_SYS_106'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-106' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_106 name='display' id='display' value='1' checked=$display}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_107'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-107' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_107 necessarty=false}</th>
  <td>{capture name='grn_address_system_GRN_ADDR_SYS_108'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-108' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_108 name='necessary' id='necessary' value='1' checked=$necessary}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_109'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-109' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_109 necessary=false}</th>
  <td>{capture name='grn_address_system_GRN_ADDR_SYS_110'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-110' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_110 name='not_modify' id='not_modify' value='1' checked=$not_modify}</td>
 </tr>
 {if $smarty.const.ON_FOREST !== 1 }
 <tr valign="top">
  <th nowrap>{capture name='grn_address_system_GRN_ADDR_SYS_111'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-111' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_address_system_GRN_ADDR_SYS_111 necessary=false}</th>
  <td>
    {if $type == GRN_ADDRESS_ITEM_URL || $type == GRN_ADDRESS_ITEM_IMAGE_URL || $type == GRN_ADDRESS_ITEM_FILE}
     {cb_msg module='grn.address.system' key='GRN_ADDR_SYS-112' replace='true'}<input type="hidden" name="sso" value="0">
    {else}
     {grn_select name='sso' options=$sso_options}<br>
   <div class="margin_top">
    <span class="sub_explanation">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-113' replace='true'}</span>
   </div>
    {/if}
  </td>
 </tr>
 {/if}
 <tr>
  <td></td>
  <td>
      {capture name='grn_address_system_GRN_ADDR_SYS_114'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-114' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_114 id="`$page_info.last`_submit"}
      {grn_button_cancel page='address/system/item_list' bid=$book_id}
  </td>
 </tr>
</table>

<input type="hidden" name="bid" value="{$book_id}">
</form>

{include file='grn/system_footer.tpl'}
