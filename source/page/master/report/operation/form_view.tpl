{* header *}
{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{assign var='sub_dir' value='operation'}
{assign var='form_name' value=$smarty.template|basename}

{include file='report/_form_view.tpl' is_operation=true}

{* footer *}
{include file="grn/footer.tpl"}
