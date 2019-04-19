{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}

{include file='cabinet/_folder_move.tpl' page_prefix='cabinet/operation'}

{include file="grn/footer.tpl"}
