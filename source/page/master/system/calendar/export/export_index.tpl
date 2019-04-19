{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
   <li>{capture name='grn_system_i18n_export_export_bases'}{cb_msg module='grn.system.i18n.export' key='export_bases' replace='true'}{/capture}{grn_link image='export20.gif' page='system/calendar/export/export_base_info' caption=$smarty.capture.grn_system_i18n_export_export_bases}
   <li>{capture name='grn_system_i18n_export_export_base_names'}{cb_msg module='grn.system.i18n.export' key='export_base_names' replace='true'}{/capture}{grn_link image='export20.gif' page='system/calendar/export/export_base_name' caption=$smarty.capture.grn_system_i18n_export_export_base_names}
</ul>

{include file="grn/system_footer.tpl"}
