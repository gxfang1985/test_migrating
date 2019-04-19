{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<div class="explanation">
{cb_msg module='grn.workflow.system' key='w_select_team_user_role_and_add_set_default_setting' replace='true'}
<br>
{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-92' replace='true'}
</div>
<p>
{include file='grn/org_user_role_select.tpl' can_select_role=1 form_name=$smarty.template|basename post_page='workflow/system/command_default_add' cancel_page='workflow/system/default_list' json_page='system/org_json'}

{include file="grn/system_footer.tpl"}
