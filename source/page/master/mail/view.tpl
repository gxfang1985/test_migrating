{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_load_javascript file="grn/html/folder_select.js"}
{grn_load_javascript file="grn/html/page/mail/view.js"}
<div class="mainarea-mail">
    <div id="main_menu_part">
        <span class="mail-menuMain-grn">
            {if $mail.sent}
                {if ! $disable_mail}
                    <span class="menu_item">{capture name='grn_mail_GRN_MAIL_2'}{cb_msg module='grn.mail' key='GRN_MAIL-2' replace='true'}{/capture}{grn_link page='mail/resend' caption=$smarty.capture.grn_mail_GRN_MAIL_2 image='reuse20.gif' mid=$mail.mid disabled=$size_over alt=''}</span>
                {/if}
                <span class="menu_item">{capture name='grn_mail_GRN_MAIL_4'}{cb_msg module='grn.mail' key='GRN_MAIL-4' replace='true'}{/capture}{grn_link page='mail/delete' caption=$smarty.capture.grn_mail_GRN_MAIL_4 image='delete20.gif' script='javascript:void(0);' id="lnk_delete" alt=''}</span>
                <span class="menu_item">{capture name='grn_mail_GRN_MAIL_6'}{cb_msg module='grn.mail' key='GRN_MAIL-6' replace='true'}{/capture}{grn_link page='mail/print' caption=$smarty.capture.grn_mail_GRN_MAIL_6 image='print20.gif' mid=$mail.mid alt=''}</span>
            {else}
                {if ! $disable_mail}
                    <span class="menu_item">{capture name='grn_mail_GRN_MAIL_7'}{cb_msg module='grn.mail' key='GRN_MAIL-7' replace='true'}{/capture}{grn_link page='mail/reply' caption=$smarty.capture.grn_mail_GRN_MAIL_7 image='mail20_r.gif' mid=$mail.mid disabled=$size_over alt=''}</span>
                    <span class="menu_item">{capture name='grn_mail_GRN_MAIL_8'}{cb_msg module='grn.mail' key='GRN_MAIL-8' replace='true'}{/capture}{grn_link page='mail/reply_all' caption=$smarty.capture.grn_mail_GRN_MAIL_8 image='mail20_a.gif' mid=$mail.mid disabled=$size_over alt=''}</span>
                    <span class="menu_item">{capture name='grn_mail_GRN_MAIL_9'}{cb_msg module='grn.mail' key='GRN_MAIL-9' replace='true'}{/capture}{grn_link page='mail/forward' caption=$smarty.capture.grn_mail_GRN_MAIL_9 image='mail20_f.gif' mid=$mail.mid disabled=$size_over alt=''}</span>
                {/if}
                <span class="menu_item">{capture name='grn_mail_GRN_MAIL_12'}{cb_msg module='grn.mail' key='GRN_MAIL-12' replace='true'}{/capture}{grn_link page='mail/delete' caption=$smarty.capture.grn_mail_GRN_MAIL_12 image='delete20.gif' script='javascript:void(0);' id="lnk_delete" alt=''}</span>
                <span class="menu_item">{capture name='grn_mail_GRN_MAIL_14'}{cb_msg module='grn.mail' key='GRN_MAIL-14' replace='true'}{/capture}{grn_link page='mail/print' caption=$smarty.capture.grn_mail_GRN_MAIL_14 image='print20.gif' mid=$mail.mid alt=''}</span>
            {/if}
            <span class="menu_item">
                {include file='mail/_mail_detail_option_pulldown.tpl'}
            </span>

            <span class="mail-menuSub-grn">
                <form name="top_move" method="post" action="{grn_pageurl page='mail/command_view'}" class="inline_block_grn">
                    {capture name='grn_message_GRN_MAIL_406'}{cb_msg module='grn.mail' key='GRN_MAIL-406' replace='true'}{/capture}
                    {include file='mail/_change_folder.tpl' no_account=1 selected_folder_id=$folder.cid hide_root_folder=1 hide_garbage_folder=1 show_another_account=1 c_name='dcid' c_id='dcid' exception_value="-1" exception_item=$smarty.capture.grn_message_GRN_MAIL_406 default_selected='true' detail_mail=true}
                    {if $status_infos}
                        {grn_select name='status' options=$status_infos onchange="cmd.value='change';submit(this.form)" class="selectStandard-grn mRight10"}
                    {/if}
                    <input type='hidden' name='cmd' value="move">
                    <input type='hidden' name='aid' value="{$mail.aid}">
                    <input type='hidden' name='cid' value="{$mail.cid}">
                    <input type='hidden' name='mid' value="{$mail.mid}">
                    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                </form>
            </span>
        </span>
        <span class="mail-pagingButtonBlock-grn">
            {if $previous_navi_params}
                <span class="mail-pagingButtonDetail-grn">
                    <a href='{cb_pageurl page=$previous_navi_params.page mid=$previous_navi_params.page_params.mid}'>
                    <span class="mail-pagingbuttonArrowLeft-grn"></span></a>
            {else}
                <span class="mail-pagingButtonDetailDisable-grn"><span class="mail-pagingbuttonArrowLeft-grn"></span>
            {/if}
                </span>

            {if $next_navi_params}
                <span class="mail-pagingButtonDetail-grn">
                    <a href='{cb_pageurl page=$next_navi_params.page mid=$next_navi_params.page_params.mid}'>
                    <span class="mail-pagingbuttonArrowRight-grn"></span></a>
            {else}
                <span class="mail-pagingButtonDetailDisable-grn"><span class="mail-pagingbuttonArrowRight-grn"></span>
            {/if}
                </span>
        </span>
        <div class="clear_both_0px"></div>
    </div> {* end of main_menu_part *}

    {if $use_star}
        {include file="star/star_init.tpl" list_id="mail_list"}
        <div id="mail_list">
            {grn_star_icon module="grn.mail" star_infos=$star_infos unique_id=$mail.mid mid=$mail.mid no_style=1}
    {/if}
    {if $status_mail != -1}
        {if $status_mail.value == 2}
            <span class="mail-statusUnCheck-grn">{$status_mail.label}</span>
        {elseif $status_mail.value == 3}
            <span class="mail-statusNeedSend-grn">{$status_mail.label}</span>
        {elseif $status_mail.value == 4}
            <span class="mail-statusCheck-grn">{$status_mail.label}</span>
        {elseif $status_mail.value == 5}
            <span class="mail-statusHold-grn">{$status_mail.label}</span>
        {elseif $status_mail.value == 6}
            <span class="mail-statusWaitSend-grn">{$status_mail.label}</span>
        {/if}
    {/if}
    {if $mail.subject eq ''}
        {grn_title caption_module='grn.mail' caption_key='no_title' class=$page_info.parts[0]|cat:" inline_block_grn" no_style=1}
    {else}
        {grn_title title=$mail.subject class=$page_info.parts[0]|cat:" inline_block_grn" no_style=1}
    {/if}
    {if $use_star}</div>{/if}

    {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
    {grn_load_javascript file="grn/html/wm.js"}
    <!-- main menu -->

{if $use_confirm}
<!-- note -->
    {if ! $mail.sent and $mail.confirmation_request}
        {if ! $disable_mail and ($mail.open eq '1') and ($mail.confirmation_to neq '')}
            <div class="notes">
                <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-17' replace='true'}<br>
                    <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-18' replace='true'}</span><br>
                    <span>{cb_msg module='grn.mail' key='GRN_MAIL-19' replace='true'}{$mail.confirmation_to|escape}{cb_msg module='grn.mail' key='GRN_MAIL-20' replace='true'}<br></span>
                </div>
                <form name="mail_open" method="post" action="{grn_pageurl page='mail/command_open'}">
                    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                    {capture name='grn_mail_GRN_MAIL_21'}{cb_msg module='grn.mail' key='GRN_MAIL-21' replace='true'}{/capture}{grn_button_submit name="open" caption=$smarty.capture.grn_mail_GRN_MAIL_21 onclick="cmd.value='open';"}&nbsp;&nbsp;
                    {capture name='grn_mail_GRN_MAIL_22'}{cb_msg module='grn.mail' key='GRN_MAIL-22' replace='true'}{/capture}{grn_button_submit name="ignored" caption=$smarty.capture.grn_mail_GRN_MAIL_22 onclick="cmd.value='ignored';"}
                    <input type='hidden' name='cmd'>
                    <input type='hidden' name='mid' value="{$mail.mid}">
                    <input type='hidden' name='aid' value="{$mail.aid}">
                </form>
            </div>
        {elseif $mail.open eq '2'}{*送信済み*}
            <div class="notes">
                <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-23' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-24' replace='true'}<br>
                    <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-25' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-26' replace='true'}</span><br>
                    {if $mail.confirm.response_mails}
                        {foreach from=$mail.confirm.response_mails item=response_mail name='responses'}
                            {if $response_mail.mid eq ''}
                                {assign var='response_disabled' value=1}
                            {else}
                                {assign var='response_disabled' value=0}
                            {/if}
                            {grn_link image='mail20.gif' page='mail/view' caption="`$response_mail.subject`" mid=$response_mail.mid disabled=$response_disabled}{if ! $smarty.foreach.responses.last}, {/if}
                        {/foreach}
                    {/if}
                </div>
            </div>
        {/if}
    {elseif $mail.confirmation_response}
        <div class="notes">
            <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-27' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-28' replace='true'}<br>
                {if $mail.confirm.org_mail}
                    <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-29' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-30' replace='true'}</span><br>
                    {foreach from=$mail.confirm.org_mail item=org_mail name='org_mails'}
                        {if $org_mail.mid eq ''}
                            {assign var='org_disabled' value=1}
                        {else}
                            {assign var='org_disabled' value=0}
                        {/if}
                        {if $org_mail.subject eq ''}
                            {grn_link image='mail20.gif' page='mail/view' caption_module='grn.mail' caption_key='no_title' mid=$org_mail.mid disabled=$org_disabled}
                        {else}
                            {grn_link image='mail20.gif' page='mail/view' caption="`$org_mail.subject`" mid=$org_mail.mid disabled=$org_disabled}
                        {/if}
                        {if ! $smarty.foreach.org_mails.last}, {/if}
                    {/foreach}
                {/if}
            </div>
        </div>
    {elseif $mail.sent and $mail.confirmation_request}
        <div class="notes">
            <div class="explanation">{cb_msg module='grn.mail' key='GRN_MAIL-31' replace='true'}{$app_name}{cb_msg module='grn.mail' key='GRN_MAIL-32' replace='true'}<br>
                {if $mail.confirm.response_mails}
                    <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-33' replace='true'}</span><br>
                {else}
                    <span class="attention">{cb_msg module='grn.mail' key='GRN_MAIL-34' replace='true'}</span><br>
                {/if}
                {foreach from=$mail.confirm.response_mails item=response_mail name='responses'}
                    {if $response_mail.mid eq ''}
                        {assign var='response_disabled' value=1}
                    {else}
                        {assign var='response_disabled' value=0}
                    {/if}
                    {grn_link image='mail20.gif' page='mail/view' caption="`$response_mail.from`" mid=$response_mail.mid disabled=$response_disabled}{if ! $smarty.foreach.responses.last}, {/if}
                {/foreach}
            </div>
        </div>
    {/if}
{/if}

<!-- mail header -->
<div class="contents_area">

{if $mail.sent eq "0"}
    {if $charset_on}
        <div id="display_mail_charset_header" class="float_right">
    {else}
        <div id="display_mail_charset_header" class="float_right" style="display:none">
    {/if}
    <div class="mail_charset">
        <form name="charset_change_header" method="post" action="{grn_pageurl page='mail/command_change_charset'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td>{cb_msg module='grn.mail' key='GRN_MAIL-40' replace='true'}&nbsp;{grn_mail_charset name='charset_header' default=$charset_header}&nbsp;{capture name='grn_mail_GRN_MAIL_41'}{cb_msg module='grn.mail' key='GRN_MAIL-41' replace='true'}{/capture}{grn_button_submit class="buttonStandard-grn" caption=$smarty.capture.grn_mail_GRN_MAIL_41 onclick="if(this.form.charset_header.selectedIndex == 0) return false; cmd.value='save';"}</td>
                </tr>
            </table>
            <input type="hidden" name="mid" value="{$mail.mid}">
            <input type="hidden" name="cmd" value="">
            <input type="hidden" name="charset_on" value="1">
        </form>
    </div>
    </div>
{/if}

<table width="100%" class="mail_view_detail">
    <tr>
        <td class="mail-detailLabel-grn" width="5%" nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-44' replace='true'}</td>
        <td width="1%" nowrap>&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-45' replace='true'}&nbsp;</td>
        <td>{grn_mail_name type=$name_type data_type='from' name_format=$name_format show_address=1 name=$mail.from aid=$mail.aid cid=$mail.cid mid=$mail.mid page='address/index'}</td>
    </tr>
    <tr>
        <td class="mail-detailLabel-grn">{cb_msg module='grn.mail' key='GRN_MAIL-46' replace='true'}</td>
        <td>&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}&nbsp;</td>
        <td>{grn_date_format date=$mail.ctime format='DateTimeMiddle_YMDW_HM'}</td>
    </tr>
    {if $to_count || ($cc_count || $has_cc neq '') || ($mail.sent and $bcc_count) }
        {if $to_count}
            <tr valign="top">
                <td class="mail-detailLabel-grn" nowrap>{if $to_count }<span class="bold">{cb_msg module='grn.mail' key='GRN_MAIL-48' replace='true'}&nbsp;</span>{if $to_count >= 2}<span>{cb_msg module='grn.mail' key='GRN_MAIL-75' replace='true'}{$to_count}{cb_msg module='grn.mail' key='GRN_MAIL-54' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-77' replace='true'}&nbsp;</span>{/if}{/if}&nbsp;</td>
                <td nowrap>&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-53' replace='true'}&nbsp;</td>
                <td>
                    {if $to_count < 2}
                        {grn_mail_name show_faddress=1 type=$name_type data_type='to' name_format=$name_format name=$mail.to aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all}
                    {else}
                        <span id="all_addressee_close">{grn_mail_name show_faddress=1 type=$name_type data_type='to' name_format=$name_format name=$mail.to aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all}&nbsp;...&nbsp;{if !$has_cc && !$has_bcc}<small>{cb_msg module='grn.mail' key='GRN_MAIL-57' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close')">{cb_msg module='grn.mail' key='GRN_MAIL-58' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-59' replace='true'}</small>{/if}</span>
                        <span id="all_addressee_open" style="display: none">
                        {if $to_count }
                            {grn_mail_name type=$name_type data_type='to' name_format=$name_format name=$mail.to aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all}
                            {if !$has_cc && !$has_bcc}<small>{cb_msg module='grn.mail' key='GRN_MAIL-60' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close')">{cb_msg module='grn.mail' key='GRN_MAIL-61' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-62' replace='true'}</small>{/if}
                        {/if}
                        </span>
                    {/if}
                </td>
            </tr>
        {/if}
        {if $cc_count || $has_cc neq '' }
        <tr valign="top">
            <td class="mail-detailLabel-grn" nowrap>{if $cc_count }<span class="bold">Cc&nbsp;</span>{if $cc_count >= 2}<span>{cb_msg module='grn.mail' key='GRN_MAIL-75' replace='true'}{$cc_count}{cb_msg module='grn.mail' key='GRN_MAIL-55' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-77' replace='true'}&nbsp;&nbsp;&nbsp;</span>{/if}{/if}&nbsp;</td>
            <td nowrap>&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-53' replace='true'}&nbsp;</td>
            <td>
                {if $to_count + $cc_count > 2 || $cc_count > 1 }
                    <span id="display_addressee_close">{grn_mail_name show_faddress=1 type=$name_type data_type='cc' name_format=$name_format name=$mail.cc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all}{if $cc_count >= 2}&nbsp;...&nbsp;{/if}
                    {if !$has_bcc}
                        <small>{cb_msg module='grn.mail' key='GRN_MAIL-57' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close:display_addressee_close:display_addressee_open')">{cb_msg module='grn.mail' key='GRN_MAIL-58' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-59' replace='true'}</small>
                    {/if}
                    </span>
                    <span id="display_addressee_open" style="display:none">
                        {if $has_cc neq ''}
                            {grn_mail_name type=$name_type data_type='cc' name_format=$name_format name=$mail.cc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all}
                            {if !$has_bcc}
                            <small>{cb_msg module='grn.mail' key='GRN_MAIL-60' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close:display_addressee_close:display_addressee_open')">{cb_msg module='grn.mail' key='GRN_MAIL-61' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-62' replace='true'}</small>
                            {/if}
                        {/if}
                    </span>
                {else}
                    {grn_mail_name show_faddress=1 type=$name_type data_type='cc' name_format=$name_format name=$mail.cc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all}
                {/if}
            </td>
        </tr>
        {/if}
        {if $has_bcc}
        <tr valign="top">
            <td class="mail-detailLabel-grn" nowrap>
                    <span class="bold">{cb_msg module='grn.mail' key='GRN_MAIL-426' replace='true'}&nbsp;</span>{if $bcc_count >= 2}<span>{cb_msg module='grn.mail' key='GRN_MAIL-75' replace='true'}{$bcc_count}{cb_msg module='grn.mail' key='GRN_MAIL-55' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-77' replace='true'}&nbsp;&nbsp;&nbsp;</span>{/if}
            </td>
            <td nowrap>&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-53' replace='true'}&nbsp;</td>
            <td>
                {if ($to_count + $cc_count + $bcc_count > 3) || ($bcc_count eq 1 && $to_count > 1) || ($bcc_count eq "1" && $cc_count>1) || $bcc_count >1}
                    <span id="display_swith_image_close_bcc">{grn_mail_name show_faddress=1 type=$name_type data_type='bcc' name_format=$name_format name=$mail.bcc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all}{if $bcc_count >= 2}&nbsp;...&nbsp;{/if}
                    {if $has_bcc}
                        <small>{cb_msg module='grn.mail' key='GRN_MAIL-57' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close:display_addressee_close:display_addressee_open:display_swith_image_open_bcc:display_swith_image_close_bcc')">{cb_msg module='grn.mail' key='GRN_MAIL-58' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-59' replace='true'}</small>
                    {/if}
                    </span>
                    <span id="display_swith_image_open_bcc" style="display:none">
                        {if $has_bcc neq ''}
                            {grn_mail_name type=$name_type data_type='bcc' name_format=$name_format name=$mail.bcc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all}
                            <small>{cb_msg module='grn.mail' key='GRN_MAIL-60' replace='true'}<a href="javascript:void(0);display_on_off('all_addressee_open:all_addressee_close:display_addressee_close:display_addressee_open:display_swith_image_open_bcc:display_swith_image_close_bcc')">{cb_msg module='grn.mail' key='GRN_MAIL-61' replace='true'}</a>{cb_msg module='grn.mail' key='GRN_MAIL-62' replace='true'}</small>
                        {/if}
                    </span>
                {else}
                    {grn_mail_name show_faddress=1 type=$name_type data_type='bcc' name_format=$name_format name=$mail.bcc aid=$mail.aid cid=$mail.cid mid=$mail.mid page=$page_info.all}
                {/if}
            </td>
        </tr>
        {/if}
    {/if}
</table>

{if $no_body}
    <!-- mail body -->
    <div class="border-partition-common-grn"></div>
    <div class='explanation'>
        {cb_msg module='grn.mail' key='GRN_MAIL-63' replace='true'} <br>
        {cb_msg module='grn.mail' key='GRN_MAIL-64' replace='true'}
    </div>
{elseif $mail.is_partial}
    <div class='explanation'>
        {cb_msg module='grn.mail' key='GRN_MAIL-65' replace='true'}<br>
        {cb_msg module='grn.mail' key='GRN_MAIL-68' replace='true'}<br>
        {cb_msg module='grn.mail' key='GRN_MAIL-70' replace='true'}
    </div>
{else}
    {if $mail.html_data}
      {if !$can_show_html}
        {grn_load_javascript file="grn/html/component/mail/confirm_show_html.js"}
        <script type="text/javascript">
          <!--
          var __confirmShowHtml = grn.component.mail.confirm_show_html;
          __confirmShowHtml.dialogMessage = "{cb_msg module='grn.mail' key='GRN_MAIL-471' replace='true'}";
          __confirmShowHtml.getDataUrl = "{grn_pageurl page='mail/html_contents'}";
          __confirmShowHtml.param = "mid={$mail.mid}&newpage=1";
          //-->
        </script>
        <span>
          <div class="border-partition-common-grn"></div>
          <a href="javascript:void(0);" onclick="javascript:__confirmShowHtml.showConfirmDialog(true);">{cb_msg module='grn.mail' key='GRN_MAIL-470' replace='true'}</a>
        </span>
      {elseif $show_display_image_button}
        <span id="display_image">
        <div class="border-partition-common-grn"></div>
        <a href="{grn_pageurl page='mail/view' mid=$mail.mid}" onclick="javascript:showFullMailContent(event)">{cb_msg module='grn.mail' key='GRN_MAIL-74' replace='true'}</a>
        </span>
      {/if}
    {/if}
    <div class="border-partition-common-grn"></div>

    {if $mail.sent eq "0"}
        {if $charset_on}
            <div id="display_mail_charset_body">
        {else}
            <div id="display_mail_charset_body" style="display:none">
        {/if}
        <div class="mail_charset">
            <form name="charset_change_body" method="post" action="{grn_pageurl page='mail/command_change_charset'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <table cellpadding="2" cellspacing="2">
                    <tr>
                        <td>{cb_msg module='grn.mail' key='GRN_MAIL-78' replace='true'}&nbsp;{grn_mail_charset name='charset_body' default=$charset_body}&nbsp;{capture name='grn_mail_GRN_MAIL_79'}{cb_msg module='grn.mail' key='GRN_MAIL-79' replace='true'}{/capture}{grn_button_submit class="buttonStandard-grn" caption=$smarty.capture.grn_mail_GRN_MAIL_79 onclick="if(this.form.charset_body.selectedIndex == 0) return false; cmd.value='save';"}</td>
                    </tr>
                </table>
                <input type="hidden" name="mid" value="{$mail.mid}">
                <input type="hidden" name="cmd" value="">
                <input type="hidden" name="charset_on" value="1">
            </form>
        </div>
        <br><br><br>
        </div>
    {/if}
    <div class="margin_vert">
        {if $mail.html_data eq "1" && $can_show_html}
            {literal}
            <script type="text/javascript">
            var html_mail_url = '{/literal}{grn_pageurl page="mail/html_contents"}{literal}';
            var post_data = 'mid={/literal}{$mail.mid}{literal}&csrf_ticket={/literal}{$csrf_ticket}{literal}';
            function resize(){
                var f = document.getElementById("the_iframe");
                var fdocument = f.contentDocument || f.contentWindow.document;
                jQuery(f).css( "height", fdocument.body.scrollHeight + "px" );
            }
            function setFrameContent(bodyContents) {
                var f = document.getElementById("the_iframe");
                var fdocument = setIFrameContent(f, bodyContents, "{/literal}{grn_get_url_prefix}{literal}");
                var height = fdocument.body.scrollHeight;
                if (grn.browser.msie) {
                    height = height + 30;
                }
                jQuery(f).css( "height", height + "px" );
            }
            function showFullMailContent(evt) {
                if (evt.preventDefault) {
                    evt.preventDefault();
                }
                else {
                    evt.returnValue = false;
                }
                jQuery("#display_image").hide();

                var ajaxRequest = new grn.component.ajax.request({
                    url: html_mail_url,
                    method: "post",
                    data: post_data,
                    grnRedirectOnLoginError: true
                });

                ajaxRequest.send().done(function (data) {
                    setFrameContent(data);
                });
            }
            jQuery(function(){
                var mc = jQuery("#mail_content");
                setFrameContent(mc.html());
                mc.html("");
            });
            </script>
            {/literal}
            <iframe id="the_iframe" frameborder="0" class="mail_content_frame_grn"></iframe>
            <div id="mail_content" style='display:none'>{$mail.data|grn_noescape}</div>
        {else}
            {if $truncated}
                <div class='attention'><span class='subnotify16 bold'>{cb_msg module='grn.mail' key='mail_truncated' replace='true'}</span></div>
                <div class="border-partition-common-grn"></div>
            {/if}
            {grn_format body=$mail.data}
        {/if}
    </div>

    {if !empty($mail.inline_files)}
        <div class="border-partition-common-grn"></div>
        <div>
            <div class="mLeft7">
                <div class="mBottom7">
                    <span class="action_text_grn">
                        <a href="javascript:void(0);" id="mail_show_inline_files_button"><span class="icon_inline_grn icon_show_element_b_grn"></span><span>{cb_msg module='grn.mail' key='GRN_MAIL-472' replace='true'}</span></a>
                        <a href="javascript:void(0);" id="mail_hide_inline_files_button" style="display:none;"><span class="icon_inline_grn icon_hide_element_b_grn"></span><span>{cb_msg module='grn.mail' key='GRN_MAIL-473' replace='true'}</span></a>
                    </span>
                </div>
            </div>
            <div style="display: none;" id="mail_inline_files">
                <tt class="mail_attachment_list_2pane_grn">
                  <ul>
                      {foreach from=$mail.inline_files item=file key=file_key}
                          {if $mail.attach_file_type eq '2'}
                              <li class="disable_filter_grn disable_filter_block_grn" aria-disabled="true">
                              {grn_image image='clip8x20.gif'}{$file.name|escape}
                          {else}
                              <li>
                              {if $mail.sent eq '1'}
                                  {if $file.exists}
                                      {assign var='no_source' value=false}
                                  {else}
                                      {assign var='no_source' value=true}
                                  {/if}
                              {else}
                                  {assign var='no_source' value=$mail.no_source}
                              {/if}
                              {grn_mail_attach_file_link name=$file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key pids=$pids mime=$file.mime inline=$inline no_source=$no_source receive=$mail.receive hash=$file.hash}
                          {/if}
                          </li>
                      {/foreach}
                    </ul>
                </tt>
            </div>
        </div>
    {/if}

    {if !empty($mail.attach_files)}
        <div class="border-partition-common-grn"></div>
        <tt class="mail_attachment_list_2pane_grn">
            <ul>
                {foreach from=$mail.attach_files item=attach_file key=file_key}
                    {if $mail.attach_file_type eq '2'}
                        <li class="disable_filter_grn disable_filter_block_grn" aria-disabled="true">
                        {grn_image image='clip8x20.gif'}{$attach_file.name|escape}
                    {else}
                        <li>
                        {if $mail.sent eq '1'}
                            {if $attach_file.exists}
                                {assign var='no_source' value=false}
                            {else}
                                {assign var='no_source' value=true}
                            {/if}
                        {else}
                            {assign var='no_source' value=$mail.no_source}
                        {/if}
                            {grn_mail_attach_file_link name=$attach_file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key pids=$pids mime=$attach_file.mime inline=$inline no_source=$no_source receive=$mail.receive hash=$attach_file.hash}
                    {/if}
                    </li>
                {/foreach}
            </ul>
        </tt>
    {/if}
{/if}

<span class="mail-pagingButtonBottomBlock-grn">
    {if $previous_navi_params}
    <span class="mail-pagingButtonDetail-grn">
        <a href='{cb_pageurl page=$previous_navi_params.page mid=$previous_navi_params.page_params.mid}'>
        <span class="mail-pagingbuttonArrowLeft-grn"></span></a>
    {else}
        <span class="mail-pagingButtonDetailDisable-grn"><span class="mail-pagingbuttonArrowLeft-grn"></span>
    {/if}
    
    </span>

    {if $next_navi_params}
    <span class="mail-pagingButtonDetail-grn">
        <a href='{cb_pageurl page=$next_navi_params.page mid=$next_navi_params.page_params.mid}'>
        <span class="mail-pagingbuttonArrowRight-grn"></span></a>
    {else}
        <span class="mail-pagingButtonDetailDisable-grn"><span class="mail-pagingbuttonArrowRight-grn"></span>
    {/if}
    </span>
</span>
</div>
</div>
{include file="grn/footer.tpl"}
