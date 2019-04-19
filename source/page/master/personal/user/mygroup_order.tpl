{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <!----->
   {grn_change_order form_name=$form_name select_name='mgids[]' options=$mygroups}
  <!----->
 </div>
</div>
<p>
 {capture name='grn_personal_user_GRN_PRS_US_68'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-68' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_user_GRN_PRS_US_68 onclick="grn_onsubmit_common(this.form);"}
 {grn_button_cancel}
</p>
 <input type="hidden" name="mgid" value="{$mygroup_id}">
</form>
{include file='grn/personal_footer.tpl'}
