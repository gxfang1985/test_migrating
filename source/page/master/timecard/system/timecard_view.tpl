{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_timecard_system_GRN_TIM_SY_47'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-47' replace='true'}{/capture}{grn_link page='timecard/system/timecard_export' caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_47 image='export20.gif' uid=$user_id date=$date.value oid=$org_id}</span>
<span class="menu_item">{capture name='grn_timecard_system_GRN_TIM_SY_48'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-48' replace='true'}{/capture}{grn_link page='timecard/system/timecard_print' caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_48 image='print20.gif' uid=$user_id date=$date.value oid=$org_id}</span>
</div>

<p>
<span class="bold">{grn_user_name uid=$user_id name=$user_name nolink=1 noimage=1}</span> {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-49' replace='true'}{grn_appname app_id='timecard'}

<div class="margin_vert">
    <span class="bold">{$date.year}&nbsp;/&nbsp;{$date.month|string_format:"%02d"}</span>&nbsp;&nbsp;
    <button onclick="location.href='{grn_pageurl page=$page_info.all date=$date.prev uid=$user_id oid=$org_id}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_back_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button>
    <button onclick="location.href='{grn_pageurl page=$page_info.all uid=$user_id oid=$org_id}';return false;"> {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-88' replace='true'} </button>
    <button onclick="location.href='{grn_pageurl page=$page_info.all date=$date.next uid=$user_id oid=$org_id}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_next_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button>
    {capture name='grn_timecard_GRN_TIM_58'}
        {cb_msg module='grn.timecard' key='GRN_TIM-58' replace='true'}
    {/capture}
    <span class="mLeft10 vAlignMiddle-grn">{grn_checkbox id="show_timecard_ip" name="show_timecard_ip" value="1" caption=$smarty.capture.grn_timecard_GRN_TIM_58 onclick="display_on_off_check_by_name(this, 'timecard_ip')"}</span>
</div>
      
<table class="timecard">
    <tr>
        <th nowrap width="50"><nobr>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-52' replace='true'}</nobr></th>
        <th nowrap width="50"><nobr>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-53' replace='true'}</nobr></th>
        <th nowrap width="50"><nobr>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-54' replace='true'}</nobr></th>
{foreach from=$config.absence_max_list item=value}
        <th nowrap width="50"><nobr>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-55' replace='true'}</nobr></th>
        <th nowrap width="50"><nobr>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-56' replace='true'}</nobr></th>
{/foreach}
        <th nowrap width="100"><nobr>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-57' replace='true'}</nobr></th>
    </tr nowrap>
{foreach from=$timecards item=card}
    <tr valign="top">
        <td nowrap class="{$card.class} tAlignRight-grn">{grn_timecard_date date=$card.date}</td>
        <td nowrap class="{$card.class} tAlignCenter-grn">
            {if $card.start}
                {grn_date_format format='TimeShort_HM' date=$card.start}
                {if $card.start_ip}
                    <div id="timecard_ip" name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$card.start_ip}</div>
                {/if}
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
            {else}
              <br>
            {/if}
        </td>
        {foreach name="absences" from=$card.absences item=absence}
            <td nowrap class="{$card.class} tAlignCenter-grn">
                {if $absence.trip}
                    {grn_date_format format='TimeShort_HM' date=$absence.trip}
                    {if $absence.trip_ip}
                        <div id="timecard_ip" name="timecard_ip" class="timecardIp-grn" style="display:none;">{cb_msg module='grn.timecard' key='GRN_TIM-57' replace='true'}{$absence.trip_ip}</div>
                    {/if}
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
                {else}
                    <br>
                {/if}
            </td>
        {/foreach}
        <td nowrap class="{$card.class}">
            {grn_link image='write20.gif' page='timecard/system/timecard_modify' caption='' uid=$user_id date=$card.date oid=$org_id}
            {$card.remarks|escape}
        </td>
    </tr>
{/foreach}
</table>

{include file="grn/system_footer.tpl"}
