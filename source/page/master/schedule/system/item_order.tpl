{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <span class="sub_explanation">
   {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-28' replace='true'}
  </span>
  <p class="item">
  {grn_change_order form_name=$form_name select_name='iid[]' options=$item_options}
  </p>
  <p class="item">
   <div class="contents_button">
    <div classs="word">
    {capture name='grn_schedule_system_GRN_SCH_SY_29'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-29' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_29 onclick="grn_onsubmit_common(this.form);"}
    {grn_button_cancel}
    </div>
   </div>
  </p>
 </div>
</div>
</form>
{include file='grn/system_footer.tpl'}
