{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

{include file='bulletin/_article_move_multi.tpl' cancel_page='bulletin/operation/bulletin_list'}

{include file="grn/footer.tpl"}
