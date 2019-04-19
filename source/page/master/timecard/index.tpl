{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='timecard/_title_search.tpl' page_title=$page_title}
<div class="mainarea">
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='timecard/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div id="main_menu_part">
        <span class="menu_item">{capture name='grn_timecard_GRN_TIM_2'}{cb_msg module='grn.timecard' key='GRN_TIM-2' replace='true'}{/capture}{grn_link page='timecard/export' caption=$smarty.capture.grn_timecard_GRN_TIM_2 image='export20.gif' date=$date.value}</span>
        <span class="menu_item">{capture name='grn_timecard_GRN_TIM_3'}{cb_msg module='grn.timecard' key='GRN_TIM-3' replace='true'}{/capture}{grn_link page='timecard/print' caption=$smarty.capture.grn_timecard_GRN_TIM_3 image='print20.gif' date=$date.value}</span>
    </div>

    <p>
    <span class="bold">{grn_user_name uid=$user_id name=$user_name nolink=1 noimage=1}</span> {cb_msg module='grn.timecard' key='GRN_TIM-4' replace='true'}{grn_appname app_id='timecard'}

    <div class="margin_vert">
        <b>{$date.year}{cb_msg module='grn.timecard' key='GRN_TIM-5' replace='true'}{$date.month|string_format:"%02d"}{cb_msg module='grn.timecard' key='GRN_TIM-6' replace='true'}</b>
        &nbsp;<button onclick="location.href='{grn_pageurl page=$page_info.all date=$date.prev}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_back_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button>
        <button onclick="location.href='{grn_pageurl page=$page_info.all }';return false;"> {cb_msg module='grn.timecard' key='GRN_TIM-52' replace='true'} </button>
        <button onclick="location.href='{grn_pageurl page=$page_info.all date=$date.next}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_next_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button>
        {capture name='grn_timecard_GRN_TIM_58'}
            {cb_msg module='grn.timecard' key='GRN_TIM-58' replace='true'}
        {/capture}
        <span class="mLeft10 vAlignMiddle-grn">{grn_checkbox id="show_timecard_ip" name="show_timecard_ip" value="1" caption=$smarty.capture.grn_timecard_GRN_TIM_58 onclick="display_on_off_check_by_name(this, 'timecard_ip')"}</span>
    </div>

    <table class="timecard">
        <tr>
            <th nowrap width="50"><nobr>{cb_msg module='grn.timecard' key='GRN_TIM-7' replace='true'}</nobr></th>
            <th nowrap width="50"><nobr>{cb_msg module='grn.timecard' key='GRN_TIM-8' replace='true'}</nobr></th>
            <th nowrap width="50"><nobr>{cb_msg module='grn.timecard' key='GRN_TIM-9' replace='true'}</nobr></th>
            {foreach from=$config.absence_max_list item=value}
                <th nowrap width="50"><nobr>{cb_msg module='grn.timecard' key='GRN_TIM-10' replace='true'}</nobr></th>
                <th nowrap width="50"><nobr>{cb_msg module='grn.timecard' key='GRN_TIM-11' replace='true'}</nobr></th>
            {/foreach}
            <th nowrap width="100"><nobr>{cb_msg module='grn.timecard' key='GRN_TIM-12' replace='true'}</nobr></th>
        </tr>
        {foreach from=$timecards item=card}
            <tr valign="top">
                <td nowrap class="{$card.class} tAlignRight-grn">{grn_timecard_date date=$card.date}</td>
                <td nowrap class="{$card.class} tAlignCenter-grn">
                    {if $card.start}
                        {grn_date_format format='TimeShort_HM' date=$card.start}
                        {if $card.start_ip}
                            <div id="timecard_ip" name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$card.start_ip}</div>
                        {/if}
                    {elseif $card.today}
                        <input type="submit" name="start" value="{cb_msg module='grn.timecard' key='GRN_TIM-13' replace='true'}"><input type="hidden" name="date" value="{$card.date}">
                    {else}
                        <br>
                    {/if}
                </td>
                <td nowrap class="{$card.class} tAlignCenter-grn">
                    {if $card.finish}
                        {grn_date_format format='TimeShort_HM' date=$card.finish}
                        {if $card.finish_ip}
                            <div id="timecard_ip" name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$card.finish_ip}</div>
                        {/if}
                    {elseif $card.today && $card.start}
                        <input type="submit" name="finish" value="{cb_msg module='grn.timecard' key='GRN_TIM-14' replace='true'}"><input type="hidden" name="date" value="{$card.date}">
                    {else}
                        <br>
                    {/if}
                </td>

                {assign var="show_button" value=""}
                {foreach name="absences" from=$card.absences item=absence}
                    <td nowrap class="{$card.class} tAlignCenter-grn">
                        {if $absence.trip}
                            {grn_date_format format='TimeShort_HM' date=$absence.trip}
                            {if $absence.trip_ip}
                                <div id="timecard_ip" name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$absence.trip_ip}</div>
                            {/if}
                        {elseif $card.today && ! $show_button && $card.start && ! $card.finish}
                            <input type="submit" name="trip" value="{cb_msg module='grn.timecard' key='GRN_TIM-15' replace='true'}"><input type="hidden" name="date" value="{$card.date}">
                            {assign var="show_button" value="1"}
                        {else}
                            <br>
                        {/if}
                    </td>
                    <td nowrap class="{$card.class} tAlignCenter-grn">
                        {if $absence.back}
                            {grn_date_format format='TimeShort_HM' date=$absence.back}
                            {if $absence.back_ip}
                                <div id="timecard_ip" name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$absence.back_ip}</div>
                            {/if}
                        {elseif $card.today && ! $show_button && $card.start && ! $card.finish && $absence.trip}
                            <input type="submit" name="back" value="{cb_msg module='grn.timecard' key='GRN_TIM-16' replace='true'}"><input type="hidden" name="date" value="{$card.date}">
                            {assign var="show_button" value="1"}
                        {else}
                            <br>
                        {/if}
                    </td>
                {/foreach}
                <td nowrap class="{$card.class}">
                    {grn_link image='write20.gif' page='timecard/modify' caption='' date=$card.date}
                    {$card.remarks|escape}
                </td>
            </tr>
        {/foreach}
    </table>
</form>

{include file="grn/footer.tpl"}
