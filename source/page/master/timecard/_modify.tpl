<span class="bold">{$date.year}&nbsp;{cb_msg module='grn.timecard' key='GRN_TIM-17' replace='true'}&nbsp;{$date.month}&nbsp;{cb_msg module='grn.timecard' key='GRN_TIM-18' replace='true'}</span>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.timecard' key='GRN_TIM-19' replace='true'}</th>
  <td>{grn_date_format format='DateShort_MDW' date=$card.date}</td>
 </tr>
{if ! $card.future && ($is_system || $config.enable_modify_record)}
 {math assign="end_hour" equation="(x + 23) % 24" x=$config.change_of_day.hour}
 <tr>
  <th nowrap>{cb_msg module='grn.timecard' key='GRN_TIM-20' replace='true'}</th>
  <td>{grn_select_time prefix='start_' time=$card.start start_hour=$config.change_of_day.hour end_hour=$end_hour}&nbsp;-&nbsp;{grn_select_time prefix='finish_' time=$card.finish start_hour=$config.change_of_day.hour end_hour=$end_hour}</td>
 </tr>
 {foreach name=absence from=$card.absences key=id item=absence}
  {if $absence.id}
   {capture name='trip'}trip{$absence.id}_{/capture}
   {capture name='back'}back{$absence.id}_{/capture}
  {else}
   {capture name='trip'}tripN{$smarty.foreach.absence.iteration}_{/capture}
   {capture name='back'}backN{$smarty.foreach.absence.iteration}_{/capture}
  {/if}
 <tr>
  <th nowrap>{cb_msg module='grn.timecard' key='GRN_TIM-21' replace='true'}</th>
  <td>{grn_select_time prefix=$smarty.capture.trip time=$absence.trip start_hour=$config.change_of_day.hour end_hour=$end_hour}&nbsp;-&nbsp;{grn_select_time prefix=$smarty.capture.back time=$absence.back start_hour=$config.change_of_day.hour end_hour=$end_hour}</td>
 </tr>
 {/foreach}
{/if} {** $card.future **}
 <tr>
  <th nowrap>{cb_msg module='grn.timecard' key='GRN_TIM-22' replace='true'}</th>
  <td>{grn_text name='remarks' size='50' value=$card.remarks disable_return_key=true}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   <div class="mTop10">
    {strip}
     {capture name='grn_timecard_GRN_TIM_23'}{cb_msg module='grn.timecard' key='GRN_TIM-23' replace='true'}{/capture}
     {grn_button ui="main" action="submit" spacing="normal" caption=$smarty.capture.grn_timecard_GRN_TIM_23 id="timecard_button_save"}

     {grn_button action="cancel" id="timecard_button_cancel"}
    {/strip}
   </div>
  </td>
 </tr>
</table>

<input type="hidden" name="date" value="{$card.date}">
