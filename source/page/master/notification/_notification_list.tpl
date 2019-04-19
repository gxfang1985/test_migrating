<table class="list_column">
    {if $available_space}
    <colgroup>
        <col width="3%">
        <col width="32%">
        <col width="15%">
        <col width="20%">
        <col width="15%">
        <col width="15%">
    </colgroup>
    <tr>
        <th nowrap></th>
        <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-72' replace='true'}</th>
        <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-187' replace='true'}</th>
        <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-73' replace='true'}</th>
    {else}
    <colgroup>
        <col width="3%">
        <col width="32%">
        <col width="25%">
        <col width="20%">
        <col width="15%">
    </colgroup>
    <tr>
        <th nowrap></th>
        <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-72' replace='true'}</th>
        <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-73' replace='true'}</th>
        {/if}
        <th nowrap>
            {if $sort != 'name'}
                {capture name='grn_notification_GRN_NTFC_74'}{cb_msg module='grn.notification' key='GRN_NTFC-74' replace='true'}{/capture}
                {include file="notification/_title_sort.tpl" title=$smarty.capture.grn_notification_GRN_NTFC_74 sort="name" reverse="1" image="sortup16_n.gif"}
            {elseif ! $reverse}
                {capture name='grn_notification_GRN_NTFC_75'}{cb_msg module='grn.notification' key='GRN_NTFC-75' replace='true'}{/capture}
                {include file="notification/_title_sort.tpl" title=$smarty.capture.grn_notification_GRN_NTFC_75 sort="name" reverse="1" image="sortup16.gif"}
            {else}
                {capture name='grn_notification_GRN_NTFC_76'}{cb_msg module='grn.notification' key='GRN_NTFC-76' replace='true'}{/capture}
                {include file="notification/_title_sort.tpl" title=$smarty.capture.grn_notification_GRN_NTFC_76 sort="name" reverse="0" image="sortdown16.gif"}
            {/if}
        </th>
        <th nowrap>
            {if $sort != 'time'}
                {capture name='grn_notification_GRN_NTFC_77'}{cb_msg module='grn.notification' key='GRN_NTFC-77' replace='true'}{/capture}
                {include file="notification/_title_sort.tpl" title=$smarty.capture.grn_notification_GRN_NTFC_77 sort="time" reverse="1" image="sortup16_n.gif"}
            {elseif ! $reverse}
                {capture name='grn_notification_GRN_NTFC_78'}{cb_msg module='grn.notification' key='GRN_NTFC-78' replace='true'}{/capture}
                {include file="notification/_title_sort.tpl" title=$smarty.capture.grn_notification_GRN_NTFC_78 sort="time" reverse="1" image="sortup16.gif"}
            {else}
                {capture name='grn_notification_GRN_NTFC_79'}{cb_msg module='grn.notification' key='GRN_NTFC-79' replace='true'}{/capture}
                {include file="notification/_title_sort.tpl" title=$smarty.capture.grn_notification_GRN_NTFC_79 sort="time" reverse="0" image="sortdown16.gif"}
            {/if}
        </th>
    </tr>
    {if $available_space}
        {foreach from=$notify_list.data_list item=notify}
            <tr class="{cycle values='linetwo,lineone'}">
                {grn_notification_data_row
                    notify=$notify
                    data_type=$data_type
                    subject_cols=$subject_cols
                    space_cols=$space_cols
                    abstract_cols=$abstract_cols
                    name_cols=$name_cols
                    checkbox=1
                    no_abstract=$no_abstract
                    no_name=$no_name
                    no_date=$no_date
                    users_info=$users_info}
            </tr>
        {/foreach}
    {else}
        {foreach from=$notify_list.data_list item=notify}
            <tr class="{cycle values='linetwo,lineone'}">
                {grn_notification_data_row
                    notify=$notify
                    data_type=$data_type
                    subject_cols=$subject_cols
                    space_cols=$space_cols
                    abstract_cols=$abstract_cols
                    name_cols=$name_cols
                    checkbox=1
                    no_space_name=true
                    no_abstract=$no_abstract
                    no_name=$no_name
                    no_date=$no_date
                    users_info=$users_info}
            </tr>
        {/foreach}
    {/if}
</table>
{if $show_no_notification_message}
<div class="list_message_grn">
    <div class="list_message_balloon_grn">
        {if $show_has_unread_all}
            {cb_msg module='grn.notification' key='GRN_NTFC-206' replace='true'}<a class="js_has_unread_all" href="javascript:void(0)"><span class="bold_grn">{cb_msg module='grn.notification' key='GRN_NTFC-207' replace='true'}</span></a>{cb_msg module='grn.notification' key='GRN_NTFC-208' replace='true'}
        {else}
            <span class="bold_grn">{cb_msg module='grn.notification' key='GRN_NTFC-205' replace='true'}</span>
        {/if}
    </div>
    <div class="balloon_arrow_down_grn"></div>
    <div class="list_message_icon_grn">
        <span class="message_middle_icon_size_grn notify_message_middle_icon_grn"></span>
    </div>
</div>
{/if}