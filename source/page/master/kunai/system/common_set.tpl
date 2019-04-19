{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='kunai/system/command_common_set'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <p></p>
  <table class="std_form">
    <tr>
      <th>{capture name='grn_kunai_system_GRN_KUNAI_SY_13'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-13' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_13}</th>
      <td>{capture name='grn_kunai_system_GRN_KUNAI_SY_14'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-14' replace='true'}{/capture}{grn_checkbox name='disable_old_version' id='disable_old_version' value=1 checked=$disable_old_version caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_14}</td>
    </tr>
    <tr>
      <td><br></td>
      <td>
        {capture name='grn_kunai_system_GRN_KUNAI_SY_15'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-15' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_15}
        {grn_button_cancel}
      </td>
    </tr>
  </table>
</form>
