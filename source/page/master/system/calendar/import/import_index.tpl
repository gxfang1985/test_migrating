{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
   <li>{capture name='grn_system_i18n_import_import_bases'}{cb_msg module='grn.system.i18n.import' key='import_bases' replace='true'}{/capture}{grn_link image='import20.gif' page='system/calendar/import/import_base_info1' caption=$smarty.capture.grn_system_i18n_import_import_bases}</li>
   <li>{capture name='grn_system_i18n_import_import_base_names'}{cb_msg module='grn.system.i18n.import' key='import_base_names' replace='true'}{/capture}{grn_link image='import20.gif' page='system/calendar/import/import_base_name1' caption=$smarty.capture.grn_system_i18n_import_import_base_names}</li>
</ul>

{include file="grn/system_footer.tpl"}
