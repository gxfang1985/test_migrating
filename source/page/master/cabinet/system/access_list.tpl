{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{include file='cabinet/_access_list.tpl' page_dir='cabinet/system' page_prefix='cabinet/system/' base_prefix=''}

{include file="grn/system_footer.tpl"}
