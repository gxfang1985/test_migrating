{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$page_info.all}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/logging/command_log_delete_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
 <p class="explanation">
  {cb_msg module='grn.system.logging' key='GRN_SY_LO-127' replace='true'}<span class="bold">{grn_date_format format='DateLong_YMDW' date=$date}</span>&nbsp;{cb_msg module='grn.system.logging' key='GRN_SY_LO-111' replace='true'}<span class="bold">{$category_name|escape}</span>{cb_msg module='grn.system.logging' key='GRN_SY_LO-112' replace='true'}
  <div class="attention">{cb_msg module='grn.system.logging' key='GRN_SY_LO-113' replace='true'}</div>
 </p>
 <p>
  {capture name='grn_system_logging_GRN_SY_LO_114'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-114' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_114}
  {capture name='grn_system_logging_GRN_SY_LO_115'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-115' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_logging_GRN_SY_LO_115}
 </p>
 </div>
 <!--action_end--->
</div>
<input type="hidden" name="date" value="{$date->format()}">
<input type="hidden" name="priority" value="{$priority|escape}">
<input type="hidden" name="category" value="{$category|escape}">
</form>
{include file='grn/system_footer.tpl'}
