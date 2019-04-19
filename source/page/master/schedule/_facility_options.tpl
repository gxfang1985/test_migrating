{grn_load_javascript file="grn/html/display_options.js"}
{grn_load_css file="grn/html/display_options.css"}
<script type="text/javascript" language="javascript">
<!--
{literal}
GRN_DisplayOptions['_facility_options'] = GRN_DisplayOptionFactory.create();

GRN_DisplayOptions['_facility_options'].setPage('{/literal}{$page_key}{literal}');
GRN_DisplayOptions['_facility_options'].setCSRFTicket('{/literal}{$csrf_ticket}{literal}');
GRN_DisplayOptions['_facility_options'].setListID('{/literal}{$_id}{literal}');
GRN_DisplayOptions['_facility_options'].setPLID('_facility_options');
jQuery(document).ready(function(){
    GRN_DisplayOptions['_facility_options'].init();
});
{/literal}
//-->
</script>

<span class="display_options">
    <span><a id="display_options_switch_facility_options" href="javascript:void(0);">{grn_image image='image-common/menu20.png'}{cb_msg module='grn.schedule' key='GRN_SCH-1044' replace='true'}<span id="display_options_down_allow_facility_options">{grn_image class="menu_arrow_grn" image="arrow_down_single_gray.gif"}</span><span id="display_options_up_allow_facility_options" style="display:none;">{grn_image class="menu_arrow_grn" image="arrow_up_single_gray.gif"}</span></a></span>
    <span id="display_options_dialog_facility_options" class="display_options_dialog" style="display:none;">
      <ul>
        <li class="display_options_dialog_ch">
            {capture name='grn_schedule_GRN_SCH_659'}{cb_msg module='grn.schedule' key='GRN_SCH-659' replace='true'}{/capture}{grn_link page='schedule/operation/facility_list' caption=$smarty.capture.grn_schedule_GRN_SCH_659 image='image-common/setting20.png' fagid=$fagid}
        </li>
        {if $hasRequireApprovalFacility}
        <li class="display_options_dialog_ch">
            {capture name='grn_schedule_GRN_SCH_1045'}{cb_msg module='grn.schedule' key='GRN_SCH-1045' replace='true'}{/capture}{grn_link page='schedule/operation/approval_facility_list' caption=$smarty.capture.grn_schedule_GRN_SCH_1045 image='image-common/list20.png'}
        </li>
        {/if}
      </ul>
    </span>
    <iframe id="iframe-breadcrumb_view" class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>