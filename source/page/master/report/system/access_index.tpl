{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="explanation">
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-91' replace='true'}
</div>

<p>
{capture name='grn_report_system_GRN_RPRT_SY_92'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-92' replace='true'}{/capture}{capture name='grn_report_system_GRN_RPRT_SY_93'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-93' replace='true'}{/capture}{capture name='grn_report_system_GRN_RPRT_SY_94'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-94' replace='true'}{/capture}{include file='grn/tree_access_index.tpl' node_name=$smarty.capture.grn_report_system_GRN_RPRT_SY_92 node_image='category20.gif' prop_name=$smarty.capture.grn_report_system_GRN_RPRT_SY_93 prop_code=$smarty.capture.grn_report_system_GRN_RPRT_SY_94 page_prefix='report/system/' no_virtual_root=1}

{include file="grn/system_footer.tpl"}
