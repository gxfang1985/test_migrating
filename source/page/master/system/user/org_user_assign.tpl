{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-688' replace='true'}<span class="bold">{grn_organize_name gid=$org_id name=$org_name is_sandbox_page=$is_sandbox_page}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-689' replace='true'}
</div>

<p>
{include file='grn/org_user_select.tpl' form_name=$form_name post_page="$dir_name/command_org_user_assign" cancel_page="$dir_name/org_list" json_page='system/org_json'}

{include file="grn/system_footer.tpl"}
