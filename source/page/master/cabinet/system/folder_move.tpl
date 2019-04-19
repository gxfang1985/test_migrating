{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}

{include file='cabinet/_folder_move.tpl' page_prefix='cabinet/system'}

{include file="grn/system_footer.tpl"}
