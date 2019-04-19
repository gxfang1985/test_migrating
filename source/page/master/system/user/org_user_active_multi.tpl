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
{cb_msg module='grn.system.user' key='GRN_SY_US-601' replace='true'}<span class="bold">{$selected_count|escape}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-602' replace='true'}
{cb_msg module='grn.system.user' key='GRN_SY_US-603' replace='true'}
</div>

<p>
{capture name='grn_system_user_GRN_SY_US_604'}{cb_msg module='grn.system.user' key='GRN_SY_US-604' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_604}
{capture name='grn_system_user_GRN_SY_US_605'}{cb_msg module='grn.system.user' key='GRN_SY_US-605' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_user_GRN_SY_US_605}
</p>
</form>

{include file="grn/system_footer.tpl"}
