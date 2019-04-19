{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}
<form name="{$form_name}" method="post" action="{grn_pageurl page="$dir_name/command_"|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">

{foreach from=$eid_list item=eid}
<input type="hidden" name="eid[]" value="{$eid|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-275' replace='true'}<span class="bold">{grn_organize_name gid=$org_id is_sandbox_page=$is_sandbox_page}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-276' replace='true'}<span class="bold">{$user_count|escape}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-277' replace='true'}
{cb_msg module='grn.system.user' key='GRN_SY_US-278' replace='true'}
</div>

<p>
{capture name='grn_system_user_GRN_SY_US_279'}{cb_msg module='grn.system.user' key='GRN_SY_US-279' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_279}
{capture name='grn_system_user_GRN_SY_US_280'}{cb_msg module='grn.system.user' key='GRN_SY_US-280' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_user_GRN_SY_US_280}
</p>
</form>

{include file="grn/system_footer.tpl"}
