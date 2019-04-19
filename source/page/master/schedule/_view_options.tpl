{grn_load_javascript file="grn/html/display_options.js"}
{grn_load_css file="grn/html/display_options.css"}
<script type="text/javascript" language="javascript">
<!--
{literal}
GRN_DisplayOptions['_view'] = GRN_DisplayOptionFactory.create();

GRN_DisplayOptions['_view'].setPage('{/literal}{$page_key}{literal}');
GRN_DisplayOptions['_view'].setCSRFTicket('{/literal}{$csrf_ticket}{literal}');
GRN_DisplayOptions['_view'].setListID('{/literal}{$_id}{literal}');
GRN_DisplayOptions['_view'].setPLID('_view');
jQuery(document).ready(function(){
    GRN_DisplayOptions['_view'].init();
});
{/literal}
//-->
</script>

<span class="display_options">
    <span><a id="display_options_switch_view" href="javascript:void(0);">{grn_image image='image-common/menu20.png'}{cb_msg module='grn.schedule' key='display_options' replace='true'}<span id="display_options_down_allow_view">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}</span><span id="display_options_up_allow_view" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}</span></a></span>
    <span id="display_options_dialog_view" class="display_options_dialog" style="display:none;">
        <ul>
            <li class="options_dialog_subtitle_grn text_color_sub_grn bold_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1054' replace='true'}</li>
            <li class="display_options_dialog_ch">
                {capture name='grn_schedule_GRN_SCH_257'}{cb_msg module='grn.schedule' key='GRN_SCH-257' replace='true'}{/capture}{grn_link page='schedule/group_day' caption=$smarty.capture.grn_schedule_GRN_SCH_257 image='cal_gday20.gif' event=$schedule_event.event_id event_date=$bdate bdate=$bdate uid=$schedule_event.user_id gid=virtual}
            </li>
            <li class="display_options_dialog_ch">
                {capture name='grn_schedule_GRN_SCH_258'}{cb_msg module='grn.schedule' key='GRN_SCH-258' replace='true'}{/capture}{grn_link page='schedule/index' caption=$smarty.capture.grn_schedule_GRN_SCH_258 image='cal_gweek20.gif' event=$schedule_event.event_id event_date=$bdate bdate=$bdate uid=$schedule_event.user_id gid=virtual}
            </li>
            <li class="display_options_dialog_ch">
                {capture name='grn_schedule_GRN_SCH_621'}{cb_msg module='grn.schedule' key='GRN_SCH-621' replace='true'}{/capture}{grn_link page='schedule/personal_day' caption=$smarty.capture.grn_schedule_GRN_SCH_621 image='cal_pday20.gif' event=$schedule_event.event_id event_date=$bdate bdate=$bdate uid=$schedule_event.user_id gid=selected fragment=$schedule_event.url_fragment}
            </li>
            <li class="display_options_dialog_ch">
                {capture name='grn_schedule_GRN_SCH_742'}{cb_msg module='grn.schedule' key='GRN_SCH-742' replace='true'}{/capture}{grn_link page='schedule/personal_week' caption=$smarty.capture.grn_schedule_GRN_SCH_742 image='cal_pweek20.gif' event=$schedule_event.event_id event_date=$bdate bdate=$bdate uid=$schedule_event.user_id gid=selected fragment=$schedule_event.url_fragment}
            </li>
            <li class="partition_options_dialog_grn">
                <div class="border_partition_pulldown_grn"></div>
            </li>
            {if $space_createLinkData.isAvailable && $space_createLinkData.isAvailableForExternal}
                <li class="display_options_dialog_ch">
                    {capture name='tmp'}{cb_msg module='grn.schedule' key='create-space' replace='true'}{/capture}<a href="{grn_pageurl page="space/space_add_from_schedule" eid=$schedule_event.event_id}">{grn_image image="space20.png"}{$smarty.capture.tmp}</a>
                </li>
            {/if}
      </ul>
    </span>
    <iframe id="iframe-breadcrumb_view" class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>



