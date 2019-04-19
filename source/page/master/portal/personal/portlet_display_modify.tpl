{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_portal_include_portlet portlet="$portlet" display="set-personal"}
{include file='grn/personal_footer.tpl'}
