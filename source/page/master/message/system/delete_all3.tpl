{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$page_info.all}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="view">
 <p class="explanation">
  <span class="bold">{$app_name}{cb_msg module='grn.message.system' key='GRN_MSG_SY-95' replace='true'}</span><br>
   {cb_msg module='grn.message.system' key='GRN_MSG_SY-96' replace='true'}<br>
 </p>
 <p class="attention">{cb_msg module='grn.message.system' key='GRN_MSG_SY-97' replace='true'}</p>
<script language="JavaScript">
<!--
interval("{$page_info.all}",3000);
//-->
</script>
 </div>
 <!--view_end--->
</div>
<input type="hidden" name="term_year" value="{$year}">
<input type="hidden" name="term_month" value="{$month}">
<input type="hidden" name="term_day" value="{$day}">
</form>
{include file='grn/system_footer.tpl'}
