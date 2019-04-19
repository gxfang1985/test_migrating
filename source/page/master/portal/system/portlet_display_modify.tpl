{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_portal_include_portlet portlet="$portlet" display="set-system"}
{include file='grn/system_footer.tpl'}
