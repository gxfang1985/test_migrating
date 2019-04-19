{include file='grn/popup_head.tpl'}
<div class="marginBoth">
<table class="layout comfirmVacantTimeHeader-grn">
<tr> 
<td align="left">{grn_title title=$page_title class=$page_info.parts[0]}</td>
<td align="right"><a href="#" onclick="window.close();">{grn_image image='close20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}</a></td>
</tr>
</table>
</div>
{grn_load_css file="grn/html/schedule.css"}
{grn_load_css file="grn/html/schedule_confirm.css"}

{assign var='form_name' value=$smarty.template|basename}
{include file="schedule/_show_full_short_title.tpl" function_click="showFullShortTitle('show_full_titleconfirm','schedule_confirm','confirm',true);" schedule_id='schedule_confirm'}
{*{include file="schedule/_show_hide_absent_schedule.tpl"}*}
{grn_load_javascript file="grn/html/schedule_confirm.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_info.all}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input id="bdate" type="hidden" name="bdate" value="{$bdate|escape}">
    <input type="hidden" name="uid" value="{$user_id|escape}">
    <input type="hidden" name="gid" value="{$group_id|escape}">
    <input type="hidden" name="parent_page_name" value="{$parent_page_name|escape}">
    <input type="hidden" name="hide_display_time_set" value="{$hide_display_time_set}">
    
    <div id="one_parts">
        <div id="view">
            <div class="margin_bottom">
                <div class="comfirmVacantTimeDate-grn">
                    <span class="displaydate">{grn_date_format date=$bdate format="DateFull_YMDW"}</span>
                    {if $isDisplayTimeSetElement}
                        {grn_select_time prefix='start_' minute_interval=$minute_interval time=$start_time onchange="setEndTime(this.id)"}
                        {cb_msg module='grn.schedule' key='GRN_SCH-137' replace='true'}
                        {grn_select_time prefix='end_' minute_interval=$minute_interval time=$end_time}
                        <span class="buttonPostMainSmall-grn mLeft5">
                            <div class="buttonPostMain-grn">
                                <a href="javascript:reflectTime('{$isSetParentDate}')">{cb_msg module='grn.schedule' key='GRN_SCH-911' replace='true'}</a>
                            </div>
                        </span>
                    {/if}
                </div>
                <table width="100%">
                    <tr>
                        <td nowrap>
                            {if $group}
                                <select name="gid" onChange="i=this.selectedIndex;v=this.options[i].value;if(v)this.form.submit()">
                                    {if $selected_group}
                                        <option value="{$selected_group.id}" selected>{$selected_group.name|escape}</option>
                                    {/if}
                                    {foreach from=$group key=gid item=group}
                                        {if (string)$group_id === (string)$gid}
                                            <option value="{$gid}" selected>{$group|escape}</option>
                                        {else}
                                            <option value="{$gid}">{$group|escape}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            {/if}

                            {if $member}
                                <select name="uid" onChange="this.form.submit()">
                                    {if $selected_member}
                                        <option value="{$selected_member.id}" selected>{$selected_member.name}</option>
                                    {/if}
                                    {foreach from=$member key=uid item=member}
                                        {if (string)$user_id === (string)$uid}
                                            <option value="{$uid}" selected>{$member|grn_noescape}</option>
                                        {else}
                                            <option value="{$uid}">{$member|grn_noescape}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            {/if}
                        </td>
                        <td align="right" nowrap>
                            <div class="moveButtonBlock-grn">
                            {strip}
                                <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-227' replace='true'}">
                                    <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$bdate_prevweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape timezone=$timezone end_timezone=$end_timezone}')">
                                        <span class="moveButtonArrowLeftTwo-grn"></span>
                                    </a>
                                </span>
                                <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-229' replace='true'}">
                                    <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$bdate_prevday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape timezone=$timezone end_timezone=$end_timezone}')">
                                        <span class="moveButtonArrowLeft-grn"></span>
                                    </a>
                                </span>
                                <span class="moveButtonBase-grn" title="">
                                    <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$date uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape timezone=$timezone end_timezone=$end_timezone}')">
                                        {cb_msg module='grn.schedule' key='GRN_SCH-230' replace='true'}
                                    </a>
                                </span>
                                <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-231' replace='true'}">
                                    <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$bdate_nextday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape timezone=$timezone end_timezone=$end_timezone}')">
                                        <span class="moveButtonArrowRight-grn"></span>
                                    </a>
                                </span>
                                <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-233' replace='true'}">
                                    <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$bdate_nextweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape timezone=$timezone end_timezone=$end_timezone}')">
                                        <span class="moveButtonArrowRightTwo-grn"></span>
                                    </a>
                                </span>
                            {/strip}
                            </div>
                            {include file='schedule/_display_options.tpl' page_key='confirm' schedule_id='schedule_confirm' confirm='true' plid='confirm' show_full_title_option='true' apply_users_timezone='true'}
                        </td>
                    </tr>
                </table>
            </div>
            {include file="schedule/_schedule_navi_calendar_js.tpl"}

            <div class="divWrapper">
                <table id="schedule_confirm" class="day_table scheduleWrapper scheduleWrapperTimezoneBar {if !$show_full_title}hideEventTitle tableFixed{/if} {if $show_absent_schedule == 0}hideScheduleAbsent{/if} available_time_base">
                    {capture assign="bar_login_timezone"}{include file="schedule/_login_timezone.tpl"}{/capture}
                    {foreach name=schedule from=$schedule.users item=schedule}
                        {if ($smarty.foreach.schedule.iteration-1)%5 == 0}
                            {if $smarty.foreach.schedule.iteration != 1}
                                <tr>
                                    <td class="available_time_navi_head"><a name="{$smarty.foreach.schedule.iteration}">&nbsp;</a></td>
                                    <td class="available_time_navi_head">&nbsp;</td>
                                    <td class="available_time_navi" colspan="{$schedule_params.col_span}" align="right" nowrap>
                                        {strip}
                                        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-227' replace='true'}">
                                            <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$bdate_prevweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape}','#{$smarty.foreach.schedule.iteration}')">
                                                <span class="moveButtonArrowLeftTwo-grn"></span>
                                            </a>
                                        </span>
                                        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-229' replace='true'}">
                                            <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$bdate_prevday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape}','#{$smarty.foreach.schedule.iteration}')">
                                                <span class="moveButtonArrowLeft-grn"></span>
                                            </a>
                                        </span>
                                        <span class="moveButtonBase-grn" title="">
                                            <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$date uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape}','#{$smarty.foreach.schedule.iteration}')">
                                                {cb_msg module='grn.schedule' key='GRN_SCH-230' replace='true'}
                                            </a>
                                        </span>
                                        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-231' replace='true'}">
                                            <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$bdate_nextday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape}','#{$smarty.foreach.schedule.iteration}')">
                                                <span class="moveButtonArrowRight-grn"></span>
                                            </a>
                                        </span>
                                        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-233' replace='true'}">
                                            <a href="javascript:moveCalendar('{grn_pageurl page=$page_info.all bdate=$bdate_nextweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type hide_display_time_set=$hide_display_time_set|escape parent_page_name=$parent_page_name|escape}','#{$smarty.foreach.schedule.iteration}')">
                                                <span class="moveButtonArrowRightTwo-grn"></span>
                                            </a>
                                        </span>
                                        {/strip}
                                    </td>
                                </tr>
                            {/if}
                        {/if}
                        <tr class="day_table_time_login bar_user_timezone" {if !$member_tz}style="display:none"{/if}>
                            <td class="group_day_calendar_timebar1"><span class='domain'>{cb_msg module='fw.timezone' key=$schedule.timezone}</span></td>
                            <td class="group_day_calendar_timebar2"><br></td>
                            {grn_schedule_time_header set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' uid=$schedule.user_id timezone=$schedule.timezone bdate=$bdate}
                        </tr>
                        <tr class="day_table_time_login bar_user_timezone" {if !$member_tz}style="display:none"{/if}>
                            <td class="group_day_calendar_timebar_sec1">{grn_image image='spacer1.gif'}</td>
                            <td class="group_day_calendar_timebar_sec2">{grn_image image='spacer1.gif'}</td>
                            {grn_schedule_time_header2 set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' class_time='n' start_time_hour=$start_time_hour end_time_hour=$end_time_hour start_time_minute=$start_time_minute end_time_minute=$end_time_minute uid=$schedule.user_id timezone=$schedule.timezone bdate=$bdate}
                        </tr>
                        {$bar_login_timezone|grn_noescape}
                        <tr>
                            <td class="group_day_calendar_user" class="userBox">
                                {if $schedule.facility_id}
                                    {grn_image image='facility20.gif'}{$schedule.facility_title|escape}&nbsp;<br>
                                    {$schedule.facility_memo|grn_noescape}
                                {else}
                                    <div class="userElement"><span class="span_user">{grn_schedule_member_name id=$schedule.user_id nolink=true users_info=$users_info groups_info=$groups_info}</span></div>
                                    {if $login_timezone != $schedule.timezone}<span class='domain'>{cb_msg module='fw.timezone' key=$schedule.timezone}</span>{else}&nbsp;<br>{/if}
                                {/if}
                            </td>
                            <td class="normalEvent group_day_calendar_event_cell">
                                {if $schedule.schedule_event.calendar}
                                    {foreach from=$schedule.schedule_event.calendar item=calendar}
                                        {if $calendar.type != "weather"}
                                            {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon class="group_day_calendar_event_item"}
                                        {/if}
                                    {/foreach}
                                {/if}
                                {if $schedule.schedule_event.event}
                                    {foreach from=$schedule.schedule_event.event item=event}
                                        {if $event.allday}
                                            {if ! $event.private}<div class="normalEventElement">{/if}
                                            {grn_image image="allday.gif"}
                                            <a href="{grn_pageurl page='schedule/view' event=$event.id}" target="_blank">
                                            {if $event.attendance_check_show}
                                                {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                                                {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                                            {/if}
                                            {if $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                                                <span class="event_color{$event.event_menu_color}_grn">
                                                    {$event.event_menu|grn_noescape}
                                                </span>
                                                {$event.event_detail|grn_noescape}
                                            {else}
                                                {$event.data|grn_noescape}

                                                {/if}
                                            </a>{if $event.is_private}
                                            {grn_image image="image-common/privateMark_sub16.png"}

                                            {/if}{if $event.type == 'share_repeat' || $event.type == 'repeat'}{grn_image image="repeat16.gif"}{/if}
                                            {if ! $event.private}</div>{/if}
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
                                access=$confirm
                                disable_link=false
                                facility_id=$schedule.facility_id
                                timezone=$schedule.timezone
                                target='blank'
                            }
                        </tr>
                        {foreach from=$schedule.schedule_event.event item=event}
                            {if $event.conflict}
                                <tr>
                                    <td class="group_day_calendar_conflict_head1"><br></td>
                                    <td class="group_day_calendar_conflict_head2"><br></td>
                                    {grn_schedule_group_day_conflict 
                                    menu=$event.event_menu 
                                    menu_color=$event.event_menu_color 
                                    detail=$event.event_detail 
                                    facility_name=$event.event_facility_name 
                                    facility_after = $event.facility_name_after
                                    start_date=$event.start_date 
                                    end_date=$event.end_date 
                                    page='schedule/view' 
                                    event=$event.id 
                                    bdate=$schedule.schedule_event.date 
                                    uid=$schedule.user_id 
                                    gid=$group_id 
                                    unit=$schedule_params.unit 
                                    set_hour=$schedule_params.set_hour 
                                    end_hour=$schedule_params.end_hour 
                                    private=$event.private 
                                    title=$event.data 
                                    disable_link=false 
                                    timezone=$schedule.timezone 
                                    target='blank'
                                    attendance_check_show=$event.attendance_check_show
                                    }
                                </tr>
                            {/if}
                        {/foreach}
                        {if $schedule.banner_event}
                            {foreach from=$schedule.banner_event item=banner_event}
                                <tr>
                                    <td class="group_day_calendar_banner_head1"><br></td>
                                    <td class="group_day_calendar_banner_head2"><br></td>
                                    <td class="group_day_calendar_banner_item banner_color" colspan="{$schedule_params.col_span}"><a href="{grn_pageurl page='schedule/view' event=$banner_event.id}" target="_blank" >{grn_image image='banner16.gif'}{if $banner_event.event_menu_color neq '' && $banner_event.event_menu_color neq '0'}<span class="event_color{$banner_event.event_menu_color}_grn">{$banner_event.event_menu|grn_noescape}</span>{$banner_event.event_detail|grn_noescape}{else}{$banner_event.data|grn_noescape}{/if}</a></td>
                                </tr>
                            {/foreach}
                        {/if}
                    {/foreach}
                </table>
                
                <div id="color_tip">
                    <div class="color_tip_block"></div>
                    <div class="color_tip_description">{cb_msg module='grn.schedule' key='GRN_SCH-913' replace='true'}</div>
                </div>
            </div>
            <div class="none">&nbsp;</div>
        </div>
        <!--view_end--->
    </div>
</form>
<script language="JavaScript" type="text/javascript">
<!--
    window.focus();
//-->
</script>
{include file='grn/popup_footer.tpl'}
