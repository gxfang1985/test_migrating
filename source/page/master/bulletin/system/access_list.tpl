{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='bulletin/_access_list.tpl' page_dir='bulletin/system' page_prefix='bulletin/system/' base_prefix=''}
{include file="grn/system_footer.tpl"}
