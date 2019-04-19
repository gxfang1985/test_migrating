{grn_load_javascript file="grn/html/page/mail/mobile/view.js"}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div class="mobile_navbar_menu_grn" style="left: 8px; right: auto;" id="mail_reply_operate_menu">
    <ul class="mobile_scroll_area_grn">
        {foreach from=$mail_reply_operate_menu key=key item=item}
            <li data-icon="false" data-theme="{$data_theme}" class="ui-btn ui-btn-up-c">
                <a href="{grn_pageurl page=$item.page params=$item.params}" onclick="javascript:grn.page.mail.mobile.view.closeReplyOperateMenu();">
                    {if $item.page == 'mail/mobile/reply'}
                        {cb_msg module='grn.mail' key='GRN_MAIL-434' replace='true'}
                    {elseif $item.page == 'mail/mobile/reply_all'}
                        {cb_msg module='grn.mail' key='GRN_MAIL-435' replace='true'}
                    {elseif $item.page == 'mail/mobile/forward'}
                        {cb_msg module='grn.mail' key='GRN_MAIL-436' replace='true'}
                    {/if}
                </a>
            </li>
        {/foreach}
    </ul>
</div>
<div class="mobile_triangle_e_grn" id="mail_reply_operate_menu_triangle"></div>

<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
    {include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}

    <!-- confirmation -->
    {if ! $mail.sent and $mail.confirmation_request}
        {if !$disable_mail and ($mail.open eq '1') and ($mail.confirmation_to neq '')}
            {assign var="show_confirm_button" value=true}
            <form name="mail_open" method="post" action="{grn_pageurl page='mail/mobile/ajax/command_open'}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <input type="hidden" name="cmd">
                <input type="hidden" name="mid" value="{$mail.mid}">
                <input type="hidden" name="aid" value="{$mail.aid}">
                <div class="mobile-cmt-operate-grn">
                    <div class="mobile_button_detail_grn">
                        <div data-theme="{$data_theme}" class="mobile_button_area_grn">
                            <div class="mobile_cancel_grn">
                                <input type="reset" value="{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-1' replace='true'}" data-inline="true" data-theme="{$data_theme}" onclick="grn.page.mail.mobile.view.sendReadMail('open','mail_open')"/>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        {/if}
    {/if}

    <!-- mail title -->
    <ul data-role="none" class="mobile-ul-withStar-grn mobile-textspace-withStar-grn mobile-detailTitle-grn">
        {if $show_confirm_button}
            <div class="mobile-separation-grn" id="mail_confirm_separation"></div>
        {/if}
        <li>
            {if $use_star}
                {include file="grn/mobile_star_init.tpl"}
                {grn_mobile_star_icon module='grn.mail' star_infos=$star_infos unique_id=$mail.mid mid=$mail.mid}
            {/if}
            <span>{$mail.subject|escape}</span>
        </li>
    </ul>

    <div class="mobile-cmt-operate-grn">
        <div class="mobile-separation-grn"></div>
        <!-- mail status-->
        {if  $status_mail.value > 1}
            <div class="mobile-list-todoDetail-grn">
                <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-440' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
                <div class="mobile_mail_status_grn mobile_contents_detail_grn">
                    {if $status_mail.value == 2}
                        <span class="mobile_status_uncheck_grn">{$status_mail.label}</span>
                    {elseif $status_mail.value == 3}
                        <span class="mobile_status_need_send_grn">{$status_mail.label}</span>
                    {elseif $status_mail.value == 4}
                        <span class="mobile_status_check_grn">{$status_mail.label}</span>
                    {elseif $status_mail.value == 5}
                        <span class="mobile_status_hold_grn">{$status_mail.label}</span>
                    {elseif $status_mail.value == 6}
                        <span class="mobile_status_wait_send_grn">{$status_mail.label}</span>
                    {/if}
                </div>
            </div>
            <div class="mobile-separation-grn"></div>
        {/if}

        <!-- from -->
        {if $mail.draft != '1'}
            <div class="mobile-list-todoDetail-grn">
                <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-44' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
                <div class="mobile_contents_detail_grn">{grn_mail_name name=$mail.from}</div>
            </div>
            <div class="mobile-separation-grn"></div>
        {/if}

        <!-- send_time -->
        <div class="mobile-list-todoDetail-grn">
            <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-46' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
            <div class="mobile_contents_detail_grn">
                <span>{grn_date_format date=$mail.ctime format='DateTimeMiddle_YMDW_HM'}</span>
            </div>
        </div>

        <ul data-role="listview" data-theme="{$data_theme}" class="mobile-li-PersonInCharge-grn mobile-div-title-grn">
            <div class="mobile-separation-grn"></div>
            <!-- To-->
            {if $mail.to_count > 0}
                <li data-icon="false">
                    <a href="{grn_pageurl page='mail/mobile/address_list' mid=$mail.mid key_word=2 sp=$sp}" class="mobile_mail_link_grn">
                        <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-48' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
                        <div class="mobile-contents-todoDetail-grn">
                            <span>{grn_mail_name show_faddress=1 name=$mail.to}</span>
                        </div>
                        <span class="totalNumber-grn">{$mail.to_count}</span>
                        <span class="mobile-array-todo-grn"></span>
                    </a>
                </li>
                <div class="mobile-separation-grn"></div>
            {elseif $mail.draft == '1'}
                <li data-icon="false">
                    <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-48' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
                    <div class="mobile-contents-todoDetail-grn"><span></span></div>
                </li>
            {/if}

            <!-- cc -->
            {if $mail.cc}
                <li data-icon="false">
                    <a href="{grn_pageurl  page='mail/mobile/address_list' mid=$mail.mid key_word=3 sp=$sp}" class="mobile_mail_link_grn">
                        <div class="mobile-label-small-grn">Cc{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
                        <div class="mobile-contents-todoDetail-grn">
                            <span>{grn_mail_name show_faddress=1 name=$mail.cc}</span>
                        </div>
                        <span class="totalNumber-grn">{$mail.cc_count}</span>
                        <span class="mobile-array-todo-grn"></span>
                    </a>
                </li>
                <div class="mobile-separation-grn"></div>
            {elseif $mail.draft == '1'}
                <li data-icon="false">
                    <div class="mobile-label-small-grn">Cc{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
                    <div class="mobile-contents-todoDetail-grn"><span></span></div>
                </li>
            {/if}

            <!-- bcc -->
            {if ($mail.sent == '1' || $mail.draft == '1') && $mail.bcc}
                <li data-icon="false">
                    <a href="{grn_pageurl  page='mail/mobile/address_list' mid=$mail.mid key_word=4 sp=$sp}" class="mobile_mail_link_grn">
                        <div class="mobile-label-small-grn">Bcc{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
                        <div class="mobile-contents-todoDetail-grn">
                            <span>{grn_mail_name show_faddress=1 name=$mail.bcc}</span>
                        </div>
                        <span class="totalNumber-grn">{$mail.bcc_count}</span>
                        <span class="mobile-array-todo-grn"></span>
                    </a>
                </li>
                <div class="mobile-separation-grn"></div>
            {elseif $mail.draft == '1'}
                <li data-icon="false">
                    <div class="mobile-label-small-grn">Bcc{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
                    <div class="mobile-contents-todoDetail-grn"><span></span></div>
                </li>
            {/if}
        </ul>

        <!-- attach files-->
        {if $mail.attach_files}
            {if $mail.attach_file_type}
                <div class="mobile-list-todoDetail-grn">
                    <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-338' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
                    <div class="mobile-attachmentButton-grn">
                        {foreach from=$mail.attach_files item=attach_file key=file_key}
                            {if $mail.attach_file_type eq '2'}
                                <div style="text-align:center">
                                    <span class="ui-btn-inner">
                                      <span class="ui-btn-text">
                                        <span class="mobile-icon-attachment-left-grn"></span>
                                        <span class="mobile-font-normal-grn">{$attach_file.name|escape:"html"}</span>
                                      </span>
                                    </span>
                                </div>
                            {else}
                                {if $mail.sent eq '1'}
                                    {if $attach_file.exists}
                                        {assign var='no_source' value=false}
                                    {else}
                                        {assign var='no_source' value=true}
                                    {/if}
                                {else}
                                    {assign var='no_source' value=$mail.no_source}
                                {/if}
                                {if $no_source}
                                    <div style="text-align:center">
                                        <span class="ui-btn-inner">
                                          <span class="ui-btn-text">
                                            <span class="mobile-icon-attachment-left-grn"></span>
                                            <span class="mobile-font-normal-grn">{$attach_file.name|escape:"html"}</span>
                                          </span>
                                        </span>
                                    </div>
                                {/if}
                                {grn_mobile_attach_file_link name=$attach_file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key}
                            {/if}
                        {/foreach}
                    </div>
                </div>
                <div class="mobile-separation-grn"></div>
            {/if}
        {/if}

        <!-- mail body-->
        <div class="mobile-list-todoDetail-grn mobile_scale_org_grn">
            <div id="body_title" class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-199' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
            {if $no_body}
                <div class="mobile-font-warp-grn"><span>{cb_msg module='grn.mail' key='GRN_MAIL-63' replace='true'}</span></div>
                <div class="mobile-font-warp-grn"><span>{cb_msg module='grn.mail' key='GRN_MAIL-64' replace='true'}</span></div>
            {elseif $mail.is_partial}
                <div class="mobile-font-warp-grn"><span>{cb_msg module='grn.mail' key='GRN_MAIL-65' replace='true'}</span></div>
                <div class="mobile-font-warp-grn"><span>{cb_msg module='grn.mail' key='GRN_MAIL-68' replace='true'}</span></div>
                <div class="mobile-font-warp-grn"><span>{cb_msg module='grn.mail' key='GRN_MAIL-70' replace='true'}</span></div>
            {else}
                {if $mail.html_data eq "1" && $can_show_html}
                    {if $show_display_image_button}
                        <div id="the_link" class="mobile-contents-todoDetail-new-grn">
                            <span id="display_image" class="mobile_mail_content_text_action_grn"><a href="{grn_pageurl page='mail/mobile/view' mid=$mail.id}" onclick="grn.page.mail.mobile.view.showFullMailContent(event)">{cb_msg module='grn.mail' key='GRN_MAIL-74' replace='true'}</a></span>
                            <script type="text/javascript">
                                grn.page.mail.mobile.view.htmlMailUrl = '{grn_pageurl page="mail/html_contents"}';
                                grn.page.mail.mobile.view.htmlPostData = 'mid={$mail.mid}&csrf_ticket={$csrf_ticket}';
                            </script>
                        </div>
                    {/if}
                    <div id="the_iframe" class="mobile-contents-todoDetail-new-grn mobile_scale_grn">
                        {$mail.data|grn_noescape}
                    </div>
                {else}
                    {if $mail.html_data eq "1" && !$can_show_html}
                        <div id="the_link" class="mobile-contents-todoDetail-new-grn">
                            {grn_load_javascript file="grn/html/component/mail/confirm_show_html.js"}
                            <script type="text/javascript">
                                <!--
                                var __confirmShowHtml = grn.component.mail.confirm_show_html;
                                __confirmShowHtml.dialogMessage = "{cb_msg module='grn.mail' key='GRN_MAIL-471' replace='true'}";
                                __confirmShowHtml.getDataUrl = "{grn_pageurl page='mail/mobile/html_contents'}";
                                __confirmShowHtml.param = "mid={$mail.mid}";
                                //-->
                            </script>
                            <span class="mobile_mail_content_text_action_grn"><a href="javascript:void(0);" onclick="javascript:__confirmShowHtml.showConfirmDialog(false);">{cb_msg module='grn.mail' key='GRN_MAIL-470' replace='true'}</a></span>
                        </div>
                    {/if}
                    <div id="the_iframe" class="mobile-contents-todoDetail-new-grn mobile_scale_grn">
                        {if $truncated}
                            <div>
                                <span class="mobile_icon_attention_grn"></span>
                                {cb_msg module='grn.mail' key='mail_truncated' replace='true'}
                            </div>
                        {/if}
                        {grn_mobile_format body=$mail.data}
                    </div>
                {/if}
            {/if}
        </div>

        <!-- draf開封確認-->
        {if $mail.draft == '1' and $mail.confirmation_request }
        <div class="mobile-separation-grn"></div>
        <div class="mobile-list-todoDetail-grn">
            <div class="mobile-label-small-grn">{cb_msg module='grn.mail' key='GRN_MAIL-373' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-47' replace='true'}</div>
            <div class="mobile-contents-todoDetail-grn">
                <span>{grn_image image='check16.gif'}{cb_msg module='grn.mail' key='GRN_MAIL-374' replace='true'}</span>
            </div>
        </div>
        {/if}

    </div>

</div>
