{capture name='grn_report_system_GRN_RPRT_SY_95'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-95' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_95 id="`$page_info.last`_submit"}
{grn_button_cancel page='report/system/form_list' cid=$category_id sf=1}
