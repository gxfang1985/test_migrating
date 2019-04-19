{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='schedule/_title_search.tpl'}
<style type="text/css">
    {literal}
    .schedule_display_options {
        position: relative;
    }

    .schedule_display_options_dialog {
        right: 0px;
    }

    {/literal}
</style>
{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}
<div class="mainarea">
    <div class="mainareaSchedule-grn">
        {assign var='form_name' value=$smarty.template|basename}
        <div id="view" class="multi_view">
            {include file="schedule/_tab_menu.tpl"}

            <form class="scheduleWrapper view_main_area" name="{$form_name}" method="GET"
                  action="{grn_pageurl page=$page_info.all bdate=$bdate uid=$user_id gid=$group_id}">
                {include file="schedule/_day_navi.tpl" navi_cal_display_flag=$navi_cal_display_flag}
                <div class="day_week_calendar_navi_grn">
                    {include file="schedule/_schedule_navi_calendar.tpl" navi_cal_display_flag=$navi_cal_display_flag location='schedule/personal_day'}
                </div>
                <div class="cb-user-picker"></div>
                {strip}
                <div class="personal_day_calendar_base_header js_customization_schedule_view_type_DAY">
                    <div class="personal_day_calendar_header">
                        <table cellpadding="0" cellspacing="0" class="personal_day_calendar_event_cell without_time_events_area"
                               id="notime_event">
                            <tr class="js_customization_schedule_user_id">
                                <td class="personal_day_calendar_event_item without_time_event_cell"
                                    {if $schedule.access.add && $having_using_privilege}
                                        plid="0"
                                        {if $schedule.user_type eq 'facility'} utype="facility"{/if}
                                    {/if}>
                                    <div id="personal_day_event_notime" class="personal_day_event_notime without_time_event_list">
                                    </div>
                                </td>
                            </tr>
                        </table>
                        {/strip}
                        <table cellpadding="0" cellspacing="0" class="personal_day_calendar_banner_cell all_day_area"
                               id="banner_event">
                        </table>
                    </div>
                </div>

                <div class="showtime personal_day_calendar_base" id="time_event">
                    <div id="personal_calendar_list" class="personal_calendar_list normal_events_area">
                        <table cellpadding="0" cellspacing="0" style="width:100%;">
                            <tr>
                                <td class="personal_day_calendar_date">
                                    <div id="{$schedule.schedule_event.date_type}"
                                         class="personal_day_event_list last_date" style="width:100%;">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
        </div>

        <input type="hidden" name="gid" value="{$group_id|escape}">
        <input type="hidden" name="bdate" value="{$bdate|escape}">
        </form>
    </div>
</div>

{include file="schedule/multi_view_js.tpl"}

<script>
    {literal}
    /**
     * Initialize calendar view
     */
    jQuery(function initialize_day_view() {

        var settings = {
            {/literal}
            beginDate: "{$schedule_params.dates[0].value}",
            minTime: parseInt("{$schedule_params.min_time}", 10),
            maxTime: parseInt("{$schedule_params.max_time}", 10),
            calendarWeekStart: parseInt("{$schedule_params.calendarWeekStart}", 10),
            eventTimeUnit: "{$schedule_params.unit}",
            events: {$schedule_params.events|@json_encode},
            dates: {$schedule_params.dates|@json_encode},
            today: {$schedule_params.today|@json_encode},
            numberOfDays: 1,
            facilityPlacement: "{$facility_placement}",
            loginUser: grn.data.login,
            initialMembers: {$schedule_params.members|@json_encode},
            enableDateFooter: false,
            uid: "{$user_id}",
            gid: "{$group_id}",
            refererKey: "{$referer_key}",
            enableDragAndDrop: parseInt("{$enable_dragdrop}", 10),
            shortDateFormat: "{$short_date_format|grn_noescape}",
            locale: "{$html_tag_lang}",
            viewType: "DAY"
            {literal}
        };

        var view = new grn.component.schedule.multi_view.main(settings);
        view.init();
    });

    {/literal}
</script>

{include file="grn/error_handler.tpl"}
{grn_load_customization_js_css}
{include file='grn/footer.tpl'}
