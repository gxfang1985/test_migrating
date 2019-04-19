{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
{grn_auth_include_method method=$login_method display="add-system"}
{include file='grn/system_footer.tpl'}
