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
{literal}
<script language="JavaScript" type="text/javascript">

    function ov(e) {
        e.className = 'personal_week_calendar_data_cell personal_calendar_cell_on';
    }
    function ot(e) {
        e.className = 'personal_week_calendar_data_cell';
    }
    function ov_event(e) {
        e.className = 'personal_week_calendar_event_cell personal_calendar_cell_on';
    }
    function ot_event(e) {
        e.className = 'personal_week_calendar_event_cell';
    }
    function co(ev, wd) {
        if (ev && ev.srcElement) {
            var e = ev.srcElement;
        }
        else if (ev && ev.target) {
            var e = ev.target;
        }
        if (e && e.tagName == "A")return;
        location.href = "{/literal}{grn_pageurl page='schedule/add'}&uid={$schedule.user_id}&gid={$group_id}&referer_key={$referer_key}{literal}&bdate=" + wd;
    }
    function ct(ev, wd, t) {
        if (ev && ev.srcElement) {
            var e = ev.srcElement;
        }
        else if (ev && ev.target) {
            var e = ev.target;
        }
        if (e && e.tagName == "A")return;
        location.href = "{/literal}{grn_pageurl page='schedule/add'}&uid={$schedule.user_id}&gid={$group_id}&referer_key={$referer_key}{literal}&bdate=" + wd + "&set_hour=" + t;
    }
    var zIndexMax = 7;
    function ove(e) {
        e.style.zIndex = zIndexMax;
        zIndexMax++;
    }
</script>
{/literal}
<div class="mainarea">
    <div class="mainareaSchedule-grn">
        {assign var='form_name' value=$smarty.template|basename}
        <div id="view">
            {include file="schedule/_tab_menu.tpl" ajax_flag=true enable_print_week=true}
            <form name="{$form_name}" method="GET"
                  action="{grn_pageurl page=$page_info.all bdate=$bdate uid=$user_id gid=$group_id}"
                  class="view_main_area">

                {include file="schedule/_day_navi.tpl" navi_cal_display_flag=$navi_cal_display_flag}
                <div class="day_week_calendar_navi_grn">
                    {include file="schedule/_schedule_navi_calendar.tpl" navi_cal_display_flag=$navi_cal_display_flag location='schedule/personal_week'}
                </div>
                <div class="cb-user-picker"></div>
                <!-- calendar grid -->
                <div class="calendar_area">
                    <div class="personal_week_calendar_base_header">
                        <div class="personal_week_calendar_header">
                            <table id="personal_week_list_event_notime"
                                   class="personal_week_list_event_notime without_time_events_area js_customization_schedule_view_type_WEEK"
                                   cellpadding="0" cellspacing="0">
                                {* Cells for days *}
                                <tr>
                                    {foreach from=$week item=day}
                                        <td class="{$day.type} personal_week_calendar_date_cell date_cell">
                                            <font size="-1">
                                                <a href="{grn_pageurl page='schedule/personal_day'
                                                bdate=$day.format
                                                uid=$user_id
                                                gid=$group_id
                                                search_text=$search_text}">
                                                    {grn_date_format date=$day.date format="DateShort_MDW"}
                                                </a>
                                            </font>
                                        </td>
                                    {/foreach}
                                </tr>
                                {* Cells for all day events, calendar events, Todo items *}
                                <tr class="js_customization_schedule_user_id">
                                    {foreach from=$week item=day}
                                        <td class="personal_week_calendar_event_cell without_time_event_cell"
                                            plid="0"{if $schedule.user_type eq 'facility'} utype="facility"{/if}>

                                            <!-- Calendar events here -->

                                            <div id="personal_week_event_notime_{$schedule_event.date_type}_{$schedule_event.date}"
                                                 class="personal_week_event_notime without_time_event_list">
                                                <!-- TODO items here -->

                                            </div>
                                        </td>
                                    {/foreach}
                                </tr>
                            </table>
                        </div>
                    </div>

                    {* Cells for specific time events *}
                    <div class="showtime personal_week_calendar_base" id="time_event">
                        <div id="personal_calendar_list" class="personal_calendar_list normal_events_area">
                            <table cellpadding="0" cellspacing="0" class="personal_week_list_event">
                                <tr>
                                    {foreach from=$week name=week_list item=day}
                                        <td class="personal_week_calendar_date{if $smarty.foreach.week_list.first} firstColumn{/if}{if $smarty.foreach.week_list.last} lastColumn{/if}">
                                            <div id="{$day.type}_{$day.format}"
                                                 class="personal_day_event_list{if $smarty.foreach.week_list.last} last_date{/if}"
                                                 style="{if $browser.type eq 'firefox' and $browser.ver_major lt 30}width:14.2857%{else}width:100%{/if};">
                                            </div>
                                        </td>
                                    {/foreach}
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
</div>

{include file="schedule/multi_view_js.tpl"}
<script>
    {literal}
    /**
     * Initialize calendar view
     */
    jQuery(function initialize_week_view() {

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
            numberOfDays: 7,
            facilityPlacement: "{$facility_placement}",
            loginUser: grn.data.login,
            initialMembers: {$schedule_params.members|@json_encode},
            uid: "{$user_id}",
            gid: "{$group_id}",
            refererKey: "{$referer_key}",
            enableDragAndDrop: parseInt("{$enable_dragdrop}", 10),
            shortDateFormat: "{$short_date_format|grn_noescape}",
            locale: "{$html_tag_lang}",
            viewType: "WEEK"
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
