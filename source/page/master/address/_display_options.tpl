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

{if $access.operation}
<span class="display_options">
    <span><a id="display_options_switch{$plid}" href="javascript:void(0);">{grn_image image='image-common/menu20.png'}{cb_msg module='grn.schedule' key='display_options' replace='true'}<span id="display_options_down_allow{$plid}">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}</span><span id="display_options_up_allow{$plid}" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}</span></a></span>
    <span id="display_options_dialog{$plid}" class="display_options_dialog" style="display:none;">
      <ul>
        <li class="display_options_dialog_ch">{capture name='grn_address_GRN_ADDR_52'}{cb_msg module='grn.address' key='GRN_ADDR-52' replace='true'}{/capture}{grn_link page='address/operation/item_list' caption=$smarty.capture.grn_address_GRN_ADDR_52 image='adminbasic20.gif' bid=$book_id}
        </li>
        <li class="display_options_dialog_ch">{capture name='grn_address_GRN_ADDR_53'}{cb_msg module='grn.address' key='GRN_ADDR-53' replace='true'}{/capture}{grn_link page='address/operation/access_list' caption=$smarty.capture.grn_address_GRN_ADDR_53 image='access20.gif' nid=$book_id reset=true}
        </li>
        <li class="display_options_dialog_ch">{capture name='grn_address_GRN_ADDR_54'}{cb_msg module='grn.address' key='GRN_ADDR-54' replace='true'}{/capture}{grn_link page='address/operation/import1' caption=$smarty.capture.grn_address_GRN_ADDR_54 image='import20.gif' bid=$book_id}
        </li>
        <li class="display_options_dialog_ch">{capture name='grn_address_GRN_ADDR_55'}{cb_msg module='grn.address' key='GRN_ADDR-55' replace='true'}{/capture}{grn_link page='address/operation/export' caption=$smarty.capture.grn_address_GRN_ADDR_55 image='export20.gif' bid=$book_id}
        </li>
      </ul>
    </span>
    <iframe id="iframe-breadcrumb"class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>
{/if}


