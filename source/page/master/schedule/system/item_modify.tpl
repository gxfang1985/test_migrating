{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-197' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{if ! $builtin_item_id}
 {assign var=necessary value=true}
 {include file='grn/indispensable.tpl'}
{/if}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_schedule_system_GRN_SCH_SY_198'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-198' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_198 necessary=$necessary}</th>
  <td>{if $builtin_item_id}{$item.display_name|escape}{else}{capture name='grn_schedule_system_GRN_SCH_SY_199'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-199' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_199 transform="cb_trim" append="validation_errors"}{grn_text name='display_name' size='50' value=$item.display_name}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_schedule_system_GRN_SCH_SY_200'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-200' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_200 necessary=$necessary}</th>
  <td>{if $builtin_item_id}{$item.id|escape}{else}{capture name='grn_schedule_system_GRN_SCH_SY_201'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-201' replace='true'}{/capture}{validate form=$form_name field="id" criteria="notEmpty" message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_201 transform="cb_trim" append="validation_errors"}{grn_text name='id' size='50' value=$item.id}{/if}</td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-202' replace='true'}
  </th>
  <td>
  {if $extended_item_id}
   {capture name='page_path'}{grn_pageurl page='schedule/system/item_modify'}{/capture}
   {assign var='page_path' value=$smarty.capture.page_path}
   {grn_select name='type' options=$item_type_options default=$item.type onchange="form.action='$page_path';form.submit();"}
  {else}
   {assign var='item_type' value=$item.type}
   {$item_type_options.$item_type.label|escape}
  {/if}
  </td>
 </tr>
 
{if $item.type == GRN_SCHEDULE_ITEM_MENU}
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-203' replace='true'}
  </th>
  <td>
   <div class="sub_explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-204' replace='true'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-205' replace='true'}</div>
   {grn_textarea name="item_menu_textarea" rows="5" value=$item.item_menu_textarea}<br>
   {grn_text name='item_menu_text' size='50' disable_return_key=true value=$item.item_menu_text}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-206' replace='true'}
  </td>
 </tr>
{/if}
 
 <tr>
  <th nowrap>{capture name='grn_schedule_system_GRN_SCH_SY_207'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-207' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_207 necessary=false}</th>
  <td>
   {if $extended_item_id}{capture name='grn_schedule_system_GRN_SCH_SY_208'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-208' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_208 name='use' id='use' value='1' checked=$item.use}
   {else}{capture name='grn_schedule_system_GRN_SCH_SY_209'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-209' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_209 image='spacer20.gif'}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_schedule_system_GRN_SCH_SY_210'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-210' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_210 necessary=false}</th>
  <td>{capture name='grn_schedule_system_GRN_SCH_SY_211'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-211' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_211 name='display' id='display' value='1' checked=$item.display}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_schedule_system_GRN_SCH_SY_212'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-212' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_212 necessarty=false}</th>
  <td>
   {if $extended_item_id}{capture name='grn_schedule_system_GRN_SCH_SY_213'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-213' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_213 name='display_item_name' id='display_item_name' value='1' checked=$item.display_item_name}   
   {else}{capture name='grn_schedule_system_GRN_SCH_SY_214'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-214' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_214 image='spacer20.gif'}{/if}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_215'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-215' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_215}
      {grn_button_cancel}
  </td>
 </tr>
</table>

{if $builtin_item_id}<input type="hidden" name="biid" value="{$builtin_item_id}">{/if}
{if $extended_item_id}<input type="hidden" name="eiid" value="{$extended_item_id}">{/if}
</form>

{include file='grn/system_footer.tpl'}
