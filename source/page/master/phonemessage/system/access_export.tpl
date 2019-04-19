{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='phonemessage'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/system/command_access_export' postfix='phonemessage_access.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-39' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-40' replace='true'}
  </th>
  <td>
      {capture name='grn_phonemessage_system_GRN_PHM_SY_41'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-41' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_41 checked=false}&nbsp;{capture name='grn_phonemessage_system_GRN_PHM_SY_42'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-42' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_42 checked=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_phonemessage_system_GRN_PHM_SY_43'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-43' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_43}
       {grn_button_cancel class='margin' page='system/application_list' app_id='phonemessage'}
  </td>
 </tr>
</table>
<p>
<hr>
<p>
{include file='phonemessage/system/_access_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' columns=$columns column_explanation=$smarty.capture.explanation type='export'}

</form>

{include file="grn/system_footer.tpl"}
