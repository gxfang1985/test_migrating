{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
<div class="mainareaSchedule-grn">
{grn_load_javascript file="grn/html/schedule.js"}
    {assign var='form_name' value=$smarty.template|basename}
{if $kintone_dialog_mode}<form>{include file="schedule/_add_button.tpl" top_button=true button_id_suffix="_top"}</form>{/if}
<div><span class="bold">{grn_date_format format='DateFull_YMDW' date=$bdate}</span><a href="javascript:void(0);display_on_off('display_day_open:display_swith_image_open:display_swith_image_close')"><span id="display_swith_image_open" class="mLeft10">{cb_msg module='grn.schedule' key='GRN_SCH-126' replace='true'}{capture name='grn_schedule_GRN_SCH_127'}{cb_msg module='grn.schedule' key='GRN_SCH-127' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_128'}{cb_msg module='grn.schedule' key='GRN_SCH-128' replace='true'}{/capture}{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_127 title=$smarty.capture.grn_schedule_GRN_SCH_128}</span><span id="display_swith_image_close" class="mLeft10" style="display:none;">{cb_msg module='grn.schedule' key='GRN_SCH-129' replace='true'}{capture name='grn_schedule_GRN_SCH_130'}{cb_msg module='grn.schedule' key='GRN_SCH-130' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_131'}{cb_msg module='grn.schedule' key='GRN_SCH-131' replace='true'}{/capture}{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_130 title=$smarty.capture.grn_schedule_GRN_SCH_131}</span></a></div>
<div id="display_day_open" style="display:none;">
    {include file='schedule/_member_day.tpl'}
</div>
{if ! $kintone_dialog_mode}{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}{/if}
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

<form class="js_customization_form" name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_add'}">
    {if $allow_file_attachment}
    <input type='hidden' name='tab_name' value="{$form_name}">
    <input type="hidden" name="tmp_key" value="{$tmp_key}">
    <input type="hidden" name="allow_file_attachment" value="{$allow_file_attachment}">
    {/if}
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="additional_items" value="{$schedule_event.additional_items|escape}">
    {include file="schedule/_add_menu.tpl"}
    <div class="js_customization_schedule_header_space"></div>
    <table class="std_form" id="main_table">
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-133' replace='true'}</th>
            <td>
                <table>
                    <tr>
                        <td nowrap>

     
                            {grn_select_date prefix='start_' date=$schedule_event.start_date form_name=$form_name onchange='change_enddate();' no_delimiter=true}&nbsp;{grn_select_time prefix='start_' minute_interval=$minute_interval time=$schedule_event.start_time}<span id="applied_timezone" class="span_timezone"{if !$display_timezone} style='display:none;'{/if}>{cb_msg module='grn.schedule' key='applied_timezone'}<span id='span_timezone'>{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span></span>{include file='grn/time_selector.tpl' target_form=$form_name start_hour='start_hour' end_hour='end_hour' kintone_dialog_mode=$kintone_dialog_mode}{cb_msg module='grn.schedule' key='GRN_SCH-137' replace='true'}
                            <p class="half"> 
                            {grn_select_date prefix='end_' date=$schedule_event.end_date form_name=$form_name no_delimiter=true}&nbsp;{grn_select_time prefix='end_' minute_interval=$minute_interval time=$schedule_event.end_time}<span id="applied_end_timezone" class="span_timezone"{if !$display_timezone} style='display:none;'{/if}>{cb_msg module='grn.schedule' key='applied_timezone'}<span id='span_end_timezone'>{cb_msg module='fw.timezone' key=$schedule_event.end_timezone}</span></span>
                            <div><span id="span_time_span" class="margin_top sub_explanation"><span class="attention" id="validate_date" style="display:none;">{cb_msg module='grn.schedule' key='validate_repeat_date' replace='true'}</span><span class="attention" id="invalid_date" style="display:none;">{cb_msg module='grn.schedule' key='invalid_time' replace='true'}</span></span></div>
                            <div id="another_timezone" class="link_timezone">{if !$display_timezone}<span id="timezone_to_link" style=''><span id="current_timezone">{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span><span>&nbsp;{cb_msg module='grn.schedule' key='timezone_to_link' replace='true'}&nbsp;</span></span>{/if}<a id="opne_timezone_dialog" href="javascript:;" onclick="GRN_ScheduleSelectTimezone.openTimezoneDialog();">{cb_msg module='grn.schedule' key='display_timezone' replace='true'}</a></div>
                            {include file='schedule/_select_timezone.tpl' timezone=$schedule_event.timezone end_timezone=$schedule_event.end_timezone}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-144' replace='true'}</th>
            <td>
                <select menu="scuedule_menu" name="menu" class="hidden" id="select_menu">
                    {if $schedule_event.selectmenu !== FALSE && $schedule_event.selectmenu !== '' && ! is_null( $schedule_event.selectmenu )}
                        <option value="{$schedule_event.selectmenu|escape};#{$schedule_event.event_menu_color|escape}">{$schedule_event.selectmenu|escape}</option>
                    {/if}
                    <option value="">-----</option>
                    {foreach from=$menus key=menu_id item=menu}
                        <option value="{$menu[0]|escape};#{$menu[1]|escape}">{$menu[0]|escape}</option>
                    {/foreach}
                </select>&nbsp;{grn_text name="title" value=$schedule_event.title size="80" disable_return_key=true}
            </td>
        </tr>
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-145' replace='true'}</th>
            <td>
                {grn_member_add name='member_select' form_name=$form_name selected_users=$schedule_event.users app_id='schedule' access_plugin=$add_plugin app_id='schedule' include_org=$show_organize popup_include_org=$show_organize org_direct=TRUE is_calendar=TRUE}
            </td>
        </tr>
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-146' replace='true'}</th>
            <td>
                {** GTM-1676 START **}
                {include file='schedule/facility_add.tpl' initialize_item=$schedule_event.facilities}
                {** GTM-1676 END **}
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
        {include file="schedule/_using_purpose.tpl" form_name=$form_name usingPurposeValue=$schedule_event.usingPurposeValue usingApprovalFacility=$schedule_event.usingApprovalFacility }
        {** -------------- GTM-1676 END   ----------------- **}

        {** -------------- VCBSCH0010 START ----------------- **}
        {include file="schedule/_netmeeting_menu.tpl"}
        {** -------------- VCBSCH0010 END   ----------------- **}
        <tr>
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-147' replace='true'}</th>
            <td>
                {include file="schedule/_confirmview.tpl"}
                {if ! $kintone_dialog_mode}{include file="schedule/_adjust_link.tpl"}{/if}
            </td>
        </tr>
        {include file="schedule/_address_menu.tpl"}
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-148' replace='true'}</th>
            <td>{grn_textarea name="memo" value=$schedule_event.memo rows="5" cols="65"}</td>
        </tr>
        {if $allow_file_attachment}
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-942' replace='true'}</th>
            <td>{include file="grn/attach_file.tpl" attached_files=$schedule_event.attached_files disable_return_key=true}</td>
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
                {include file="schedule/_add_button.tpl"}
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript" src="{$app_path}/grn/html/timezone_info.js?{$build_date}"></script>
<script type="text/javascript" src="{$app_path}/grn/html/schedule_add.js?{$build_date}"></script>
</div>
{if $kintone_available}{include file='schedule/_kintone_relation.tpl' use_type='add' table_tag='main_table' select_tag='select_menu' kintone_dialog_mode=$kintone_dialog_mode selected_item=$selected_item kintone_app=$kintone_app kintone_record=$kintone_record field_code=$field_code}{/if}
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
