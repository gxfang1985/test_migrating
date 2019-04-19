{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <span class="sub_explanation">
  </span>
  <p class="item">
  {grn_change_order form_name=$form_name select_name='order[]' options=$form_options}
  </p>
  <p class="item">
   <div class="contents_button">
    <div classs="word">
    {capture name='grn_report_system_GRN_RPRT_SY_246'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-246' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_246 onclick="grn_onsubmit_common(this.form);"}
    {grn_button_cancel}
    </div>
   </div>
  </p>
 </div>
</div>
<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{include file='grn/system_footer.tpl'}
