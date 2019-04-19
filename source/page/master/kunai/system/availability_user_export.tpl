{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='kunai/system/command_'|cat:$page_info.last postfix='kunai_users.csv'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <table class="std_form">
    <tr>
      <th nowrap>
        {cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-7' replace='true'}
      </th>
      <td>
        {grn_charset name="charset" bom='TRUE'}
      </td>
    </tr>
    <tr>
      <th nowrap>
        {cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-8' replace='true'}
      </th>
      <td>
        {capture name='grn_kunai_system_GRN_KUNAI_SY_9'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-9' replace='true'}{/capture}
        {capture name='grn_kunai_system_GRN_KUNAI_SY_10'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-10' replace='true'}{/capture}
        {grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_9 checked=0}&nbsp;{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_10 checked=1}
      </td>
    </tr>
    <tr>
      <td></td>
      <td>
        {capture name='grn_kunai_system_GRN_KUNAI_SY_11'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-11' replace='true'}{/capture}
        {grn_button_submit class="margin" caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_11}
        {grn_button_cancel page="system/application_list" app_id="kunai"}
      </td>
    </tr>
  </table>
  <hr>
  <p>
  {include file='kunai/system/_availability_user_csv_columns.tpl'}
  {include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}
</form>