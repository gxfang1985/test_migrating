{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

{include file='link/_category_move.tpl' page_prefix='link'}

{include file="grn/footer.tpl"}
