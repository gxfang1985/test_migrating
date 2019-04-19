{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='kunai/system/command_'|cat:$page_info.last}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="selected_dynamic_roles" value="{$selected_dynamic_roles|escape}">
<input type="hidden" name="selected_static_roles" value="{$selected_static_roles|escape}">
<input type="hidden" name="selected_groups" value="{$selected_groups|escape}">
<input type="hidden" name="selected_users" value="{$selected_users|escape}">
  <div class="explanation">
    {cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-27' replace='true'}<span class="bold">{$count}</span>{if $count > 1}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-28' replace='true'}{else}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-31' replace='true'}{/if}
  </div>
  {capture name='grn_kunai_system_GRN_KUNAI_SY_25'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-25' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_25}
  {capture name='grn_kunai_system_GRN_KUNAI_SY_26'}{cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-26' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_kunai_system_GRN_KUNAI_SY_26 page='kunai/system/availability_user_list'}
</form>
