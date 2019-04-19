{assign var='form_name' value=$smarty.template|basename}
{include file='system/calendar/base/_base_input.tpl'
    form_name=$form_name
    page_title=$page_title
    page_info=$page_info
    action_page='system/calendar/base/command_base_add'
    base=$base
    calendars=$calendars
    minute_interval=$minute_interval
}
