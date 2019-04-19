{grn_load_javascript file="grn/html/display_options.js"}
{grn_load_css file="grn/html/display_options.css"}
<script type="text/javascript" language="javascript">
<!--
{literal}
GRN_DisplayOptions['1118'] = GRN_DisplayOptionFactory.create();
GRN_DisplayOptions['1118'].setPage('{/literal}{$page_key}{literal}');
GRN_DisplayOptions['1118'].setCSRFTicket('{/literal}{$csrf_ticket}{literal}');
GRN_DisplayOptions['1118'].setListID('{/literal}{$_id}{literal}');
GRN_DisplayOptions['1118'].setPLID('1118');
jQuery(document).ready(function(){
    GRN_DisplayOptions['1118'].init();
});
{/literal}
//-->
</script>

<span class="display_options">
    <span><a id="display_options_switch1118" href="javascript:void(0);">{grn_image image='image-common/menu20.png' alt=''}{cb_msg module='grn.mail' key='GRN_MAIL-414' replace='true'}<span id="display_options_down_allow1118">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif' alt=''}</span><span id="display_options_up_allow1118" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif' alt=''}</span></a></span>
    <span id="display_options_dialog1118" class="display_options_dialog" style="display:none;">
        <ul>
            {if $space_createLinkData.isAvailable && $space_createLinkData.isAvailableForExternal}
                <li class="display_options_dialog_ch">
                    {capture name='grn_message_GRN_MSG_414'}{cb_msg module='grn.message' key='GRN_MSG-414' replace='true'}{/capture}<a href="{grn_pageurl page="space/space_add_from_message" mid=$message.mid rid=$rid}">{grn_image image="space20.png" alt=''}{$smarty.capture.grn_message_GRN_MSG_414}</a>
                </li>
            {/if}
            <li class="display_options_dialog_ch">
                {capture name='grn_message_GRN_MSG_91'}{cb_msg module='grn.message' key='GRN_MSG-91' replace='true'}{/capture}{capture name='grn_message_GRN_MSG_92'}{cb_msg module='grn.message' key='GRN_MSG-92' replace='true'}{/capture}{grn_link page='message/send_other' caption=$smarty.capture.grn_message_GRN_MSG_91|cat:$app_name|cat:$smarty.capture.grn_message_GRN_MSG_92 image='msg20.gif' cid=$message.cid rid=$rid mid=$message.mid alt=''}
            </li>
            {if $link_transfer_message_to_mail}
                <li class="display_options_dialog_ch">
                    {capture name='grn_message_GMSG_MSG_3'}{cb_msg module='grn.message' key='GMSG_MSG_3' app_name=$mail_name noescape='true'}{/capture}{grn_link page='mail/transfer_message_to_mail' caption=$smarty.capture.grn_message_GMSG_MSG_3 image='mail20.gif' message_id=$message.mid alt=''}
                </li>
            {/if}
            <li class="display_options_dialog_ch">
                {capture name='grn_message_GRN_MSG_93'}{cb_msg module='grn.message' key='GRN_MSG-93' replace='true'}{/capture}{grn_link page='message/export' postfix='notitle.txt' caption=$smarty.capture.grn_message_GRN_MSG_93 image='disk20.gif' cid=$message.cid rid=$rid mid=$message.mid alt=''}
            </li>
        </ul>
    </span>
    <iframe id="iframe-breadcrumb"class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>
