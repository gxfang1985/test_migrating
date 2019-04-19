{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<div id="one_parts">
 <div id="action">
  <!----->
   {grn_change_order form_name=$form_name select_name='psids[]' options=$path_step_option}
  <!----->
 </div>
 <!--action_end--->
</div>
{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_workflow_system_w_do_change_y onclick="grn_onsubmit_common(this.form);"}
{grn_button_cancel page='workflow/system/form_view' cid=$cid fid=$fid}
</form>
{include file='grn/system_footer.tpl'}
