{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
<div class="mainareaSchedule-grn">
{grn_load_javascript file="grn/html/schedule.js"}
<div><span class="bold">{grn_date_format format='DateFull_YMDW' date=$bdate}</span><a href="javascript:void(0);display_on_off('display_week_open:display_swith_image_open:display_swith_image_close')"><span id="display_swith_image_open" class="mLeft10">{cb_msg module='grn.schedule' key='GRN_SCH-397' replace='true'}{capture name='grn_schedule_GRN_SCH_398'}{cb_msg module='grn.schedule' key='GRN_SCH-398' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_399'}{cb_msg module='grn.schedule' key='GRN_SCH-399' replace='true'}{/capture}{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_398 title=$smarty.capture.grn_schedule_GRN_SCH_399}</span><span id="display_swith_image_close" class="mLeft10" style="display:none;">{cb_msg module='grn.schedule' key='GRN_SCH-400' replace='true'}{capture name='grn_schedule_GRN_SCH_401'}{cb_msg module='grn.schedule' key='GRN_SCH-401' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_402'}{cb_msg module='grn.schedule' key='GRN_SCH-402' replace='true'}{/capture}{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_401 title=$smarty.capture.grn_schedule_GRN_SCH_402}</span></a></div>
<div id="display_week_open" style="display:none;">
{include file='schedule/_member_week.tpl'}
</div>
{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation mTop3 mBottom5">{cb_msg module='grn.schedule' key='GRN_SCH-404' replace='true'}</div>
<form class="js_customization_form" id="{$form_name}" name="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 {if $allow_file_attachment }
 <input type='hidden' name='tab_name' value="{$form_name}">
 <input type="hidden" name="tmp_key" value="{$tmp_key}">
 <input type="hidden" name="allow_file_attachment" value="{$allow_file_attachment}">
 {/if}
 <input type="hidden" name="BN" value="1">
 <input type="hidden" name="additional_items" value="{$schedule_event.additional_items|escape}">
 {include file="schedule/_add_menu.tpl"}
 <div class="js_customization_schedule_header_space"></div>
 <table class="std_form">
  <tr>
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-405' replace='true'}</th>
   <td>
    <table>
     <tr>
      <td nowrap>
{literal}
<script language="JavaScript" type="text/javascript">
// {/literal}{cb_msg module='grn.schedule' key='GRN_SCH-406' replace='true'}{literal}
function change_enddate()
{
    form = document.forms["{/literal}{$form_name}{literal}"];
    cb_ui_select_date_change_enddate( form );
}
//-->
</script>
{/literal}
    {grn_select_date prefix='start_' date=$schedule_event.start_date form_name=$form_name onchange='change_enddate();' no_delimiter=true}{cb_msg module='grn.schedule' key='GRN_SCH-409' replace='true'}{grn_select_date prefix='end_' date=$schedule_event.end_date form_name=$form_name no_delimiter=true}
    <div><span id="span_time_span" class="margin_top sub_explanation"><span class="attention" id="invalid_date" style="display:none;">{cb_msg module='grn.schedule' key='invalid_date' replace='true'}</span></span></div>
    <div id="another_timezone" class="link_timezone"><span id="timezone_to_link"><span id="current_timezone">{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span><span>&nbsp;{cb_msg module='grn.schedule' key='timezone_to_link' replace='true'}&nbsp;</span></span><a id="opne_timezone_dialog" href="javascript:;" onclick="GRN_ScheduleSelectTimezone.openTimezoneDialog();">{cb_msg module='grn.schedule' key='display_timezone' replace='true'}</a></div>
{include file='schedule/_select_timezone.tpl' timezone=$schedule_event.timezone end_timezone=$schedule_event.end_timezone disable_different_timezones='true'}
      </td>
     </tr>
    </table>
   </td>
  <tr>
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-416' replace='true'}</th>
   <td>
    <select menu="scuedule_menu" name="menu" class="hidden">
{if $schedule_event.selectmenu !== FALSE && $schedule_event.selectmenu !== '' && ! is_null( $schedule_event.selectmenu )}
     <option value="{$schedule_event.selectmenu|escape};#{$schedule_event.menucolor|escape}">{$schedule_event.selectmenu|escape}</option>
{/if}
     <option value="">-----</option>
{foreach from=$menus key=menu_id item=menu}
     <option value="{$menu[0]|escape};#{$menu[1]|escape}">{$menu[0]|escape}</option>
{/foreach}
    </select>&nbsp;{grn_text name="title" value=$schedule_event.title size="80" disable_return_key=true}
   </td>
  </tr>
  </tr>
  <tr valign="top">
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-417' replace='true'}</th>
   <td>
    {grn_member_add name='member_select' form_name=$form_name selected_users=$schedule_event.users app_id='schedule' access_plugin=$add_plugin include_org=$show_organize popup_include_org=$show_organize org_direct=TRUE is_calendar=TRUE}
   </td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-418' replace='true'}</th>
   <td>
    {include file="schedule/_confirmview.tpl"}
   </td>
  </tr>

  {include file="schedule/_address_menu.tpl"}

  <tr valign="top">
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-419' replace='true'}</th>
   <td>{grn_textarea name="memo" value=$schedule_event.memo rows="5" cols="65"}</td>
  </tr>
  {if $allow_file_attachment}
  <tr valign="top">
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-942' replace='true'}</th>
   <td>{include file="grn/attach_file.tpl" attached_files=$schedule_event.attached_files disable_return_key=true}</td>
  </tr>
  {/if}
  <tr>
   <td></td>
   <td>
    {include file="schedule/_add_button.tpl"}
   </td>
  </tr>
 </table>
</form>
<script type="text/javascript" src="{$app_path}/grn/html/timezone_info.js?{$build_date}"></script>
<script type="text/javascript" src="{$app_path}/grn/html/schedule_validate_date.js?{$build_date}"></script>
</div>
{include file='grn/footer.tpl'}
{grn_load_customization_js_css}
{grn_load_javascript file="js/dist/schedule.js"}
{literal}
<script language="JavaScript" type="text/javascript">
    jQuery(function () {
        grn.js.component.customization.schedule.event_trigger.syncMembers("schedule.event.create.show");
    });
</script>
{/literal}
