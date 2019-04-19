{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{include file='grn/show_validation_errors.tpl'}
{grn_sso_include_method method=$sso_method display="set-personal" identifier=$identifier}
{include file='grn/personal_footer.tpl'}
