{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_bulletin_system_GRN_BLLT_SYS_166'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-166' replace='true'}{/capture}{grn_link image='import20.gif' page='bulletin/system/category_import1' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_166}
<li>{capture name='grn_bulletin_system_GRN_BLLT_SYS_170'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-170' replace='true'}{/capture}{grn_link image='import20.gif' page='bulletin/system/category_name_import1' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_170}
<li>{capture name='grn_bulletin_system_GRN_BLLT_SYS_167'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-167' replace='true'}{/capture}{grn_link image='import20.gif' page='bulletin/system/access_import1' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_167}
<li>{capture name='grn_bulletin_system_GRN_BLLT_SYS_168'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-168' replace='true'}{/capture}{grn_link image='import20.gif' page='bulletin/system/notify_import1' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_168}
</ul>

{include file="grn/system_footer.tpl"}
