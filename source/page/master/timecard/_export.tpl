<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_timecard_GRN_TIM_24'}{cb_msg module='grn.timecard' key='GRN_TIM-24' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_timecard_GRN_TIM_24}</th>
  <td>{grn_select_date prefix='start_' date=$start form_name=$form_name}{cb_msg module='grn.timecard' key='GRN_TIM-25' replace='true'}{grn_select_date prefix='end_' date=$end form_name=$form_name}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_timecard_GRN_TIM_26'}{cb_msg module='grn.timecard' key='GRN_TIM-26' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_timecard_GRN_TIM_26}</th>
  <td>{grn_charset name='charset' bom='TRUE'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.timecard' key='GRN_TIM-27' replace='true'}</th>
  <td>
  {capture name='grn_timecard_GRN_TIM_28'}{cb_msg module='grn.timecard' key='GRN_TIM-28' replace='true'}{/capture}{grn_radio name='item_name' id='yes' value='1' caption=$smarty.capture.grn_timecard_GRN_TIM_28 checked=TRUE}&nbsp;{capture name='grn_timecard_GRN_TIM_29'}{cb_msg module='grn.timecard' key='GRN_TIM-29' replace='true'}{/capture}{grn_radio name='item_name' id='no' value='0' caption=$smarty.capture.grn_timecard_GRN_TIM_29}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   <div class="mTop10">
    {strip}
     {assign var="timecard_button_export_spacing" value="normal"}

     {if $back_page && $back_caption}
      {grn_button action="cancel" spacing="tight" caption=$back_caption id="timecard_button_back" page=$back_page page_param_ss='1'}
      {assign var="timecard_button_export_spacing" value="loose"}
     {/if}

     {capture name='grn_timecard_GRN_TIM_30'}{cb_msg module='grn.timecard' key='GRN_TIM-30' replace='true'}{/capture}
     {grn_button ui="main" action="submit" spacing=$timecard_button_export_spacing caption=$smarty.capture.grn_timecard_GRN_TIM_30 id="timecard_button_export" auto_disable=false}

     {if ! $cancel_page}
      {grn_button action="cancel" id="timecard_button_cancel"}
     {elseif $cancel_params}
      {capture name='grn_timecard_cancel_url'}
       {grn_pageurl page=$cancel_page params=$cancel_params}
      {/capture}
      {capture name='grn_timecard_cancel_onclick'}
       location.href='{$smarty.capture.grn_timecard_cancel_url|htmlspecialchars_decode}';
      {/capture}
      {capture name='grn_timecard_GRN_TIM_31'}{cb_msg module='grn.timecard' key='GRN_TIM-31' replace='true'}{/capture}
      {grn_button action="cancel" id="timecard_button_cancel" page=$cancel_page caption=$smarty.capture.grn_timecard_GRN_TIM_31 onclick=$smarty.capture.grn_timecard_cancel_onclick}
     {elseif $cancel_date}
      {grn_button action="cancel" id="timecard_button_cancel" page=$cancel_page page_param_date=$cancel_date}
     {elseif $app_id}
      {grn_button action="cancel" id="timecard_button_cancel" page=$cancel_page page_param_app_id=$app_id}
     {else}
      {grn_button action="cancel" id="timecard_button_cancel" page=$cancel_page}
     {/if}
    {/strip}
   </div>
  </td>
 </tr>
</table>

<hr>

<p>
 <div class="sub_title">{cb_msg module='grn.timecard' key='GRN_TIM-32' replace='true'}</div>
 <div class="notes">
  <div>
    {cb_msg module='grn.timecard' key='GRN_TIM-33' replace='true'}
   <div class="horizontal">
    <div><span class="bold">1.</span> {cb_msg module='grn.timecard' key='GRN_TIM-34' replace='true'}</div>
    <div><span class="bold">2.</span> {cb_msg module='grn.timecard' key='GRN_TIM-35' replace='true'}</div>
    <div><span class="bold">3.</span> {cb_msg module='grn.timecard' key='GRN_TIM-36' replace='true'}</div>
    <div><span class="bold">4.</span> {cb_msg module='grn.timecard' key='GRN_TIM-37' replace='true'}</div>
    <div><span class="bold">5.</span> {cb_msg module='grn.timecard' key='GRN_TIM-53' replace='true'}</div>
    <div><span class="bold">6.</span> {cb_msg module='grn.timecard' key='GRN_TIM-38' replace='true'}</div>
    <div><span class="bold">7.</span> {cb_msg module='grn.timecard' key='GRN_TIM-54' replace='true'}</div>
{foreach name=absences from=$config.absence_max_list item=value}
 {math assign="num" equation="x + (y-1)*4"     x=8 y=$smarty.foreach.absences.iteration}
    <div><span class="bold">{$num}.</span> {cb_msg module='grn.timecard' key='GRN_TIM-39' replace='true'}</div>
    <div><span class="bold">{$num+1}.</span> {cb_msg module='grn.timecard' key='GRN_TIM-55' replace='true'}</div>
 {math assign="num" equation="x + (y-1)*4 + 2" x=8 y=$smarty.foreach.absences.iteration}
    <div><span class="bold">{$num}.</span> {cb_msg module='grn.timecard' key='GRN_TIM-40' replace='true'}</div>
    <div><span class="bold">{$num+1}.</span> {cb_msg module='grn.timecard' key='GRN_TIM-56' replace='true'}</div>
{/foreach}
{math assign="num" equation="x + y*4" x=8 y=$config.absence_max}
    <div><span class="bold">{$num}.</span> {cb_msg module='grn.timecard' key='GRN_TIM-41' replace='true'}</div>
   </div>
   <div class="clear_both"></div>
  </div>
 </div>
<input type="hidden" name="date" value="{$date}">
