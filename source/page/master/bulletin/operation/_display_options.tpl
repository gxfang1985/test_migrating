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
        {include file="bulletin/_members_dialog_options.tpl" show_members_dialog=$show_members_dialog category_id=$category.cid article_id=$article_id show_up_line=false show_bottom_line=true}
        <li class="display_options_dialog_ch">{capture name='grn_bulletin_GRN_BLLT_6'}{cb_msg module='grn.bulletin' key='GRN_BLLT-6' replace='true'}{/capture}{grn_link page=$page_prefix|cat:'/bulletin_delete_all' caption=$smarty.capture.grn_bulletin_GRN_BLLT_6 image='delete20.gif' cid=$category_id}</li>
      </ul>
    </span>
    <iframe id="iframe-breadcrumb" class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>




