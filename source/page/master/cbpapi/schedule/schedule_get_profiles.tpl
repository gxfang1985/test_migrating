{include file="cbpapi/header.tpl"}
    <schedule:ScheduleGetProfilesResponse>
    <returns>
        {*<personal_profile
          start_time_in_dayview="{$profile.start_time_in_dayview}"
          end_time_in_dayview="{$profile.end_time_in_dayview}"
          show_sunday="{$profile.show_sunday}"
          show_end_time="{$profile.show_end_time}"
          plan_menu="{$profile.plan_menu}"
          notify_mail="{$profile.notify_mail}"
          is_user_address_mail="{$profile.is_user_address_mail}"
          notify_mail_address="$profile.notify_mail_address} />
        </personal_profile>*}
        {include file="cbpapi/schedule/_personal_profile.tpl"}
        {if $include_system_profile}
        <system_profile
          {grn_attr name="plan_menu" value=$sys.plan_menu}
          {grn_attr name="event_reserve_unit" value=$sys.event_reserve_unit require=true}
          {grn_attr name="event_repeat_max_time" value=$sys.event_repeat_max_time require=true}
          {grn_attr name="register_private_event" value=$sys.register_private_event require=true}
          {grn_attr name="show_memo" value=$sys.show_memo require=true}
          {grn_attr name="show_private_event" value=$sys.show_private_event require=true}
          {grn_attr name="managed_notify" value=$sys.managed_notify require=true}
          {grn_attr name="show_group_event" value=$sys.show_group_event require=true}
          {grn_attr name="show_holiday" value=$sys.show_holiday require=true}
          {grn_attr name="allow_file_attachment" value=$sys.allow_file_attachment require=true}
          {grn_attr name="allow_attendance_check" value=$sys.allow_attendance_check require=true}
          {grn_attr name="visibility_default" value=$sys.visibility_default}>
        </system_profile>
        {/if}
    </returns>
    </schedule:ScheduleGetProfilesResponse>
{include file="cbpapi/footer.tpl"}