{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
<div class="mainareaSchedule-grn">
{grn_load_javascript file="grn/html/schedule.js"}
<div><span class="bold">{grn_date_format format='DateFull_YMDW' date=$bdate}</span><a href="javascript:void(0);display_on_off('display_day_open:display_swith_image_open:display_swith_image_close')"><span id="display_swith_image_open" class="mLeft10">{cb_msg module='grn.schedule' key='GRN_SCH-198' replace='true'}{capture name='grn_schedule_GRN_SCH_199'}{cb_msg module='grn.schedule' key='GRN_SCH-199' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_200'}{cb_msg module='grn.schedule' key='GRN_SCH-200' replace='true'}{/capture}{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_199 title=$smarty.capture.grn_schedule_GRN_SCH_200}</span><span id="display_swith_image_close" class="mLeft10" style="display:none;">{cb_msg module='grn.schedule' key='GRN_SCH-201' replace='true'}{capture name='grn_schedule_GRN_SCH_202'}{cb_msg module='grn.schedule' key='GRN_SCH-202' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_203'}{cb_msg module='grn.schedule' key='GRN_SCH-203' replace='true'}{/capture}{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_202 title=$smarty.capture.grn_schedule_GRN_SCH_203}</span></a></div>
<div id="display_day_open" style="display:none;">
    {include file='schedule/_member_day.tpl'}
</div>
{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}
{assign var='form_name' value=$smarty.template|basename}

{literal}
<script language="JavaScript" type="text/javascript">
function change_enddate()
{
    form = document.forms["{/literal}{$form_name}{literal}"];
    cb_ui_select_date_change_enddate( form );
}
//-->
</script>
{/literal}
<form class="js_customization_form" name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_'|cat:$page_info.last}">
    <div class="js_customization_schedule_header_space"></div>
    {validate form=$form_name field="dummy" criteria="notEmpty" append="validation_errors"}

    {** -------------- VCBSCH0010 START ----------------- **}
    {if $schedule_event.netmeeting_update_msg_now}
        {if $schedule_event.netmeeting.outside_rows > 0}
            <p style="font-size:90%;">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-38' replace='true'}</p>
        {else}
            <p style="font-size:90%;">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-39' replace='true'}</p>
        {/if}
    {/if}
    {if $schedule_event.netmeeting_notupdate_msg_now}
        <p style="font-size:90%;">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-45' replace='true'}</p>
    {/if}
    {if $schedule_event.netmeeting_notupdate_msg_end}
        <p style="font-size:90%;">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-40' replace='true'}</p>
    {/if}
    {** -------------- VCBSCH0010 END   ----------------- **}

    <table class="std_form" id="main_table">
        <tr valign="top">
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-205' replace='true'}</th>
            <td>
                {grn_select_date prefix='start_' date=$schedule_event.start_date form_name=$form_name onchange='change_enddate();' no_delimiter=true}&nbsp;{grn_select_time prefix='start_' minute_interval=$minute_interval time=$schedule_event.start_time form_name=$form_name}<span id='applied_timezone' class='span_timezone'{if !$display_timezone} style='display:none;'{/if}>{cb_msg module='grn.schedule' key='applied_timezone'}<span id='span_timezone'>{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span></span>{include file='grn/time_selector.tpl' target_form=$form_name start_hour='start_hour' end_hour='end_hour'}{cb_msg module='grn.schedule' key='GRN_SCH-209' replace='true'}
                <p class="half">
                {grn_select_date prefix='end_' date=$schedule_event.end_date form_name=$form_name no_delimiter=true}&nbsp;{grn_select_time prefix='end_' minute_interval=$minute_interval time=$schedule_event.end_time}<span id="applied_end_timezone" class="span_timezone"{if !$display_timezone} style='display:none;'{/if}>{cb_msg module='grn.schedule' key='applied_timezone'}<span id='span_end_timezone'>{cb_msg module='fw.timezone' key=$schedule_event.end_timezone}</span></span>
                <div><span id="span_time_span" class="margin_top sub_explanation"><span class="attention" id="validate_date" style="display:none;">{cb_msg module='grn.schedule' key='validate_repeat_date' replace='true'}</span><span class="attention" id="invalid_date" style="display:none;">{cb_msg module='grn.schedule' key='invalid_time' replace='true'}</span></span></div>
                <div id="another_timezone" class="link_timezone">{if !$display_timezone}<span id="timezone_to_link" style=''><span id="current_timezone">{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span><span>&nbsp;{cb_msg module='grn.schedule' key='timezone_to_link' replace='true'}&nbsp;</span></span>{/if}<a id="opne_timezone_dialog" href="javascript:;" onclick="GRN_ScheduleSelectTimezone.openTimezoneDialog();">{cb_msg module='grn.schedule' key='display_timezone' replace='true'}</a></div>
                {include file='schedule/_select_timezone.tpl' timezone=$schedule_event.timezone end_timezone=$schedule_event.end_timezone}
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-210' replace='true'}</th>
            <td>
                <select menu="scuedule_menu" name="menu" class="hidden" id="select_menu">
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
        <tr valign="top">
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-211' replace='true'}</th>
            <td>
                {grn_member_add name='member_select' form_name=$form_name selected_users=$schedule_event.users app_id='schedule' access_plugin=$add_plugin include_org=$show_organize popup_include_org=$show_organize org_direct=TRUE is_calendar=TRUE}
            </td>
        </tr>
        <tr valign="top">
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-212' replace='true'}</th>
            <td>
                {include file='schedule/facility_add.tpl' initialize_item=$schedule_event.facilities}
                <!--extended_items-->
                <div id="extended_items" name="extended_items" class="facilityExtended-grn" {if $schedule_event.facilities|@count < 1}style="display:none;"{/if}>
                    <table>
                        {include file='schedule/_action_item_contents.tpl' extended_items=$extended_items}
                    </table>
                </div>
                <!--extended_items_end-->
            </td>
        </tr>

        {** -------------- GTM-1676 START ----------------- **}
        {include file="schedule/_using_purpose.tpl" usingApprovalFacility=$schedule_event.usingApprovalFacility form_name=$form_name usingPurposeValue=$schedule_event.usingPurposeValue}
        {** -------------- GTM-1676 END   ----------------- **}

        {** -------------- VCBSCH0010 START ----------------- **}
        {include file="schedule/_netmeeting_menu.tpl"}
        {** -------------- VCBSCH0010 END   ----------------- **}
        <tr>
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-213' replace='true'}</th>
            <td>
                {include file="schedule/_confirmview.tpl"}
            </td>
        </tr>

        {include file="schedule/_address_menu.tpl"}

        <tr valign="top">
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-214' replace='true'}</th>
            <td>{grn_textarea name="memo" value=$schedule_event.memo rows="5" cols="65"}</td>
        </tr>
        {if $allow_file_attachment}
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-942' replace='true'}</th>
            <td>{include file="grn/attach_file.tpl" attached_files=$schedule_event.attached_files}</td>
        </tr>
        {/if}
        {if $use_private || $use_attendance_check}
        <tr>
            <td class="form_category_title_td_grn" colspan="2"><div class="form_category_title_grn">{cb_msg module='grn.schedule' key='GRN_SCH-996' replace='true'}</div></td>
        </tr>
        {/if}
        {if $use_private}
            {include file="schedule/_private_menu.tpl"}
        {/if}
        {if $use_attendance_check}
        <tr>
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-997' replace='true'}</th>
            <td>
                {capture name='grn_schedule_system_GRN_SCH_998'}{cb_msg module='grn.schedule' key='GRN_SCH-998' replace='true'}{/capture}{grn_checkbox name='attendance_check' id='attendance_check' value='1' checked=$schedule_event.attendance_check caption=$smarty.capture.grn_schedule_system_GRN_SCH_998 span_cover="1"}
            </td>
        </tr>
        {/if}
        <tr>
            <td></td>
            <td>
                {include file="schedule/_modify_button.tpl"}
            </td>
        </tr>
    </table>
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="dummy" value="0">
    <input type="hidden" name='event_id' value="{$schedule_event.event_id|escape}">
    <input type="hidden" name='bdate' value="{$bdate|escape}">
    <input type="hidden" name="uid" value="{$user_id|escape|escape:"javascript"}">
    <input type="hidden" name="referer_key" value="{$referer_key|escape}">
    {if $allow_file_attachment}
    <input type="hidden" name="tmp_key" value="{$tmp_key}">
    <input type="hidden" name="allow_file_attachment" value="{$allow_file_attachment}">
    {/if}
    <input type="hidden" name="additional_items" value="{$schedule_event.additional_items|escape}">
</form>
<script type="text/javascript" src="{$app_path}/grn/html/timezone_info.js?{$build_date}"></script>
<script type="text/javascript" src="{$app_path}/grn/html/schedule_add.js?{$build_date}"></script>
</div>
{if $kintone_available}{include file='schedule/_kintone_relation.tpl' use_type='modify' table_tag='main_table' select_tag='select_menu' event_id=$schedule_event.event_id event_menu=$schedule_event.selectmenu}{/if}
{include file='grn/footer.tpl'}
{grn_load_customization_js_css}
{grn_load_javascript file="js/dist/schedule.js"}
{literal}
    <script language="JavaScript" type="text/javascript">
        jQuery(function () {
            grn.js.component.customization.schedule.event_trigger.syncMembers("schedule.event.edit.show");
        });
    </script>
{/literal}
