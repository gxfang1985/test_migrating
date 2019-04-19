{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{include file='report/_form_modify.tpl' is_operation=true}

{include file='grn/footer.tpl'}
