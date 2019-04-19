{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_cabinet_system_GRN_CAB_SY_40'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-40' replace='true'}{/capture}{grn_link image='export20.gif' page='cabinet/system/folder_export' reset=1 caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_40}
<li>{capture name='grn_cabinet_system_GRN_CAB_SY_91'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-91' replace='true'}{/capture}{grn_link image='export20.gif' page='cabinet/system/folder_name_export' reset=1 caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_91}
<li>{capture name='grn_cabinet_system_GRN_CAB_SY_41'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-41' replace='true'}{/capture}{grn_link image='export20.gif' page='cabinet/system/access_export' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_41}
<li>{capture name='grn_cabinet_system_GRN_CAB_SY_42'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-42' replace='true'}{/capture}{grn_link image='export20.gif' page='cabinet/system/notify_export' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_42}
</ul>

{include file="grn/system_footer.tpl"}
