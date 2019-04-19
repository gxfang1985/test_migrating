{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$page_info.all}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
 <p>
  <span class="bold">{$str_date}</span>&nbsp;{cb_msg module='grn.message.system' key='GRN_MSG_SY-87' replace='true'}{$app_name}{cb_msg module='grn.message.system' key='GRN_MSG_SY-88' replace='true'}<br>
  <span class="attention">{cb_msg module='grn.message.system' key='GRN_MSG_SY-89' replace='true'}{$app_name}{cb_msg module='grn.message.system' key='GRN_MSG_SY-90' replace='true'}</span>
 </p>
 <p class="explanation">{cb_msg module='grn.message.system' key='GRN_MSG_SY-91' replace='true'}{$app_name}{cb_msg module='grn.message.system' key='GRN_MSG_SY-92' replace='true'}</p>
 <p>
  {capture name='grn_message_system_GRN_MSG_SY_93'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-93' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_93}
  {capture name='grn_message_system_GRN_MSG_SY_94'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-94' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_message_system_GRN_MSG_SY_94}
 </p>
 </div>
 <!--action_end--->
</div>
<input type="hidden" name="term_year" value="{$year}">
<input type="hidden" name="term_month" value="{$month}">
<input type="hidden" name="term_day" value="{$day}">
</form>
{include file='grn/system_footer.tpl'}
