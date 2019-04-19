{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_report_system_GRN_RPRT_SY_487'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-487' replace='true'}{/capture}{grn_link image='import20.gif' page='report/system/category_import1' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_487}
<li>{capture name='grn_report_system_GRN_RPRT_SY_561'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-561' replace='true'}{/capture}{grn_link image='import20.gif' page='report/system/category_name_import1' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_561}
<li>{capture name='grn_report_system_GRN_RPRT_SY_488'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-488' replace='true'}{/capture}{grn_link image='import20.gif' page='report/system/access_import1' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_488}
</ul>

{include file='grn/system_footer.tpl'}
