{grn_load_javascript file="grn/html/display_options.js"}
{grn_load_css file="grn/html/display_options.css"}
<script type="text/javascript" language="javascript">
<!--
{literal}
GRN_DisplayOptions['1094'] = GRN_DisplayOptionFactory.create();

GRN_DisplayOptions['1094'].setPage('{/literal}{$page_key}{literal}');
GRN_DisplayOptions['1094'].setCSRFTicket('{/literal}{$csrf_ticket}{literal}');
GRN_DisplayOptions['1094'].setListID('{/literal}{$_id}{literal}');
GRN_DisplayOptions['1094'].setPLID('1094');
jQuery(document).ready(function(){
    GRN_DisplayOptions['1094'].init();
});
{/literal}
//-->
</script>

<span class="display_options">
    <span><a id="display_options_switch1094" href="javascript:void(0);">{grn_image image='folder20.gif'}{cb_msg module='grn.mail' key='GRN_MAIL-407' replace='true'}<span id="display_options_down_allow1094">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}</span><span id="display_options_up_allow1094" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}</span></a></span>
    <span id="display_options_dialog1094" class="display_options_dialog" style="display:none;">
        <ul>
        <li class="display_options_dialog_ch">{capture name='grn_mail_GRN_MAIL_144'}{cb_msg module='grn.mail' key='GRN_MAIL-144' replace='true'}{/capture}{grn_link page='mail/folder_add' caption=$smarty.capture.grn_mail_GRN_MAIL_144 image='folder20.gif' aid=$category.aid cid=$category.cid sid=$status_id}
        </li>
    {if $has_sibling_folders}
        <li class="display_options_dialog_ch">{capture name='grn_mail_GRN_MAIL_145'}{cb_msg module='grn.mail' key='GRN_MAIL-145' replace='true'}{/capture}{grn_link page='mail/folder_order' caption=$smarty.capture.grn_mail_GRN_MAIL_145 image='order20.gif' aid=$category.aid cid=$category.cid sid=$status_id}
        </li>
    {else}
        <li class="display_options_dialog_ch">{capture name='grn_mail_GRN_MAIL_146'}{cb_msg module='grn.mail' key='GRN_MAIL-146' replace='true'}{/capture}{grn_link page='mail/folder_order' caption=$smarty.capture.grn_mail_GRN_MAIL_146 image='order20.gif' disabled=true}
        </li>
    {/if}
    
    {if $category.type eq "4"}{assign var='disabled' value=1}{/if}
        <li class="display_options_dialog_ch">{capture name='grn_mail_GRN_MAIL_147'}{cb_msg module='grn.mail' key='GRN_MAIL-147' replace='true'}{/capture}{grn_link page='mail/folder_view' caption=$smarty.capture.grn_mail_GRN_MAIL_147 image='detail20.gif'  aid=$category.aid cid=$category.cid sid=$status_id disabled=$disabled}
        </li>
      </ul>
    </span>
    <iframe id="iframe-breadcrumb1094" class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>



