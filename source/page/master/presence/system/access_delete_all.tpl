{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='presence/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-58' replace='true'}
{include file='presence/system/_user_name.tpl'}
{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-39' replace='true'}
</div>

{capture name='grn_presence_system_GRN_PRSC_SY_40'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-40' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_presence_system_GRN_PRSC_SY_40}
{capture name='grn_presence_system_GRN_PRSC_SY_41'}{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-41' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_presence_system_GRN_PRSC_SY_41}

</form>

{include file='grn/system_footer.tpl'}