{grn_load_javascript file="grn/html/display_options.js"}
{grn_load_css file="grn/html/display_options.css"}
<script type="text/javascript" language="javascript">
<!--
{literal}
GRN_DisplayOptions['{/literal}{$plid}{literal}'] = GRN_DisplayOptionFactory.create();

GRN_DisplayOptions['{/literal}{$plid}{literal}'].setPage('{/literal}{$page_key}{literal}');
GRN_DisplayOptions['{/literal}{$plid}{literal}'].setCSRFTicket('{/literal}{$csrf_ticket}{literal}');
GRN_DisplayOptions['{/literal}{$plid}{literal}'].setListID('{/literal}{$_id}{literal}');
GRN_DisplayOptions['{/literal}{$plid}{literal}'].setPLID('{/literal}{$plid}{literal}');
jQuery(document).ready(function(){
    GRN_DisplayOptions['{/literal}{$plid}{literal}'].init();
});
{/literal}
//-->
</script>

<span class="display_options">
    <span><a id="display_options_switch{$plid}" href="javascript:void(0);">{grn_image image='image-common/menu20.png'}{cb_msg module='grn.schedule' key='display_options' replace='true'}<span id="display_options_down_allow{$plid}">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}</span><span id="display_options_up_allow{$plid}" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}</span></a></span>
    <span id="display_options_dialog{$plid}" class="display_options_dialog" style="display:none;">
      <ul>
        <li class="display_options_dialog_ch">{if $is_not_manage || $navi.count < 1}{assign var='delete_disabled' value='true'}{/if}{capture name='grn_report_operation_GRN_RPRT_OP_29'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-29' replace='true'}{/capture}{grn_link image='delete20.gif' page='report/operation/form_delete_all' cid=$category_id caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_29 disabled=$delete_disabled element_id="report/operation/form_delete_all"}
        </li>
        <li class="display_options_dialog_ch">{if $is_not_manage || $category_id==GRN_REPORT_CATEGORY_ROOT_ID}{assign var='is_not_manage' value='true'}{/if}{capture name='grn_report_operation_GRN_RPRT_OP_30'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-30' replace='true'}{/capture}{grn_link image='import20.gif' page='report/operation/form_import' cid=$category_id caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_30 disabled=$is_not_manage element_id="report/operation/form_import"}
        </li>
        <li class="display_options_dialog_ch">{capture name='grn_report_operation_GRN_RPRT_OP_31'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-31' replace='true'}{/capture}{grn_link image='export20.gif' page='report/operation/form_export' cid=$category_id caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_31 disabled=$delete_disabled element_id="report/operation/form_export"}
        </li>
      </ul>
    </span>
    <iframe id="iframe-breadcrumb"class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>


