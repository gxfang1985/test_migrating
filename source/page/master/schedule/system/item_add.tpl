{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-446' replace='true'}<br>
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-447' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_448'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-448' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_448 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_449'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-449' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_449 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' disable_return_key=true value=$display_name}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_450'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-450' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_450 necessary=TRUE}
  </th>
  <td>
      {if $builtin}{$item.item_id|escape}{else}{capture name='grn_schedule_system_GRN_SCH_SY_451'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-451' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_451 transform="cb_trim" append="validation_errors"}{grn_text name='id' size='50' value=$id}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-452' replace='true'}
  </th>
  <td>
     {capture name='page_path'}{grn_pageurl page='schedule/system/item_add'}{/capture}
     {assign var='page_path' value=$smarty.capture.page_path}
     {grn_select name='type' options=$item_type_options default=$item_type onchange="form.action='$page_path';form.submit();"}
  </td>
 </tr>
 
{if $type == GRN_SCHEDULE_ITEM_MENU}
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-453' replace='true'}
  </th>
  <td>
   <div class="sub_explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-454' replace='true'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-455' replace='true'}</div>
   {grn_textarea name="item_menu_textarea" rows="5" value=$item_menu_textarea}<br>
   {grn_text name='item_menu_text' size='50' disable_return_key=true value=$item_menu_text}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-456' replace='true'}
  </td>
 </tr>
{/if}

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-457' replace='true'}
  </th>
  <td>{capture name='grn_schedule_system_GRN_SCH_SY_458'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-458' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_458 name='use' id='use' value='1' checked=$use}</td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-459' replace='true'}
  </th>
  <td>{capture name='grn_schedule_system_GRN_SCH_SY_460'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-460' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_460 name='display' id='display' value='1' checked=$display}</td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-461' replace='true'}
  </th>
  <td>{capture name='grn_schedule_system_GRN_SCH_SY_462'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-462' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_462 name='display_item_name' id='display_item_name' value='1' checked=$display_item_name}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_463'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-463' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_463}
       {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
