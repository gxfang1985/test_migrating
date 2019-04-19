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

{if $management && ($is_root || $type == 'share')}

 {if $is_root}
 <span class="display_options">
    <span><a id="display_options_switch{$plid}" href="javascript:void(0);">{grn_image image='image-common/menu20.png'}{cb_msg module='grn.schedule' key='display_options' replace='true'}<span id="display_options_down_allow{$plid}">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}</span><span id="display_options_up_allow{$plid}" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}</span></a></span>
    <span id="display_options_dialog{$plid}" class="display_options_dialog" style="display:none;">
      <ul>
        <li class="display_options_dialog_ch">{capture name='grn_link_GRN_LNK_105'}{cb_msg module='grn.link' key='GRN_LNK-105' replace='true'}{/capture}{grn_link image='linklist20.gif' page='link/operation/add' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_105}
        </li>
        <li class="display_options_dialog_ch">{capture name='grn_link_GRN_LNK_106'}{cb_msg module='grn.link' key='GRN_LNK-106' replace='true'}{/capture}{grn_link image='write20.gif' page='link/operation/separator_add' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_106}
        </li>
        <li class="display_options_dialog_ch">{capture name='grn_link_GRN_LNK_107'}{cb_msg module='grn.link' key='GRN_LNK-107' replace='true'}{/capture}{grn_link image='category20.gif' page='link/operation/category_add' pcid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_107}
        </li>
        <li class="display_options_dialog_ch">{capture name='grn_link_GRN_LNK_108'}{cb_msg module='grn.link' key='GRN_LNK-108' replace='true'}{/capture}{grn_link image='import20.gif' page='link/operation/import1' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_108}
        </li>
        <li class="display_options_dialog_ch">{capture name='grn_link_GRN_LNK_109'}{cb_msg module='grn.link' key='GRN_LNK-109' replace='true'}{/capture}{grn_link image='export20.gif' page='link/operation/export' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_109}
        </li>
        </ul>
    </span>
     {elseif  $type == 'share'}
     <span class="menu_item">{capture name='grn_link_GRN_LNK_105'}{cb_msg module='grn.link' key='GRN_LNK-105' replace='true'}{/capture}{grn_link image='linklist20.gif' page='link/operation/add' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_105}</span>
    <span class="menu_item">{capture name='grn_link_GRN_LNK_106'}{cb_msg module='grn.link' key='GRN_LNK-106' replace='true'}{/capture}{grn_link image='write20.gif' page='link/operation/separator_add' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_106}</span>
    <span class="menu_item">{capture name='grn_link_GRN_LNK_107'}{cb_msg module='grn.link' key='GRN_LNK-107' replace='true'}{/capture}{grn_link image='category20.gif' page='link/operation/category_add' pcid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_107}</span>
     <span class="display_options">
        <span><a id="display_options_switch{$plid}" href="javascript:void(0);">{grn_image image='image-common/menu20.png'}{cb_msg module='grn.schedule' key='display_options' replace='true'}<span id="display_options_down_allow{$plid}">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}</span><span id="display_options_up_allow{$plid}" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}</span></a></span>
        <span id="display_options_dialog{$plid}" class="display_options_dialog" style="display:none;">
          <ul>
            <li class="display_options_dialog_ch">{capture name='grn_link_GRN_LNK_108'}{cb_msg module='grn.link' key='GRN_LNK-108' replace='true'}{/capture}{grn_link image='import20.gif' page='link/operation/import1' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_108}
            </li>
            <li class="display_options_dialog_ch">{capture name='grn_link_GRN_LNK_109'}{cb_msg module='grn.link' key='GRN_LNK-109' replace='true'}{/capture}{grn_link image='export20.gif' page='link/operation/export' cid=$category_id caption=$smarty.capture.grn_link_GRN_LNK_109}
            </li>
        </ul>
        </span>
{/if}

{/if}
    <iframe id="iframe-breadcrumb{$plid}" class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>



