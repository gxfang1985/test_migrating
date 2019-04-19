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
       <li class="display_options_dialog_ch">{capture name='grn_message_unconfirmed_list'}{cb_msg module='grn.message' key='unconfirmed_list' app_name=$app_name noescape='true'}{/capture}{grn_link page='message/unconfirmed_index' cid=$cid caption=$smarty.capture.grn_message_unconfirmed_list image='msg20.gif'}
       </li>

        <li class="display_options_dialog_ch">{capture name='grn_message_GRN_MSG_405'}{cb_msg module='grn.message' key='GRN_MSG-405' replace='true'}{/capture}{grn_link page='message/delete_all' cid=$cid caption=$smarty.capture.grn_message_GRN_MSG_405 image='delete20.gif' script='javascript:void(0);' id="lnk_delete_all"}
        </li>
      </ul>
    </span>
    <iframe id="iframe-breadcrumb"class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>