{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last postfix='facility_name.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-93' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-94' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-95' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-96' replace='true'}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_97'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-97' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_97 checked=false}&nbsp;{capture name='grn_schedule_system_GRN_SCH_SY_98'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-98' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_98 checked=true}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-566' replace='true'}
  </th>
  <td>
        {capture name='grn_schedule_system_GRN_SCH_SY_567'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-567' replace='true'}{/capture}
        {grn_checkbox name='all' id='all' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_567}
        {foreach from=$language_codes item="language_code"}
            {capture name='language_name'}{cb_language_name code=$language_code}{/capture}
            {grn_checkbox name=$language_code id=$language_code value='1' caption=$smarty.capture.language_name}
        {/foreach}
  </td>
 </tr>

 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_99'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-99' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_99}
       {grn_button_cancel class='margin' page='schedule/system/export_index'}
  </td>
 </tr>
</table>
<p>
<hr>
<p>
{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-437' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-568' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-436' replace='true'}</div> 
{/capture}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}

</form>

{include file='grn/system_footer.tpl'}
