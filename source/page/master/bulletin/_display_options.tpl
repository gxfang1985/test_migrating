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
        {if $category.privileges.operation}
        <li class="display_options_dialog_ch">{capture name='grn_bulletin_GRN_BLLT_57'}{cb_msg module='grn.bulletin' key='GRN_BLLT-57' replace='true'}{/capture}{grn_link page='bulletin/operation/category_add' caption=$smarty.capture.grn_bulletin_GRN_BLLT_57 image='write20.gif' cid=$category.cid}</li>
        {if $category.child_count > 1}
          <li class="display_options_dialog_ch">{capture name='grn_bulletin_GRN_BLLT_58'}{cb_msg module='grn.bulletin' key='GRN_BLLT-58' replace='true'}{/capture}{grn_link page='bulletin/operation/category_order' caption=$smarty.capture.grn_bulletin_GRN_BLLT_58 image='order20.gif' cid=$category.cid}</li>
        {else}
          <li class="display_options_dialog_ch">{capture name='grn_bulletin_GRN_BLLT_59'}{cb_msg module='grn.bulletin' key='GRN_BLLT-59' replace='true'}{/capture}{grn_link page='bulletin/operation/category_order' caption=$smarty.capture.grn_bulletin_GRN_BLLT_59 image='order20.gif' cid=$category.cid disabled=true}</li>
        {/if}
        <li class="display_options_dialog_ch">{capture name='grn_bulletin_GRN_BLLT_60'}{cb_msg module='grn.bulletin' key='GRN_BLLT-60' replace='true'}{/capture}{grn_link page='bulletin/operation/category_view' caption=$smarty.capture.grn_bulletin_GRN_BLLT_60 image='detail20.gif' cid=$category.cid}</li>
        {/if}
        {if $category.privileges.operation}
        {include file="bulletin/_members_dialog_options.tpl" show_members_dialog=$show_members_dialog category_id=$category.cid article_id=$article_id show_up_line=true show_bottom_line=true}
        {else}
        {include file="bulletin/_members_dialog_options.tpl" show_members_dialog=$show_members_dialog category_id=$category.cid article_id=$article_id show_up_line=false show_bottom_line=false}
        {/if}
        {if $category.privileges.operation}
        <li class="display_options_dialog_ch">{capture name='grn_bulletin_GRN_BLLT_62'}{cb_msg module='grn.bulletin' key='GRN_BLLT-62' replace='true'}{/capture}{grn_link page='bulletin/operation/access_list' caption=$smarty.capture.grn_bulletin_GRN_BLLT_62 image='access20.gif' nid=$category.cid}</li>
        <li class="display_options_dialog_ch">{capture name='grn_bulletin_GRN_BLLT_624'}{cb_msg module='grn.bulletin' key='GRN_BLLT-624' replace='true'}{/capture}{grn_link page='bulletin/operation/privilege_list' caption=$smarty.capture.grn_bulletin_GRN_BLLT_624 image='manager20.png' nid=$category.cid}</li>
        <li class="display_options_dialog_ch">{capture name='grn_bulletin_GRN_BLLT_63'}{cb_msg module='grn.bulletin' key='GRN_BLLT-63' replace='true'}{/capture}{grn_link page='bulletin/operation/notify_list' caption=$smarty.capture.grn_bulletin_GRN_BLLT_63 image='subscribe20.png' nid=$category.cid}</li>
        <li class="display_options_dialog_ch">{capture name='grn_bulletin_GRN_BLLT_61'}{cb_msg module='grn.bulletin' key='GRN_BLLT-61' replace='true'}{/capture}{grn_link page='bulletin/operation/bulletin_list' caption=$smarty.capture.grn_bulletin_GRN_BLLT_61 image='manage20.gif' cid=$category.cid}</li>
        {/if}
      </ul>
    </span>
    <iframe id="iframe-breadcrumb" class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>



