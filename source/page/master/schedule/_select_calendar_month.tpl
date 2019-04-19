{if $uid_is_empty}
    {assign var='user_id' value=''}
{/if}
{if $gid_is_empty}
    {assign var='group_id' value=''}
{/if}
<div>
<table class="calendar_navi" id="calendar1" >
 <tr>
  <td nowrap>
   <select name="date" onChange="i=this.selectedIndex;v=this.options[i].value;if(v)doMoveCalednar(v)">
{foreach name='year_list' from=$calendar_year_list item=year_date}
    <option value="{$year_date}"{if $smarty.foreach.year_list.iteration == 2} selected{/if}>{grn_date_format date=$year_date format="DateFull_Y"}</option>
{/foreach}
   </select>
  </td>
  <td rowspan="2" align="center" nowrap>
   <a href="javascript:doMoveCalednar( '{$calendar_prev_year}' );">&lt;&lt;{cb_msg module='grn.schedule' key='GRN_SCH-828' replace='true'}</a>
  </td>
{foreach from=$month_count item=month}
  <td nowrap><a href="{grn_pageurl page=$location bdate=$month.date uid=$user_id gid=$group_id search_text=$search_text}">{cb_msg module='fw.date' key='MonthShort'|cat:$month.month}{cb_msg module='fw.ui' key='date_month_unit'}</a></td>
{/foreach}
  <td align="right" nowrap>
   <a href="javascript:doMoveCalednar( '{$calendar_next_year}'  );">{cb_msg module='grn.schedule' key='GRN_SCH-830' replace='true'}&gt;&gt;</a>
  </td>
  <td width="200">&nbsp;</td>
 </tr>
</table>
</div>
