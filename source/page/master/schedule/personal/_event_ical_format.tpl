BEGIN:VCALENDAR
PRODID:Cybozu Web Calendar
VERSION:2.0
{foreach from=$events item=event key=event_id}
{if $event.private !== GRN_EVENT_PRIVATE_HIDDEN}
BEGIN:VEVENT
UID:GAROON_SCHEDULE:{$uuid}_{$event_id}
{*If repeat event*}
{if $event.repeat }
{if $event.allday}
DTSTART:{grn_date_format date=$event.setdate format="Date_YYYYMMDD_ICS"}
DTEND:{grn_date_format date=$event.date_setend format="Date_YYYYMMDD_ICS"}
{if $event.GRN_REPEAT_TYPE_DAY}
RRULE:FREQ=DAILY;UNTIL={grn_date_format date=$event.until format="Date_YYYYMMDD_ICS"};WKST=SU
{elseif $event.GRN_REPEAT_TYPE_WEEKDAY}
RRULE:FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR;UNTIL={grn_date_format date=$event.until format="Date_YYYYMMDD_ICS"};WKST=SU
{elseif $event.GRN_REPEAT_TYPE_WEEK}
RRULE:FREQ=WEEKLY;BYDAY={$event.repeat_wday};UNTIL={grn_date_format date=$event.until format="Date_YYYYMMDD_ICS"};WKST=SU
{elseif $event.GRN_REPEAT_TYPE_MONTH}
RRULE:FREQ=MONTHLY;WKST=SU;BYMONTHDAY={$event.repeat_day};UNTIL={grn_date_format date=$event.until format="Date_YYYYMMDD_ICS"}
{/if}
{else}
DTSTART:{grn_date_format date=$event.setdatetime format="DateTime_YYYYMMDD_ICS"}
DTEND:{grn_date_format date=$event.dtend_datetime format="Date_YYYYMMDD_ICS"}T{grn_date_format date=$event.enddatetime format="TimeShort_ICS"}
{if $event.GRN_REPEAT_TYPE_DAY}
RRULE:FREQ=DAILY;UNTIL={grn_date_format date=$event.until format="DateTime_YYYYMMDD_ICS"};WKST=SU
{elseif $event.GRN_REPEAT_TYPE_WEEKDAY}
RRULE:FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR;UNTIL={grn_date_format date=$event.until format="DateTime_YYYYMMDD_ICS"};WKST=SU
{elseif $event.GRN_REPEAT_TYPE_WEEK}
RRULE:FREQ=WEEKLY;BYDAY={$event.repeat_wday};UNTIL={grn_date_format date=$event.until format="DateTime_YYYYMMDD_ICS"};WKST=SU
{elseif $event.GRN_REPEAT_TYPE_MONTH}
RRULE:FREQ=MONTHLY;WKST=SU;BYMONTHDAY={$event.repeat_day};UNTIL={grn_date_format date=$event.until format="DateTime_YYYYMMDD_ICS"}
{/if}
{/if}
{if $event.EXDATE}
EXDATE:{$event.EXDATE}
{/if}
{if $event.event_menu}
SUMMARY:{$event.event_menu|grn_noescape}:{$event.event_detail|grn_noescape}
{else}
SUMMARY:{$event.event_detail|grn_noescape}
{/if}
DESCRIPTION:{$event.memo|grn_noescape}
{elseif $event.banner}{*if banner event*}
DTSTART:{grn_date_format date=$event.setdate format="Date_YYYYMMDD_ICS"}
DTEND:{grn_date_format date=$event.enddate format="Date_YYYYMMDD_ICS"}
{if $event.event_menu}
SUMMARY:{$event.event_menu|grn_noescape}:{$event.event_detail|grn_noescape}
{else}
SUMMARY:{$event.event_detail|grn_noescape}
{/if}
DESCRIPTION:{$event.memo|grn_noescape}
{else}{* if normal event *}
{if $event.allday}
DTSTART:{grn_date_format date=$event.setdate format="Date_YYYYMMDD_ICS"}
DTEND:{grn_date_format date=$event.date_endend format="Date_YYYYMMDD_ICS"}
{else}
DTSTART:{grn_date_format date=$event.setdatetime format="DateTime_YYYYMMDD_ICS"}
DTEND:{grn_date_format date=$event.enddatetime format="DateTime_YYYYMMDD_ICS"}
{/if}
{if $event.event_menu}
SUMMARY:{$event.event_menu|grn_noescape}:{$event.event_detail|grn_noescape}
{else}
SUMMARY:{$event.event_detail|grn_noescape}
{/if}
DESCRIPTION:{$event.memo|grn_noescape}
{/if}
END:VEVENT
{/if}
{/foreach}
END:VCALENDAR
