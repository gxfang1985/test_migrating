{php}
    if( is_null($this->get_template_vars('ajax_flag')) )
        $this->assign('ajax_flag',NULL);
{/php}
{if $page_info.last == 'personal_month' && $ajax_flag}
    {assign var=bd_func value='cy_um_bd(this);'}
{/if}
<table border="0" cellspacing="8" cellpadding="2" >
    <tr>
        <td align="right" style="padding-left:6em;" nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-709' replace='true'}{grn_image image='arrow_t30x20.gif'}</td>
        <td style="padding:0em 0.5em;border-right:1px solid #999999;" colspan="2">
            {if $page_info.all == 'schedule/group_day'}
                {capture name='grn_schedule_GRN_SCH_710'}{cb_msg module='grn.schedule' key='GRN_SCH-710' replace='true'}{/capture}
                {grn_link page='schedule/group_day' caption=$smarty.capture.grn_schedule_GRN_SCH_710 image='cal_gday20.gif' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text p=$selected_group_type disabled=ture}
            {else}
                <a href="{grn_pageurl page='schedule/group_day' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text p=$selected_group_type}" {if $ajax_flag}onclick="{$bd_func}"{/if}>{grn_image image='cal_gday20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-711' replace='true'}</a>
            {/if}
        </td>
        <td style="padding:0em 0.5em;border-right:1px solid #999999;"colspan="2">
            {if $page_info.all == 'schedule/index'}
                {capture name='grn_schedule_GRN_SCH_712'}{cb_msg module='grn.schedule' key='GRN_SCH-712' replace='true'}{/capture}
                {grn_link page='schedule/index' caption=$smarty.capture.grn_schedule_GRN_SCH_712 image='cal_gweek20.gif' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text p=$selected_group_type disabled=ture}
            {else}
                <a href="{grn_pageurl page='schedule/index' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text p=$selected_group_type}" {if $ajax_flag}onclick="{$bd_func}"{/if}>{grn_image image='cal_gweek20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-713' replace='true'}</a>
            {/if}
        </td>
    </tr>
    <tr>
        <td align="right">{cb_msg module='grn.schedule' key='GRN_SCH-714' replace='true'}{grn_image image='arrow_t30x20.gif'}</td>
        <td style="padding:0em 0.5em;border-right:1px solid #999999;">
            {if $page_info.all == 'schedule/personal_day'}
                {capture name='grn_schedule_GRN_SCH_715'}{cb_msg module='grn.schedule' key='GRN_SCH-715' replace='true'}{/capture}
                {grn_link page='schedule/personal_day' caption=$smarty.capture.grn_schedule_GRN_SCH_715 image='cal_pday20.gif' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text disabled=ture}
            {else}
                <a href="{grn_pageurl page='schedule/personal_day' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text}" {if $ajax_flag}onclick="{$bd_func}"{/if}>{grn_image image='cal_pday20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-716' replace='true'}</a>
            {/if}
        </td>
        <td style="padding:0em 0.5em;border-right:1px solid #999999;">
            {if $page_info.all == 'schedule/personal_week'}
                {capture name='grn_schedule_GRN_SCH_717'}{cb_msg module='grn.schedule' key='GRN_SCH-717' replace='true'}{/capture}
                {grn_link page='schedule/personal_week' caption=$smarty.capture.grn_schedule_GRN_SCH_717 image='cal_pweek20.gif' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text disabled=ture}
            {else}
                <a href="{grn_pageurl page='schedule/personal_week' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text}" {if $ajax_flag}onclick="{$bd_func}"{/if}>{grn_image image='cal_pweek20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-718' replace='true'}</a>
            {/if}
        </td>
        <td style="padding:0em 0.5em;border-right:1px solid #999999;">
            {if $page_info.all == 'schedule/personal_month'}
                {capture name='grn_schedule_GRN_SCH_719'}{cb_msg module='grn.schedule' key='GRN_SCH-719' replace='true'}{/capture}
                {grn_link page='schedule/personal_month' caption=$smarty.capture.grn_schedule_GRN_SCH_719 image='cal_pmon20.gif' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text disabled=ture}
            {else}
                <a href="{grn_pageurl page='schedule/personal_month' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text}" {if $ajax_flag}onclick="{$bd_func}"{/if}>{grn_image image='cal_pmon20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-720' replace='true'}</a>
            {/if}
        </td>
        <td style="padding:0em 0.5em;">
            {if $page_info.all == 'schedule/personal_year'}
                {capture name='grn_schedule_GRN_SCH_721'}{cb_msg module='grn.schedule' key='GRN_SCH-721' replace='true'}{/capture}
                {grn_link page='schedule/personal_year' caption=$smarty.capture.grn_schedule_GRN_SCH_721 image='cal_pyear20.gif' event=$event_id bdate=$bdate uid=$user_id gid=$group_id disabled=ture search_text=$search_text}
            {else}
                <a href="{grn_pageurl page='schedule/personal_year' event=$event_id bdate=$bdate uid=$user_id gid=$group_id search_text=$search_text}" {if $ajax_flag}onclick="{$bd_func}"{/if}>{grn_image image='cal_pyear20.gif'}{cb_msg module='grn.schedule' key='GRN_SCH-722' replace='true'}</a>
            {/if}
        </td>
    </tr>
</table>
