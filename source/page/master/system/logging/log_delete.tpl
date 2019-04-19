{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/logging/command_log_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="priority" value="{$priority|escape}">
<input type="hidden" name="category" value="{$category|escape}">

<p>{cb_msg module='grn.system.logging' key='GRN_SY_LO-64' replace='true'}</p>
 <p>
  {capture name='grn_system_logging_GRN_SY_LO_65'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-65' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_logging_GRN_SY_LO_65}
  {capture name='grn_system_logging_GRN_SY_LO_66'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-66' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_logging_GRN_SY_LO_66}
 </p>
<input type="hidden" name="lid" value="{$lid}">
</form>
{include file='grn/system_footer.tpl'}
