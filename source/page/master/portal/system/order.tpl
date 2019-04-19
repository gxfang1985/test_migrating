{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="list" value="{$list}">
<div id="one_parts">
 <div id="action">
  <!----->
   {grn_change_order form_name=$form_name select_name='pid[]' options=$portal}
  <!----->
 </div>
 <!--action_end--->
</div>
<p>
 {capture name='grn_portal_system_GRN_POT_SY_371'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-371' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_371 onclick="grn_onsubmit_common(this.form);"}
 {grn_button_cancel}
</p>
</form>
{include file='grn/system_footer.tpl'}
