{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{grn_workflow_include_item category_id=$category_id form_id=$form_id item=$item selected_foreign_key=$selected_foreign_key display="modify-operation"}
{include file='grn/footer.tpl'}
