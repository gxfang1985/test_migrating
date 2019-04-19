{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='presence'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='presence/system/command_access_export' postfix='presence_access.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.presence.system' key='GRN_PRSC_SY-49' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.presence.system' key='GRN_PRSC_SY-50' replace='true'}
  </th>
  <td>
      {capture name='grn_presence_system_GRN_PRSC_SY_51'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-51' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_presence_system_GRN_PRSC_SY_51 checked=false}&nbsp;{capture name='grn_presence_system_GRN_PRSC_SY_52'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-52' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_presence_system_GRN_PRSC_SY_52 checked=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_presence_system_GRN_PRSC_SY_53'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-53' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_presence_system_GRN_PRSC_SY_53}
       {grn_button_cancel class='margin'}
  </td>
 </tr>
</table>
<p>
<hr>
<p>
{include file='presence/system/_access_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' columns=$columns column_explanation=$smarty.capture.explanation type='export'}

</form>

{include file="grn/system_footer.tpl"}