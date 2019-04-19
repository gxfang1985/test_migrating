{capture assign='message_start_of_attendee'}{cb_msg module='grn.report' key='GRN_RPRT-132' replace='true'}{/capture}
{capture assign='num_of_attendee'}{$report_addressee_num}{/capture}
{capture assign='message_end_of_attendee'}{cb_msg module='grn.report' key='GRN_RPRT-133' replace='true'}{/capture}
{capture assign='id_when_list_of_attendee_closed'}display_addressee_close{/capture}
{capture assign='message_when_attendee_is_so_many'}{cb_msg module='grn.report' key='GRN_RPRT-134' replace='true'}{/capture}
{capture assign='message_of_display_on'}{cb_msg module='grn.report' key='GRN_RPRT-135' replace='true'}{/capture}
{capture assign='execute_open_list_of_attendee_javascript'}javascript:void(0);display_on_off('display_addressee_close:display_addressee_open:display_swith_image_open:display_swith_image_close'){/capture}
{capture assign='display_all_of_attendee'}{cb_msg module='grn.report' key='display_notification' replace='true'}{/capture}
{capture assign='display_all_of_attendee_end'}{cb_msg module='grn.report' key='GRN_RPRT-137' replace='true'}{/capture}
{capture assign='id_when_list_of_attendee_open'}display_addressee_open{/capture}
{capture assign='message_of_display_off'}{cb_msg module='grn.report' key='GRN_RPRT-138' replace='true'}{/capture}
{capture assign='execute_close_list_of_attendee_javascript'}javascript:void(0);display_on_off('display_addressee_close:display_addressee_open:display_swith_image_open:display_swith_image_close'){/capture}
{capture assign='message_of_display_hide'}{cb_msg module='grn.report' key='hide_notification' replace='true'}{/capture}
{capture assign='message_of_display_hide_end'}{cb_msg module='grn.report' key='GRN_RPRT-140' replace='true'}{/capture}
{include file='grn/list_of_attendee.tpl' addressees=$report_addressee}
