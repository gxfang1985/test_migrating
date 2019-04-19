{if $uid_is_empty}
    {assign var='user_id' value=''}
{/if}
{if $gid_is_empty}
    {assign var='group_id' value=''}
{/if}
<div>
    <table class="calendar_navi" id="calendar1" >
        <tr>
            <td rowspan="2" align="center" >
                <select name="date" onChange="i=this.selectedIndex;v=this.options[i].value;if(v)doMoveCalednar(v)">
                    {foreach name='year_month' from=$calendar_year_month item=year_month}
                        <option value="{$year_month}"{if $smarty.foreach.year_month.iteration == 4} selected{/if}>{grn_date_format date=$year_month format="DateFull_YM"}</option>
                    {/foreach}
                </select>
            </td>
            <td rowspan="2" align="center" nowrap>
                <a href="javascript:doMoveCalednar( '{$calendar_prev_date}')">&lt;&lt;{grn_date_format date=$calendar_prev_date format="DateFull_M"}</a>&nbsp;
            </td>
            {foreach from=$calendar_day_list item=date}
                {if $date.wday_type == 's_date_sunday'}
                    <td align="center"{if ! $date.workday} class="s_date_sunday"{/if}>{cb_msg module='grn.fw' key='WDayMini0' replace='true'}</td>
                {elseif $date.wday_type == 's_date_monday'}
                    <td align="center"{if $date.holiday} class="s_date_sunday"{/if}>{cb_msg module='grn.fw' key='WDayMini1' replace='true'}</td>
                {elseif $date.wday_type == 's_date_tuesday'}
                    <td align="center"{if $date.holiday} class="s_date_sunday"{/if}>{cb_msg module='grn.fw' key='WDayMini2' replace='true'}</td>
                {elseif $date.wday_type == 's_date_wednesday'}
                    <td align="center"{if $date.holiday} class="s_date_sunday"{/if}>{cb_msg module='grn.fw' key='WDayMini3' replace='true'}</td>
                {elseif $date.wday_type == 's_date_thursday'}
                    <td align="center"{if $date.holiday} class="s_date_sunday"{/if}>{cb_msg module='grn.fw' key='WDayMini4' replace='true'}</td>
                {elseif $date.wday_type == 's_date_friday'}
                    <td align="center"{if $date.holiday} class="s_date_sunday"{/if}>{cb_msg module='grn.fw' key='WDayMini5' replace='true'}</td>
                {elseif $date.wday_type == 's_date_saturday'}
                    <td align="center"{if ! $date.workday}{if $date.holiday} class="s_date_sunday"{else} class="s_date_saturday"{/if}{/if}>{cb_msg module='grn.fw' key='WDayMini6' replace='true'}</font></td>
                {/if}
            {/foreach}
            <td rowspan="2" align="center" nowrap>
                &nbsp;<a href="javascript:doMoveCalednar( '{$calendar_next_date}' )">{grn_date_format date=$calendar_next_date format="DateFull_M"}&gt;&gt;</a>
            </td>
        </tr>
        <tr>
            {foreach from=$calendar_day_list item=date}
                <td align="center" class="date_cell date_cell_{$date.format}{if $date.view_date} calendar_navi_today{/if}" data-date="{$date.format}">
                    {grn_link page=$location caption=$date.day uid=$user_id gid=$group_id bdate=$date.year|cat:'-'|cat:$date.month|cat:'-'|cat:$date.day event=$event_id event_date=$event_date search_text=$search_text p=$selected_group_type}
                </td>
            {/foreach}
        </tr>
    </table>
</div>
