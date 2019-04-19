{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{include file='cabinet/_notify_list.tpl' page_dir='cabinet/operation' page_prefix='cabinet/operation/' base_prefix=''}

{include file="grn/footer.tpl"}
