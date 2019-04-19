{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='timecard/system/command_'|cat:$page_info.last postfix='timecard.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="uid" value="{$user_id}">
<input type="hidden" name="oid" value="{$org_id}">

<p>
 <div class="explanation">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-91' replace='true'}{grn_appname app_id='timecard'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-46' replace='true'}</div>
</p>
{include file='timecard/_export.tpl' cancel_page='timecard/system/timecard_view' cancel_params=$cancel_params}

</form>

{include file='grn/system_footer.tpl'}
