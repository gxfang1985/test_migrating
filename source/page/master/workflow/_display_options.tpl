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
        <li class="display_options_dialog_ch"><nobr>{capture name='grn_workflow_manage_application_data'}{cb_msg module='grn.workflow' key='manage_application_data' replace='true'}{/capture}{grn_link image='manage20.gif' page='workflow/operation/petition_list' caption=$smarty.capture.grn_workflow_manage_application_data folder_id=$folder_id}</nobr>
        </li>
        <li class="display_options_dialog_ch"><nobr>{capture name='grn_workflow_manage_application_form'}{cb_msg module='grn.workflow' key='manage_application_form' replace='true'}{/capture}{grn_link image='workflow_form20.gif' page='workflow/operation/form_list' caption=$smarty.capture.grn_workflow_manage_application_form folder_id=$folder_id}</nobr>
        </li>
        <li class="display_options_dialog_ch"><nobr>{capture name='grn_workflow_set_access_permission'}{cb_msg module='grn.workflow' key='set_access_permission' replace='true'}{/capture}{grn_link image='access20.gif' page='workflow/operation/access_index' caption=$smarty.capture.grn_workflow_set_access_permission folder_id=$folder_id}</nobr>
        </li>
        <li class="display_options_dialog_ch"><nobr>{capture name='grn_workflow_publicity_setting_application_data'}{cb_msg module='grn.workflow' key='publicity_setting_application_data' replace='true'}{/capture}{grn_link image='public20.gif' page='workflow/operation/public_index' caption=$smarty.capture.grn_workflow_publicity_setting_application_data folder_id=$folder_id}</nobr>
        </li>
      </ul>
    </span>
    <iframe id="iframe-breadcrumb"class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>
{/if}


