{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_report_system_GRN_RPRT_SY_89'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-89' replace='true'}{/capture}{grn_link image='export20.gif' page='report/system/category_export' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_89}
<li>{capture name='grn_report_system_GRN_RPRT_SY_562'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-562' replace='true'}{/capture}{grn_link image='export20.gif' page='report/system/category_name_export' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_562}
<li>{capture name='grn_report_system_GRN_RPRT_SY_90'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-90' replace='true'}{/capture}{grn_link image='export20.gif' page='report/system/access_export' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_90}
</ul>

{include file="grn/system_footer.tpl"}
