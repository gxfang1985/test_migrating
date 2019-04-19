{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last postfix='facilitygroups.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-347' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-348' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-349' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-350' replace='true'}
  </th>
  <td>
      {capture name='grn_schedule_system_GRN_SCH_SY_351'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-351' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_351 checked=false}&nbsp;{capture name='grn_schedule_system_GRN_SCH_SY_352'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-352' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_352 checked=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_353'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-353' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_353}
       {grn_button_cancel class='margin' page='schedule/system/export_index'}
  </td>
 </tr>
</table>
<p>
<hr>
<p>
{include file='schedule/system/_facilitygroup_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' columns=$columns column_explanation=$smarty.capture.explanation type='export'}

</form>

{include file='grn/system_footer.tpl'}
