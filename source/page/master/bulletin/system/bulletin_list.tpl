{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{capture name="tmp"}{$page_title|grn_noescape}({$category.name|grn_noescape}){/capture}
{grn_title title=$smarty.capture.tmp class=$page_info.parts[0]}

{include file='bulletin/_article_list.tpl' page_prefix='bulletin/system'}

{include file="grn/system_footer.tpl"}
