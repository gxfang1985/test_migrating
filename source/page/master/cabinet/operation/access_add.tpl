{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<div class="explanation">
{cb_msg module='grn.grn' key='GRN_GRN-598' replace='true'}
<br>
{cb_msg module='grn.grn' key='GRN_GRN-1531' replace='true'}
</div>
<p>
{include file='grn/org_user_role_select.tpl' can_select_role=1 form_name=$smarty.template|basename post_page='cabinet/operation/command_access_add' cancel_page='cabinet/operation/access_list' json_page='cabinet/org_json'}

{include file="grn/footer.tpl"}
