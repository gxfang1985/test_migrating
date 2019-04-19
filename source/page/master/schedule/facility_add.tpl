{grn_load_javascript file="grn/html/component/facility_add.js"}
{literal}
<script language="JavaScript" type="text/javascript">
    <!--
    {/literal}
    jQuery(function () {ldelim}
        new grn.component.facility_add.FacilityAdd("facility_select", "{$form_name}", "{$page_name}", "sITEM", "cITEM",
                {ldelim}
                    "idSearchBox": "facilities",
                    "searchUrl": grn.component.url.page('schedule/json/search_facility'),
                    "categorySelectUrl": grn.component.url.page('schedule/json/accessible_facility'),
                    "initUsingPurpose": "{$initUsingPurpose|escape:javascript}",
                    "csrfTicket": "{$csrf_ticket}"
                    {rdelim});
        {rdelim});
    //-->
</script>
<input type="hidden" name="selected_users_sITEM" value="">
<table class="table_plain_grn selectlist_base_grn">
    <tr>
        <td class="vAlignTop-grn" style="padding-left: 0;">
            <table class="table_plain_grn">
                <tr>
                    <td class="buttonSlectOrder-grn">
                        <div id="sITEM_order_up" class="mBottom10">
                            <a class="order_up_grn"
                               aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1565' replace='true'}"
                               title="{cb_msg module='grn.grn' key='GRN_GRN-1565' replace='true'}"
                               href="javascript:void(0)"></a>
                        </div>
                        <div id="sITEM_order_down" class="mBottom10">
                            <a class="order_down_grn"
                               aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1566' replace='true'}"
                               title="{cb_msg module='grn.grn' key='GRN_GRN-1566' replace='true'}"
                               href="javascript:void(0)"></a>
                        </div>

                    </td>
                    <td class="item_select">
                        {grn_facility_select_list list_name="sITEM" div_class_name="selectlist_l_grn focus_grn" select_all=true selected_item_options=$initialize_item style="height:151px;"}
                    </td>
                </tr>
            </table>
        </td>
        <td class="vAlignTop-grn item_right_left">
            <div class="buttonSelectMove-grn">
                <div class="mBottom15">
            <span class="aButtonStandard-grn">
                <a role="button" id="btn_add_cITEM" style="padding-left:0;" href="javascript:void(0);">
                    {strip}
                        <span class="icon-buttonArrowLeft-grn"></span>
                        <span class="aButtonText-grn">{cb_msg module='grn.schedule' key='GRN_SCH-810' replace='true'}</span>
                    {/strip}
                </a>
            </span>
                </div>
                <div>
            <span class="aButtonStandard-grn">
                <a role="button" id="btn_rmv_cITEM" style="padding-right:0;" href="javascript:void(0);">
                    {strip}
                        <span class="aButtonText-grn">{cb_msg module='grn.schedule' key='GRN_SCH-811' replace='true'}</span>
                        <span class="icon-buttonArrowRightBehind-grn"></span>
                    {/strip}
                </a>
            </span>
                </div>
            </div>
        </td>
        <td class="vAlignTop-grn">
            <div class="mTop3 mBottom7 clearFix-schedule">
                {capture name="placeholder"}{cb_msg module='grn.schedule' key='GRN_SCH-812' replace='true'}{/capture}
                {include file="grn/_search_box.tpl" id_searchbox="facilities" placeholder=$smarty.capture.placeholder}
            </div>

            <div class="clear_both_0px"></div>
            <div class="mBottom7">
            {include file="schedule/_item_add_dropdown_part.tpl" prefer_fg_button=1 use_dropdown=true}
            </div>
            <div class="mBottom5">
                {grn_facility_select_list list_name="cITEM" div_class_name="selectlist_r_grn" select_all=true view_detail=true selected_item_options=$all_facilities style="height:90px;" is_view_facility_path=true show_affiliation_group=$show_affiliation_group}
            </div>
        </td>
    </tr>
</table>
