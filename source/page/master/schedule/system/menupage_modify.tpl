{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-530' replace='true'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-531' replace='true'}</div></p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_schedule_system_GRN_SCH_SY_532'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-532' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_532 necessary=true}
  </th>
  <td>
{capture name='grn_schedule_system_GRN_SCH_SY_533'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-533' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_schedule_system_GRN_SCH_SY_533 append="validation_errors"}
       <select name="title">
        <option value="">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-534' replace='true'}
{foreach from=$menu.menupage key=id item=title}
 {if $menu.title == $title[0]}
        <option value="{$id}" selected>{$title[0]|escape}
 {else}         
        <option value="{$id}">{$title[0]|escape}
 {/if}
{/foreach}
       </select>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-535' replace='true'}
  </th>
  <td>
       {include file="schedule/system/_insert_text.tpl"}<br>
       <div class="margin_top">
       {grn_textarea name="data" value=$menu.data cols="50" rows="15"}
       </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>

       {capture name='grn_schedule_system_GRN_SCH_SY_536'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-536' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_536}
       {grn_button_cancel page='schedule/system/menupage_view' menupageid=$menu.id}
</table>

<input type="hidden" name="menupageid" value="{$menu.id}">
</form>
{include file='grn/system_footer.tpl'}
