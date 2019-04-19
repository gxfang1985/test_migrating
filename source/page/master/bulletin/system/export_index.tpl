{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_bulletin_system_GRN_BLLT_SYS_1'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-1' replace='true'}{/capture}{grn_link image='export20.gif' page='bulletin/system/category_export' reset=1 caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_1}
<li>{capture name='grn_bulletin_system_GRN_BLLT_SYS_171'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-171' replace='true'}{/capture}{grn_link image='export20.gif' page='bulletin/system/category_name_export' reset=1 caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_171}
<li>{capture name='grn_bulletin_system_GRN_BLLT_SYS_2'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-2' replace='true'}{/capture}{grn_link image='export20.gif' page='bulletin/system/access_export' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_2}
<li>{capture name='grn_bulletin_system_GRN_BLLT_SYS_3'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-3' replace='true'}{/capture}{grn_link image='export20.gif' page='bulletin/system/notify_export' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_3}
</ul>

{include file="grn/system_footer.tpl"}
