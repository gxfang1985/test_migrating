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

{if $folder.privileges.operation}
<span class="display_options">
    <span><a id="display_options_switch{$plid}" href="javascript:void(0);">{grn_image image='image-common/menu20.png'}{cb_msg module='grn.schedule' key='display_options' replace='true'}<span id="display_options_down_allow{$plid}">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}</span><span id="display_options_up_allow{$plid}" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}</span></a></span>
    <span id="display_options_dialog{$plid}" class="display_options_dialog" style="display:none;">
      <ul>
        <li class="display_options_dialog_ch">{capture name='grn_cabinet_GRN_CAB_196'}{cb_msg module='grn.cabinet' key='GRN_CAB-196' replace='true'}{/capture}{grn_link page="cabinet/operation/folder_add" caption=$smarty.capture.grn_cabinet_GRN_CAB_196 image="folder20.gif" hid=$folder_id}</li>
        <li class="display_options_dialog_ch">{capture name='grn_cabinet_GRN_CAB_197'}{cb_msg module='grn.cabinet' key='GRN_CAB-197' replace='true'}{/capture}{grn_link page="cabinet/operation/folder_view" caption=$smarty.capture.grn_cabinet_GRN_CAB_197 image="detail20.gif" hid=$folder_id}</li>
        {if $folder.child_count > 1}
          <li class="display_options_dialog_ch">{capture name='grn_cabinet_GRN_CAB_198'}{cb_msg module='grn.cabinet' key='GRN_CAB-198' replace='true'}{/capture}{grn_link page="cabinet/operation/folder_order" caption=$smarty.capture.grn_cabinet_GRN_CAB_198 image="order20.gif" hid=$folder_id}</li>
        {else}
          <li class="display_options_dialog_ch">{capture name='grn_cabinet_GRN_CAB_199'}{cb_msg module='grn.cabinet' key='GRN_CAB-199' replace='true'}{/capture}{grn_link page="cabinet/operation/folder_order" caption=$smarty.capture.grn_cabinet_GRN_CAB_199 image="order20.gif" hid=$folder_id disabled=1}</li>
        {/if}
        <li class="display_options_dialog_ch">{capture name='grn_cabinet_GRN_CAB_290'}{cb_msg module='grn.cabinet' key='GRN_CAB-290' replace='true'}{/capture}{grn_link page="cabinet/operation/access_list" caption=$smarty.capture.grn_cabinet_GRN_CAB_290 image="access20.gif" nid=$folder_id}
        <li class="display_options_dialog_ch">{capture name='grn_cabinet_GRN_CAB_323'}{cb_msg module='grn.cabinet' key='GRN_CAB-323' replace='true'}{/capture}{grn_link page="cabinet/operation/privilege_list" caption=$smarty.capture.grn_cabinet_GRN_CAB_323 image="manager20.png" nid=$folder_id}
        <li class="display_options_dialog_ch">{capture name='grn_cabinet_GRN_CAB_291'}{cb_msg module='grn.cabinet' key='GRN_CAB-291' replace='true'}{/capture}{grn_link page="cabinet/operation/notify_list" caption=$smarty.capture.grn_cabinet_GRN_CAB_291 image="subscribe20.png" nid=$folder_id}
        <li class="display_options_dialog_ch">{capture name='grn_cabinet_GRN_CAB_302'}{cb_msg module='grn.cabinet' key='GRN_CAB-302' replace='true'}{/capture}{grn_link page="cabinet/operation/cabinet_order" caption=$smarty.capture.grn_cabinet_GRN_CAB_302 image="disk20.gif" hid=$folder_id}
      </ul>
    </span>
     <iframe id="iframe-breadcrumb"class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>
{/if}


