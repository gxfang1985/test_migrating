 <tr>
{if ($page_info.last == 'group_day') || ($page_name == 'group_day')}
 <td nowrap class="available_time_navi_head"><a name="{$aname}">&nbsp;</a></td>
 <td nowrap class="available_time_navi_head">&nbsp;</td>
 <td class="available_time_navi" colspan="{$schedule_params.col_span}" align="right" nowrap>

{else}
 <td nowrap class="available_time_navi_head"><a name="{$aname}">&nbsp;</a></td>
 <td class="available_time_navi" colspan="7" align="right" nowrap>
{/if}
    <div class="moveButtonBlock-grn">
    {if $gid_is_empty}
        {assign var='group_id' value=''}
    {/if}
    {strip}
        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-791' replace='true'}">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}#{$aname}">
                <span class="moveButtonArrowLeftTwo-grn"></span>
            </a>
        </span>
        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-793' replace='true'}">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}#{$aname}">
                <span class="moveButtonArrowLeft-grn"></span>
            </a>
        </span>
        <span class="moveButtonBase-grn" title="">
            <a href="{grn_pageurl page=$page_info.all bdate=$date uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}#{$aname}">
                {cb_msg module='grn.schedule' key='GRN_SCH-794' replace='true'}
            </a>
        </span>
        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-795' replace='true'}">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}#{$aname}">
                <span class="moveButtonArrowRight-grn"></span>
            </a>
        </span>
        <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-797' replace='true'}">
            <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid sp=$view_set.offset search_text=$search_text p=$selected_group_type}#{$aname}">
                <span class="moveButtonArrowRightTwo-grn"></span>
            </a>
        </span>
    {/strip}
    </div>
 </td>
 </tr>
