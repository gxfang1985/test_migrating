<div style="background:#FFFFFF; border: 1px solid #999999; padding-top:10px; padding-bottom:10px;">

<table width="{$table_width}">
<tr>
<td width="7"></td>
<td>

<table class="timeSelectBase">
<tr height="30">
{foreach from=$click_area key=name item=value}
 {if $value < 12}
  <td id="time{$value}" class="timeSelectHour_bg00" style="cursor: pointer;" width="28" onclick="grn_time_set({$value})" onmouseover="grn_end_set({$value})"></td>
 {elseif $value >= 12 && $value < 18}
  <td id="time{$value}" class="timeSelectHour_bg01" style="cursor: pointer;" width="28" onclick="grn_time_set({$value})" onmouseover="grn_end_set({$value})"></td>
 {elseif $value >= 18 && $value < 24}
  <td id="time{$value}" class="timeSelectHour_bg02" style="cursor: pointer;" width="28" onclick="grn_time_set({$value})" onmouseover="grn_end_set({$value})"></td>
 {/if}
{/foreach}

</tr>
</table>

</td>
<td width="7"></td>
</tr>
</table>

<table width="{$table_width}">
<tr height="7">
{foreach from=$display_hour key=name item=value}
 <td width="30" align="center" style="margin:0px;padding:0px">{$value}</td>
{/foreach}
</tr>
</table>

<div align="center" height="26" style="margin-top:10px;">
<input type="button" onclick="grn_clear_color()" value="{cb_msg module='grn.grn' key='GRN_GRN-642' replace='true'}">&nbsp;
<a href="javascript:grn_close_time_tool();" class=""><img border="0" src="{$app_path}/grn/image/cybozu/close20.gif?{$build_date}" />{cb_msg module='grn.grn' key='GRN_GRN-643' replace='true'}</a>
</div>
</div>
