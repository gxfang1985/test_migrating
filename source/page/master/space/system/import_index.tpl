{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='tmp'}{cb_msg module='grn.space.system' key='import_index-1' replace='true'}{/capture}{grn_link image='import20.gif' page='space/system/category_import1' caption=$smarty.capture.tmp}
<li>{capture name='tmp'}{cb_msg module='grn.space.system' key='import_index-2' replace='true'}{/capture}{grn_link image='import20.gif' page='space/system/category_name_import1' caption=$smarty.capture.tmp}
</ul>

{include file="grn/system_footer.tpl"}
