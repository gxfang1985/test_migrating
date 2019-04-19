{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{include file='cabinet/_move.tpl' cancel_page='cabinet/view' is_user_page=true}

{include file="grn/footer.tpl"}
