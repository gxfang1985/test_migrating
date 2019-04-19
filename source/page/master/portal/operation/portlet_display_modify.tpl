{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_portal_include_portlet portlet="$portlet" display="set-operation"}
{include file='grn/footer.tpl'}
