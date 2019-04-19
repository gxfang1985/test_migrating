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

{if $is_manage }
<span class="display_options">
    <span><a id="display_options_switch{$plid}" href="javascript:void(0);">{grn_image image='image-common/menu20.png'}{cb_msg module='grn.schedule' key='display_options' replace='true'}<span id="display_options_down_allow{$plid}">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}</span><span id="display_options_up_allow{$plid}" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}</span></a></span>
    <span id="display_options_dialog{$plid}" class="display_options_dialog" style="display:none;">
      <ul>
        <li class="display_options_dialog_ch">
            {capture name='grn_report_GRN_RPRT_262'}{cb_msg module='grn.report' key='GRN_RPRT-262' replace='true'}{/capture}{grn_link image='manage20.gif' page='report/operation/report_list' caption=$smarty.capture.grn_report_GRN_RPRT_262 disabled=$root_disable}
        </li>
        <li class="display_options_dialog_ch">
            {$is_form_manage == TRUE}
                {capture name='grn_report_GRN_RPRT_263'}{cb_msg module='grn.report' key='GRN_RPRT-263' replace='true'}{/capture}{grn_link image='report20.gif' page='report/operation/form_list' caption=$smarty.capture.grn_report_GRN_RPRT_263 disabled=$root_disable}
        </li>
        <li class="display_options_dialog_ch">
            {capture name='grn_report_GRN_RPRT_264'}{cb_msg module='grn.report' key='GRN_RPRT-264' replace='true'}{/capture}{grn_link image='access20.gif' page='report/operation/access_index' caption=$smarty.capture.grn_report_GRN_RPRT_264 disabled=$root_disable}
        </li>
        <li class="display_options_dialog_ch">
            {capture name='grn_report_GRN_RPRT_265'}{cb_msg module='grn.report' key='GRN_RPRT-265' replace='true'}{/capture}{grn_link image='filter20.gif' page='report/operation/filter_index' caption=$smarty.capture.grn_report_GRN_RPRT_265 disabled=$root_disable}
        </li>
      </ul>
    </span>
    <iframe id="iframe-breadcrumb"class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>
{/if}


