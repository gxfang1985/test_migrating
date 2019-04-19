<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.i18n.export' key='charset' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.i18n.export' key='output_key_line' replace='true'}
  </th>
  <td>
      {capture name='grn_system_i18n_export_yes'}{cb_msg module='grn.system.i18n.export' key='yes' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_system_i18n_export_yes checked=0}&nbsp;{capture name='grn_system_i18n_export_no'}{cb_msg module='grn.system.i18n.export' key='no' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_system_i18n_export_no checked=1}
  </td>
 </tr>
 {if $locale_name}
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.i18n.export' key='output_language' replace='true'}
  </th>
  <td>
      {capture name='grn_system_i18n_export_all_language'}{cb_msg module='grn.system.i18n.export' key='all_language' replace='true'}{/capture}
      {grn_checkbox name='all' id='all' value='1' caption=$smarty.capture.grn_system_i18n_export_all_language checked=true}
      {foreach from=$language_codes item="language_code"}
          {capture name='language_name'}{cb_language_name code=$language_code}{/capture}
          {grn_checkbox name=$language_code id=$language_code value='1' caption=$smarty.capture.language_name}
      {/foreach}
  </td>
 </tr>
 {/if}
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_i18n_export_output'}{cb_msg module='grn.system.i18n.export' key='output' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_i18n_export_output}
       {grn_button_cancel page="system/calendar/export/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='grn/csv_columns.tpl' column_explanation=$column_explanation type='export'}
