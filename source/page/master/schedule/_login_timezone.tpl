<tr class="day_table_time_login bar_login_timezone" {if $member_tz}style="display:none"{/if}>
 <td width="22%" class="group_day_calendar_timebar1"><span class='domain'>{cb_msg module='fw.timezone' key=$login_timezone}</span></td>
 <td width="10%" class="group_day_calendar_timebar2"><br></td>
 {grn_schedule_time_header set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' uid=$login_id timezone=$login_timezone bdate=$bdate}
</tr>
<tr class="day_table_time_login bar_login_timezone" {if $member_tz}style="display:none"{/if}>
 <td class="group_day_calendar_timebar_sec1">{grn_image image='spacer1.gif'}</td>
 <td class="group_day_calendar_timebar_sec2">{grn_image image='spacer1.gif'}</td>
 {grn_schedule_time_header2 set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' class_time='n' start_time_hour=$start_time_hour end_time_hour=$end_time_hour start_time_minute=$start_time_minute end_time_minute=$end_time_minute uid=$login_id timezone=$login_timezone bdate=$bdate}
</tr>
