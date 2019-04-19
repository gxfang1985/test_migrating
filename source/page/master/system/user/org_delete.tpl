{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

<form name="{$form_name}" method="post" action='{grn_pageurl page="$dir_name/command_"|cat:$page_info.last}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">

<p>
<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-210' replace='true'}<span class="bold">{grn_organize_name gid=$org_id is_sandbox_page=$is_sandbox_page}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-211' replace='true'}
</div>
</p>

<div class="sub_explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-212' replace='true'}
</div>

<p>
{capture name='grn_system_user_GRN_SY_US_213'}{cb_msg module='grn.system.user' key='GRN_SY_US-213' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_213 id="system-org-delete-submit"}
{capture name='grn_system_user_GRN_SY_US_214'}{cb_msg module='grn.system.user' key='GRN_SY_US-214' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_214 id="system-org-delete-cancel"}
</p>
</form>

{include file="grn/system_footer.tpl"}
