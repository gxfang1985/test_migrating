{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='timecard/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="uid" value="{$user_id}">
<input type="hidden" name="oid" value="{$org_id}">

<span class="bold">{grn_user_name uid=$user_id name=$user_name}</span> {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-82' replace='true'}

<p>
{include file='timecard/_modify.tpl' is_system=1}

</form>
{include file="grn/system_footer.tpl"}
