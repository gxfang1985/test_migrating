{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='kunai/system/command_'|cat:$page_info.last}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <div class="explanation">
    {cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-24' replace='true'}
  </div>
  {capture name='grn_kunai_system_GRN_KUNAI_SY_25'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-25' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_25}
  {capture name='grn_kunai_system_GRN_KUNAI_SY_26'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-26' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_26}
</form>