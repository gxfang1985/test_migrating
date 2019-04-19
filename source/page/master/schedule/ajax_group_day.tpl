{capture assign="bar_login_timezone"}{include file="schedule/_login_timezone.tpl"}{/capture}
{strip}
{foreach name=schedule from=$schedule.users item=schedule}

    {if ($smarty.foreach.schedule.iteration-1)%5 == 0}
        {if $smarty.foreach.schedule.iteration != 1}
            {include file="schedule/_day_navi2.tpl" aname=$smarty.foreach.schedule.iteration page_name="group_day"}
        {/if}
    {/if}

    <tr class="day_table_time_login bar_user_timezone" {if !$member_tz}style="display:none"{/if}>
        <td class="group_day_calendar_timebar1"><span class='domain'>{cb_msg module='fw.timezone' key=$schedule.timezone}</span></td>
        <td class="group_day_calendar_timebar2"><br></td>
        {grn_schedule_time_header set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' uid=$schedule.user_id facility_id=$schedule.facility_id timezone=$schedule.timezone bdate=$bdate}
    </tr>
    <tr class="day_table_time_login bar_user_timezone" {if !$member_tz}style="display:none"{/if}>
        <td class="group_day_calendar_timebar_sec1">{grn_image image='spacer1.gif'}</td>
        <td class="group_day_calendar_timebar_sec2">{grn_image image='spacer1.gif'}</td>
        {grn_schedule_time_header2 set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' uid=$schedule.user_id timezone=$schedule.timezone bdate=$bdate}
    </tr>
    {$bar_login_timezone|grn_noescape}
    <tr class="js_customization_schedule_user_id_{$schedule.user_id}">
        <td {if $show_full_title}class="userBox group_day_calendar_user"{else}class="userBox group_day_calendar_user nowrap_class"{/if}>
            {capture name='grn_schedule_GRN_SCH_621'}{cb_msg module='grn.schedule' key='GRN_SCH-621' replace='true'}{/capture}
            {if $schedule.facility_id}
                {grn_link image='facility20.gif' page='schedule/facility_info' faid=$schedule.facility_id caption=$schedule.facility_title referer_key=$referer_key}
                {capture name='grn_schedule_GRN_SCH_740'}{cb_msg module='grn.schedule' key='GRN_SCH-740' replace='true'}{/capture}
                <div class="shortcut_box_facility_grn">
                    {grn_link image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$schedule.user_id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_621 title=$smarty.capture.grn_schedule_GRN_SCH_621 class='small_link' event=$event_id}
                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$schedule.user_id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_740 class='small_link'}
                    {capture name='grn_schedule_GRN_SCH_741'}{cb_msg module='grn.schedule' key='GRN_SCH-741' replace='true'}{/capture}
                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$schedule.user_id gid=$group_id search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_741 class='small_link'}
                    {$schedule.facility_memo|grn_noescape}
                </div>
            {else}
                {assign var='uid' value=$schedule.user_id}
                {capture name="prefix"}{$uid|substr:0:1}{/capture}
                {if $imageIcon && $smarty.capture.prefix != 'g'}
                    <div class="userElement profileImageBase-grn profileImageBaseSchedule-grn">
                        <dl>
                            <dt>{grn_user_image_icon userInfo=$users_info.$uid photoUrl=$users_info.$uid.photoUrl userId=$uid loginId=$login_id size=$iconSize is_popup=false referer_key=$referer_key}</dt>
                            <dd>{grn_schedule_member_name id=$schedule.user_id users_info=$users_info groups_info=$groups_info referer_key=$referer_key noimage=true}</dd>
                        </dl>
                        <div class="clear_both_0px"></div>
                    </div>
                {else}
                    <div class="userElement"><span class="span_user">{grn_schedule_member_name id=$schedule.user_id users_info=$users_info groups_info=$groups_info referer_key=$referer_key}</span></div>
                {/if}
                {capture name='grn_schedule_GRN_SCH_742'}{cb_msg module='grn.schedule' key='GRN_SCH-742' replace='true'}{/capture}
                {capture name='grn_schedule_GRN_SCH_743'}{cb_msg module='grn.schedule' key='GRN_SCH-743' replace='true'}{/capture}
                <div class="shortcut_box_full" {if !$show_full_title}style="display:none"{/if}>
                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$schedule.user_id gid=selected search_text=$search_text caption=$smarty.capture.grn_schedule_GRN_SCH_621 alt=$smarty.capture.grn_schedule_GRN_SCH_621 class='small_link' event=$event_id}
                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$schedule.user_id gid=selected search_text=$search_text caption=$smarty.capture.grn_schedule_GRN_SCH_742 alt=$smarty.capture.grn_schedule_GRN_SCH_742 class='small_link'}
                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$schedule.user_id gid=$group_id search_text=$search_text caption=$smarty.capture.grn_schedule_GRN_SCH_743 alt=$smarty.capture.grn_schedule_GRN_SCH_743 class='small_link'}
                    {foreach from=$interaction_info_list item='interaction_info'}
                        {if $interaction_info.$uid}
                            {grn_link wrapper_class='schedule_userbox_item_grn' image=$interaction_info.$uid.image page=$interaction_info.$uid.page uid=$uid caption=$interaction_info.$uid.caption alt=$interaction_info.$uid.alt disabled=$interaction_info.$uid.disabled class='small_link'}
                        {/if}
                    {/foreach}
                </div>
                <div class="shortcut_box_short" {if $show_full_title}style="display:none"{/if}>
                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pday20.gif' page='schedule/personal_day' bdate=$bdate uid=$schedule.user_id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_621 class='small_link' event=$event_id}
                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$bdate uid=$schedule.user_id gid=selected search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_742 class='small_link'}
                    {grn_link wrapper_class='schedule_userbox_item_grn' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$schedule.user_id gid=$group_id search_text=$search_text caption='' alt=$smarty.capture.grn_schedule_GRN_SCH_743 class='small_link'}
                    {foreach from=$interaction_info_list item='interaction_info'}
                        {if $interaction_info.$uid}
                            {grn_link wrapper_class='schedule_userbox_item_grn' image=$interaction_info.$uid.image page=$interaction_info.$uid.page uid=$uid caption='' alt=$interaction_info.$uid.alt disabled=$interaction_info.$uid.disabled class='small_link'}
                        {/if}
                    {/foreach}
                </div>
                {if $active_presence}
                    {assign var='presence' value=$schedule.presence}
	                <span class="schedule_userbox_item_grn schedule_userbox_presence_grn">
	                    {grn_link page=$presence.page image=$presence.image caption=$presence.info uid=$uid disabled=$presence.disabled br=true class='small_link'}
	                    {if $presence.mtime}
	                        {if $presence.old}<span class="attention">{/if}
	                           <span class="group_day_calendar_presence">[{grn_date_format date=$presence.mtime format="DateTimeCompact"}]</span>
	                        {if $presence.old}</span>{/if}
	                    {/if}
	                </span>
                {/if}
                {if $login_timezone != $schedule.timezone}<span class='domain'>{cb_msg module='fw.timezone' key=$schedule.timezone}</span>{/if}
            {/if}
        </td>
        <td class="normalEvent group_day_calendar_event_cell" rel="{grn_pageurl page='schedule/simple_add' uid=$schedule.user_id gid=$group_id bdate=$bdate referer_key=$referer_key}" onmouseout="GRN_ScheduleSimpleAdd.mouseOutHandler(event, this);" onmouseover="GRN_ScheduleSimpleAdd.mouseOverHandler(event, this);">
            <div class="js_customization_schedule_date_{$bdate}"></div>
            {if $schedule.schedule_event.calendar}
                {foreach from=$schedule.schedule_event.calendar item=calendar}
                    {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon class='group_day_calendar_event_item'}
                {/foreach}
            {/if}
            {include file="schedule/todo.tpl" event=$schedule.schedule_event}
            {if $schedule.schedule_event.event}
                {foreach from=$schedule.schedule_event.event item=event}
                    {if $event.allday}
                        {if $event.star_date}
                            {assign var='star_date' value=$event.star_date}
                        {else}
                            {assign var='star_date' value=$schedule.schedule_event.date}
                        {/if}
                        {capture name="star_unique_id"}{if $event.type eq 'repeat' || $event.type eq 'share_repeat'}rp_{$event.id}_{$schedule.schedule_event.date}{else}{$event.id}{/if}{/capture}
                        {capture name="star_event"}{strip}
                            {if $event.absent === 1}
                                <div class='schedule_absent'>
                            {/if}
                        {if ! $event.private}
                            <div class="normalEventElement{if $event.id eq $event_id} newevent-grn{/if}">
                            {grn_image image="allday.gif"}
                            <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$bdate uid=$user.id gid=$group_id referer_key=$referer_key}">
                        {/if}
                            {*GTM-1625*}
                            {if !$event.private && $event.attendance_check_show}
                                {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                                {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                            {/if}
                            {*GTM-103*}
                            {if !$event.private && $event.event_menu neq '' && $event.event_menu_color neq ''}
                                <span class="event_color{$event.event_menu_color}_grn">
                                {$event.event_menu|grn_noescape}
                            </span>
                                {$event.event_detail|grn_noescape}
                            {else}
                                {$event.data|grn_noescape}
                            {/if}
                            {*End GTM-103*}
                            {if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}{if $event.type == 'share_repeat' || $event.type == 'repeat'}{grn_image image="repeat16.gif"}{/if}{if $event.report}{grn_image image="report16.gif"}{/if}
                        {if ! $event.private}
                            </a>
                            </div>
                        {/if}
                            {if $event.absent === 1}
                                </div>
                            {/if}
                        {/strip}{/capture}
                        {$smarty.capture.star_event|grn_noescape}
                        {assign var='alldays' value=true}
                    {/if}
                {/foreach}
            {/if}
            {if ! $alldays}
                &nbsp;
            {/if}
        </td>
        {grn_schedule_group_day
            data=$schedule.schedule_event.event
            bdate=$schedule.schedule_event.date
            uid=$schedule.user_id
            gid=$group_id
            unit=$schedule_params.unit
            set_hour=$schedule_params.set_hour
            end_hour=$schedule_params.end_hour
            page='schedule/view'
            access=$schedule.access
            referer_key=$referer_key
            type='normalEvent'
            facility_id= $schedule.facility_id
            timezone=$schedule.timezone
            aeid = $event_id
        }
    </tr>
    {foreach from=$schedule.schedule_event.event item=event}
        {if $event.conflict}
            <tr>
                <td class="group_day_calendar_conflict_head1"><br></td>
                <td class="group_day_calendar_conflict_head2" rel="{grn_pageurl page='schedule/simple_add' uid=$schedule.user_id gid=$group_id bdate=$bdate referer_key=$referer_key}" onmouseover="GRN_ScheduleSimpleAdd.mouseOverHandler(event, this);" onmouseout="GRN_ScheduleSimpleAdd.mouseOutHandler(event, this);"><br></td>
                {grn_schedule_group_day_conflict 
                    menu=$event.event_menu 
                    menu_color=$event.event_menu_color 
                    detail=$event.event_detail 
                    facility_name=$event.event_facility_name 
                    facility_after = $event.facility_name_after
                    faci_items = $event.faci_items
                    start_date=$event.start_date end_date=$event.end_date
                    page='schedule/view' 
                    event=$event.id 
                    bdate=$schedule.schedule_event.date 
                    uid=$schedule.user_id gid=$group_id 
                    unit=$schedule_params.unit 
                    set_hour=$schedule_params.set_hour 
                    end_hour=$schedule_params.end_hour 
                    private=$event.private 
                    title=$event.data referer_key=$referer_key 
                    absent=$event.absent 
                    aeid=$event_id
                    timezone=$schedule.timezone
                    event_type=$event.type
                    no_endtime=$event.no_endtime
                    attendance_check_show=$event.attendance_check_show
                }
            </tr>
        {/if}
    {/foreach}
    {if $schedule.banner_event}
        {foreach from=$schedule.banner_event item=banner_event}
            {if $banner_event.star_date}
                {assign var='star_date' value=$banner_event.star_date}
            {else}
                {assign var='star_date' value=$bdate}
            {/if}
            {if $banner_event.only_view_tz}
                {if !$member_tz && $banner_event.only_view_tz == 1}
                    <tr class="day_table_time_login bar_login_timezone" style="">
                {/if}
                {if !$member_tz && $banner_event.only_view_tz == 2}
                    <tr class="day_table_time_login bar_user_timezone" style="display:none">
                {/if}
                {if $member_tz && $banner_event.only_view_tz == 1}
                    <tr class="day_table_time_login bar_login_timezone"  style="display:none">
                {/if}
                {if $member_tz && $banner_event.only_view_tz == 2}
                    <tr class="day_table_time_login bar_user_timezone" style="">
                {/if}
            {else}
                <tr>
            {/if}
                <td class="group_day_calendar_banner_head1"><br></td>
                <td class="group_day_calendar_banner_head2" rel="{grn_pageurl page='schedule/simple_add' uid=$schedule.user_id gid=$group_id bdate=$bdate referer_key=$referer_key}" onmouseover="GRN_ScheduleSimpleAdd.mouseOverHandler(event, this);" onmouseout="GRN_ScheduleSimpleAdd.mouseOutHandler(event, this);"><br></td>
                <td class="banner_color group_day_calendar_banner_item" colspan="{$schedule_params.col_span}">{if $banner_event.absent === 1}<div class="schedule_absent">{/if}<div class=""><a href="{grn_pageurl page='schedule/view' event=$banner_event.id bdate=$bdate uid=$schedule.user_id gid=$group_id referer_key=$referer_key}">{grn_image image='banner16.gif'}
{if $banner_event.event_menu_color neq '' && $banner_event.event_menu_color neq '0'}<span class="event_color{$banner_event.event_menu_color}_grn">{$banner_event.event_menu|grn_noescape}</span>{$banner_event.event_detail|grn_noescape}{else}{$banner_event.data|grn_noescape}{/if}{if $banner_event.type == 'share_banner'}{/if}{if $banner_event.report}{grn_image image='report16.gif'}{/if}</a></div>{if $banner_event.absent === 1}</div>{/if}</td>
            </tr>
        {/foreach}
    {/if}
{/foreach}
{/strip}