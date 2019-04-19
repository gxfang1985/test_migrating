{grn_load_javascript file="grn/html/display_options.js"}
{grn_load_css file="grn/html/display_options.css"}
<script type="text/javascript" language="javascript">
<!--
{literal}
GRN_DisplayOptions['1098'] = GRN_DisplayOptionFactory.create();

GRN_DisplayOptions['1098'].setPage('{/literal}{$page_key}{literal}');
GRN_DisplayOptions['1098'].setCSRFTicket('{/literal}{$csrf_ticket}{literal}');
GRN_DisplayOptions['1098'].setListID('{/literal}{$_id}{literal}');
GRN_DisplayOptions['1098'].setPLID('1098');
jQuery(document).ready(function(){
    GRN_DisplayOptions['1098'].init();
});
{/literal}
//-->
</script>

<span class="display_options">
    <span><a id="display_options_switch1098" href="javascript:void(0);">{grn_image image='image-common/menu20.png' alt=''}{cb_msg module='grn.mail' key='GRN_MAIL-414' replace='true'}<span id="display_options_down_allow1098">{grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif' alt=''}</span><span id="display_options_up_allow1098" style="display:none;">{grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif' alt=''}</span></a></span>
    <span id="display_options_dialog1098" class="display_options_dialog" style="display:none;">
        <ul>
        <li class="display_options_dialog_ch">{capture name='grn_mail_GRN_MAIL_10'}{cb_msg module='grn.mail' key='GRN_MAIL-10' replace='true'}{/capture}{grn_link page='mail/personal/filter_add' caption=$smarty.capture.grn_mail_GRN_MAIL_10 image='mailfilter20.gif' mid=$mail.mid alt=''}
        </li>

        <li class="display_options_dialog_ch">{capture name='grn_mail_GRN_MAIL_11'}{cb_msg module='grn.mail' key='GRN_MAIL-11' replace='true'}{/capture}{grn_link page='mail/source' caption=$smarty.capture.grn_mail_GRN_MAIL_11 image='source20.gif' mid=$mail.mid sid=$mail.source_id disabled=$mail.no_source postfix='source.txt' alt=''}
        </li>

        <li class="display_options_dialog_ch">{capture name='grn_mail_GRN_MAIL_13'}{cb_msg module='grn.mail' key='GRN_MAIL-13' replace='true'}{/capture}{grn_link page='mail/export' postfix='notitle.txt' caption=$smarty.capture.grn_mail_GRN_MAIL_13 image='disk20.gif' mid=$mail.mid alt=''}
        </li>
        
         <li class="display_options_dialog_ch">{if $mail.sent eq "0"}
                                                {if $mail.no_source}
                                                    <span class="nowrap-grn"><span>{grn_image image='disk20.gif' alt=''}{cb_msg module='grn.mail' key='GRN_MAIL-40' replace='true'}</span></span>
                                                {else}
                                                    <a href="javascript:void(0);" onclick="display_on_off('display_mail_charset_header:display_mail_charset_body');">{grn_image image='disk20.gif' alt=''}{cb_msg module='grn.mail' key='GRN_MAIL-40' replace='true'}</a>
                                                {/if}
                                            {/if}
        </li>
        {* Text display *}
        {if $mail.html_data}
        <li class="display_options_dialog_ch">
        {capture name='grn_mail_GRN_MAIL_76'}{cb_msg module='grn.mail' key='GRN_MAIL-76' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_mail_GRN_MAIL_76 image='view20.gif' page='mail/text_contents' mid=$mail.mid alt=''}
        </li>
        {/if}
        {* End Text display *}
        {if $link_transfer_mail_to_message}
            <li class="display_options_dialog_ch">{capture name='grn_mail_GRMSG_MAIL_6'}{cb_msg module='grn.mail' key='GRMSG_MAIL_6' app_name=$message_name noescape='true'}{/capture}{grn_link page='message/transfer_mail_to_message' caption=$smarty.capture.grn_mail_GRMSG_MAIL_6 image='msg20.gif' mail_id=$mail.mid alt=''}
            </li>
        {/if}

        {if !empty($mail.inline_files) || !empty($mail.attach_files)}
            {if $mail.attach_file_type neq '2'}
                <li class="display_options_dialog_ch">
                    {capture name='grn_mail_GRN_MAIL_80'}{cb_msg module='grn.mail' key='GRN_MAIL-80' replace='true'}{/capture}{grn_link image='delete20.gif' caption=$smarty.capture.grn_mail_GRN_MAIL_80 page='mail/file_delete' script='javascript:void(0);' id="lnk_detele_file" alt=''}
                </li>
                {grn_delete title=$file_delete_info.title page=$file_delete_info.page no_confirm=$file_delete_info.no_confirm data=$file_delete_info.data handler=$file_delete_info.handler}
            {/if}
        {/if}
      </ul>
    </span>
    <iframe id="iframe-breadcrumb"class="iframe-breadcrumb" style="display:none;" src=""></iframe>
</span>



