{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
<div class="mainareaSchedule-grn">
{grn_load_javascript file="grn/html/schedule.js"}
<div><span class="bold">{grn_date_format format='DateFull_YMDW' date=$bdate}</span><a href="javascript:void(0);display_on_off('display_day_open:display_swith_image_open:display_swith_image_close')"><span id="display_swith_image_open" class="mLeft10">{cb_msg module='grn.schedule' key='GRN_SCH-29' replace='true'}{capture name='grn_schedule_GRN_SCH_30'}{cb_msg module='grn.schedule' key='GRN_SCH-30' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_31'}{cb_msg module='grn.schedule' key='GRN_SCH-31' replace='true'}{/capture}{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_30 title=$smarty.capture.grn_schedule_GRN_SCH_31}</span><span id="display_swith_image_close" class="mLeft10" style="display:none;">{cb_msg module='grn.schedule' key='GRN_SCH-32' replace='true'}{capture name='grn_schedule_GRN_SCH_33'}{cb_msg module='grn.schedule' key='GRN_SCH-33' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_34'}{cb_msg module='grn.schedule' key='GRN_SCH-34' replace='true'}{/capture}{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_33 title=$smarty.capture.grn_schedule_GRN_SCH_34}</span></a></div>
<div id="display_day_open" style="display:none;">
{include file='schedule/_member_day.tpl'}
</div>
{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}
{assign var='form_name' value=$smarty.template|basename}
<form id="{$form_name}" name="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 {validate form=$form_name field="dummy" criteria="notEmpty" append="validation_errors"}
 <p><div class="explanation mTop5 mBottom5">{cb_msg module='grn.schedule' key='GRN_SCH-35' replace='true'}</div></p>

 <p>
 <table class="std_form">
  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-36' replace='true'}</th>
   <td>
 {if $schedule_event.temporary_type == 'or'}
  {foreach from=$schedule_event.temporary item=facility_data}
   <strong>{$facility_data.facility_name|escape}</strong><br>
   {foreach from=$facility_data.dates item=temporary}
    {cb_msg module='grn.schedule' key='GRN_SCH-37' replace='true'} {grn_date_format date=$temporary.setdatetime format="DateTimeLong_YMDW_HM"}{cb_msg module='grn.schedule' key='GRN_SCH-38' replace='true'}{grn_date_format date=$temporary.enddatetime format="DateTimeLong_YMDW_HM"}<br>
   {/foreach}
  {/foreach}
 {else}
  {foreach from=$schedule_event.temporary item=temporary}
   {cb_msg module='grn.schedule' key='GRN_SCH-39' replace='true'} {grn_date_format date=$temporary.setdatetime format="DateTimeLong_YMDW_HM"}{cb_msg module='grn.schedule' key='GRN_SCH-40' replace='true'}{grn_date_format date=$temporary.enddatetime format="DateTimeLong_YMDW_HM"}<br>
  {/foreach}
 {/if}
       <div class="br">&nbsp;</div>
       <div class="sub_explanation">{cb_msg module='grn.schedule' key='GRN_SCH-41' replace='true'}</div>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-42' replace='true'}</th>
   <td>
    <select menu="scuedule_menu" name="menu">
{if $schedule_event.selectmenu}
     <option value="{$schedule_event.selectmenu|escape};#{$schedule_event.menucolor|escape}">{$schedule_event.selectmenu|escape}</option>
{/if}
     <option value="">-----</option>
{foreach from=$menus key=menu_id item=menu}
     <option value="{$menu[0]|escape};#{$menu[1]|escape}">{$menu[0]|escape}</option>
{/foreach}
    </select>&nbsp;{grn_text name="title" value=$schedule_event.title size="80" disable_return_key=true}
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-43' replace='true'}</th>
   <td>
{foreach from=$schedule_event.users key=uid item=user}
    <div class="voice">{grn_schedule_member_name id=$uid name=$user.displayName groups_info=$groups_info referer_key=$referer_key}</div>
{/foreach}
    <div class="clear_left"><div class="sub_explanation">{cb_msg module='grn.schedule' key='GRN_SCH-44' replace='true'}</div></div>
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-45' replace='true'}</th>
   <td>
{foreach from=$schedule_event.facilities key=uid item=facility_name}
    <div class="voice">{$facility_name|escape}</div>
{/foreach}
    <div class="clear_left"><div class="sub_explanation">{cb_msg module='grn.schedule' key='GRN_SCH-46' replace='true'}</div></div>
   </td>
  </tr>
{if $use_private}
    {include file="schedule/_private_menu.tpl"}
{/if}
    {include file="schedule/_address_menu.tpl"}
  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-47' replace='true'}</th>
   <td>{grn_textarea name="memo" value=$schedule_event.memo rows="5" cols="65"}</td>
  </tr>
  <tr>
   <td></td>
   <td>
    {include file="schedule/_modify_button.tpl"}
   </td>
  </tr>
 </table>
 <input type="hidden" name="dummy" value="0">
 <input type="hidden" name="temporary" value="1">
 <input type="hidden" name="event_id" value="{$schedule_event.event_id|escape}">
 <input type="hidden" name="bdate" value="{$bdate|escape}">
 <input type="hidden" name="uid" value="{$user_id|escape}">
 <input type="hidden" name="referer_key" value="{$referer_key|escape}">
</form>
</div>
{include file='grn/footer.tpl'}
