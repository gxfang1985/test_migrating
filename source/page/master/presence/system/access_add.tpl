{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<div class="explanation">
{cb_msg module='grn.grn' key='GRN_GRN-1512' replace='true'}
<br>
{cb_msg module='grn.grn' key='GRN_GRN-1530' replace='true'}
</div>
<p>
{include file='grn/org_user_role_select.tpl' form_name=$smarty.template|basename post_page='presence/system/command_access_add' cancel_page='presence/system/access_list' json_page='system/org_json'}

{include file="grn/system_footer.tpl"}
