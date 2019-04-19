{capture assign='message_start_of_attendee'}{cb_msg module='grn.message' key='GRN_MSG-351' replace='true'}{/capture}
{capture assign='num_of_attendee'}{$message_addressee_num}{/capture}
{capture assign='message_end_of_attendee'}{cb_msg module='grn.message' key='GRN_MSG-352' replace='true'}{/capture}
{capture assign='id_when_list_of_attendee_closed'}display_addressee_close{/capture}
{capture assign='message_when_attendee_is_so_many'}{cb_msg module='grn.message' key='GRN_MSG-353' replace='true'}{/capture}
{capture assign='message_of_display_on'}{cb_msg module='grn.message' key='GRN_MSG-354' replace='true'}{/capture}
{capture assign='execute_open_list_of_attendee_javascript'}javascript:void(0);display_on_off('display_addressee_close:display_addressee_open:display_swith_image_open:display_swith_image_close'){/capture}
{capture assign='display_all_of_attendee'}{cb_msg module='grn.message' key='GRN_MSG-355' replace='true'}{/capture}
{capture assign='display_all_of_attendee_end'}{cb_msg module='grn.message' key='GRN_MSG-356' replace='true'}{/capture}
{capture assign='id_when_list_of_attendee_open'}display_addressee_open{/capture}
{capture assign='message_of_display_off'}{cb_msg module='grn.message' key='GRN_MSG-357' replace='true'}{/capture}
{capture assign='execute_close_list_of_attendee_javascript'}javascript:void(0);display_on_off('display_addressee_close:display_addressee_open:display_swith_image_open:display_swith_image_close'){/capture}
{capture assign='message_of_display_hide'}{cb_msg module='grn.message' key='GRN_MSG-358' replace='true'}{/capture}
{capture assign='message_of_display_hide_end'}{cb_msg module='grn.message' key='GRN_MSG-359' replace='true'}{/capture}
{include file='grn/list_of_attendee.tpl' addressees=$message_addressee}
