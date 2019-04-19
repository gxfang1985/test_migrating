<div class="explanation">
  {cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-29' replace='true'}
  <br>
  {cb_msg module='grn.kunai.system' key='GRN_KUNAI_SY-30' replace='true'}
</div>
<p>
{include file="kunai/system/_availability_user_add.tpl" can_select_role=1 form_name=$smarty.template|basename post_page='kunai/system/command_availability_user_add' cancel_page='kunai/system/availability_user_list' json_page='system/org_json'}