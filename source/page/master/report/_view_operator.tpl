{if $operator_set || count($report_addressee) > 0}
    {capture assign='message_start_of_attendee'}{cb_msg module='grn.report' key='GRN_RPRT-245' replace='true'}{/capture}
    {capture assign='num_of_attendee'}{$report_addressee_num}{/capture}
    {capture assign='message_end_of_attendee'}{cb_msg module='grn.report' key='GRN_RPRT-246' replace='true'}{/capture}
    {capture assign='id_when_list_of_attendee_closed'}display_operator_addressee_close{/capture}
    {capture assign='message_when_attendee_is_so_many'}{cb_msg module='grn.report' key='GRN_RPRT-247' replace='true'}{/capture}
    {capture assign='message_of_display_on'}{cb_msg module='grn.report' key='GRN_RPRT-248' replace='true'}{/capture}
    {capture assign='execute_open_list_of_attendee_javascript'}javascript:void(0);display_on_off('display_operator_addressee_close:display_operator_addressee_open:display_operator_swith_image_open:display_operator_swith_image_close'){/capture}
    {capture assign='display_all_of_attendee'}{cb_msg module='grn.report' key='display_operator' replace='true'}{/capture}
    {capture assign='display_all_of_attendee_end'}{cb_msg module='grn.report' key='GRN_RPRT-250' replace='true'}{/capture}
    {capture assign='id_when_list_of_attendee_open'}display_operator_addressee_open{/capture}
    {capture assign='message_of_display_off'}{cb_msg module='grn.report' key='GRN_RPRT-251' replace='true'}{/capture}
    {capture assign='execute_close_list_of_attendee_javascript'}javascript:void(0);display_on_off('display_operator_addressee_close:display_operator_addressee_open:display_operator_swith_image_open:display_operator_swith_image_close'){/capture}
    {capture assign='message_of_display_hide'}{cb_msg module='grn.report' key='hide_operator' replace='true'}{/capture}
    {capture assign='message_of_display_hide_end'}{cb_msg module='grn.report' key='GRN_RPRT-253' replace='true'}{/capture}
    {include file='grn/list_of_attendee.tpl' addressees=$report_addressee}
{else}
    {cb_msg module='grn.report' key='only_creator' replace='true'}
{/if}
