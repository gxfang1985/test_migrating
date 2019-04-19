{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_cabinet_system_GRN_CAB_SY_5'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-5' replace='true'}{/capture}{grn_link image='import20.gif' page='cabinet/system/folder_import1' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_5}
<li>{capture name='grn_cabinet_system_GRN_CAB_SY_90'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-90' replace='true'}{/capture}{grn_link image='import20.gif' page='cabinet/system/folder_name_import1' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_90}
<li>{capture name='grn_cabinet_system_GRN_CAB_SY_6'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-6' replace='true'}{/capture}{grn_link image='import20.gif' page='cabinet/system/access_import1' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_6}
<li>{capture name='grn_cabinet_system_GRN_CAB_SY_7'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-7' replace='true'}{/capture}{grn_link image='import20.gif' page='cabinet/system/notify_import1' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_7}
</ul>

{include file="grn/system_footer.tpl"}
