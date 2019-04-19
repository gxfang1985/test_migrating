{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-417' replace='true'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-418' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_419'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-419' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_419 necessary=TRUE}
  </th>
  <td>
{capture name='grn_schedule_system_GRN_SCH_SY_420'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-420' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_420 append="validation_errors"}
       <select name="title">
        <option value="">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-421' replace='true'}
{foreach from=$menu.menupage key=id item=title}
        <option value="{$id}">{$title[0]|escape}
{/foreach}
       </select>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-422' replace='true'}
  </th>
  <td>
       {include file="schedule/system/_insert_text.tpl"}<br>
       <div class="margin_top">
       {grn_textarea name="data" value="$data" cols="50" rows="15"}
       </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_423'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-423' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_423}
       {grn_button_cancel page='schedule/system/menupage_list'}
  </td>
 </tr>
</table>

<input type="hidden" name="menupageid" value="{$menu.id}">
</form>

{include file='grn/system_footer.tpl'}
