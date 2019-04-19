{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<div class="explanation">
{cb_msg module='grn.grn' key='GRN_GRN-528' replace='true'}
<br/>
{cb_msg module='grn.grn' key='GRN_GRN-1530' replace='true'}
</div>
<p></p>
{include file='grn/org_user_role_select.tpl' can_select_role=1 form_name=$smarty.template|basename post_page='cabinet/operation/command_privilege_add' cancel_page='cabinet/operation/privilege_list' json_page='cabinet/org_json'}

{include file="grn/footer.tpl"}
