{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

<form name="{$form_name}" method="post" action="{grn_pageurl page="$dir_name/command_"|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">

<div class="sub_title">
{grn_image image='organize20.gif'}{if $org_id}{$org.name}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-537' replace='true'}{/if} {cb_msg module='grn.system.user' key='GRN_SY_US-538' replace='true'}
</div>

{grn_change_order form_name=$form_name select_name='child_ids[]' options=$children_options}

{capture name='grn_system_user_GRN_SY_US_539'}{cb_msg module='grn.system.user' key='GRN_SY_US-539' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_539 onclick="grn_onsubmit_common(this.form);"}
{grn_button_cancel}
</form>

{include file="grn/system_footer.tpl"}
