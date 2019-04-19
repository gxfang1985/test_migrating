{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/page/mail/mobile/mail_list.js"}
<script language="JavaScript" type="text/javascript">
  var G = grn.page.mail.mobile.mail_list;
  G.aid = "{$account_id}";
  G.cid = "{$category_id}";
  G.commandMailListUrl = "{grn_pageurl page='mail/mobile/ajax/command_mail_list'}";
</script>
{assign var="beforeAjaxSend" value="grn.page.mail.mobile.mail_list.`$delete_multi_info.beforeAjaxSend`"}
{assign var="afterAjaxSend" value="grn.page.mail.mobile.mail_list.`$delete_multi_info.afterAjaxSend`"}
{grn_mobile_delete title=$delete_multi_info.title page=$delete_multi_info.page no_confirm=$delete_multi_info.no_confirm data=$delete_multi_info.data handler=$delete_multi_info.handler multi_target=$delete_multi_info.multi_target form_target=$delete_multi_info.form_target beforeAjaxSend=$beforeAjaxSend afterAjaxSend=$afterAjaxSend}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
  {include file='grn/mobile_breadcrumb.tpl'}
  {if $no_setting neq '0'}
    {grn_title title=$app_name class=$page_info.parts[0]}
    {include file='mail/_no_setting.tpl'}
  {else}
    {include file='mail/mobile/_notes.tpl'}
    {include file='mail/mobile/_receive_button.tpl'}
    {if $count > 0}
      <form name="mail/mobile/mail_list">
        <ul id="mobile_mail_list" data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_list_withcheckbox_grn">
          {foreach from=$mails item=mail}
            <li data-icon="false" id="{$mail.mid}">
              {strip}
                <div>
                  <span class="mobile_list_btn_checkboxoff_grn"></span>
                  <span class="mobile_list_checkbox_grn"><input name="ids[]" type="checkbox" value="{$mail.mid}"></span>
                </div>
                <a href="{grn_pageurl page='mail/mobile/view' mid=$mail.mid sp=$sp}" class="mobile-list-text-grn mobile_list_table_grn">
                  <div class="mobile_list_table_td_grn">
                    <div class="mobile_list_lines_grn">
                      <ul>
                        <li>
                          {if $mail.unread}<span class="mobile_list_icon_unread_grn"></span>{/if}
                          <span class="mobile_list_users_grn">{$mail.name|escape}</span>
                          <span class="mobile_list_date_grn">{grn_date_format date=$mail.time format='DateTimeDetailCompact'}</span>
                        </li>
                        <li>
                          <span class="mobile_list_content_grn {if $mail.attach_file}mobile_list_textposition_1icon_grn{/if}">
                            {if $mail.action}
                              {if $mail.action eq '1'}{* 返信 *}
                                <span class="mobile_mail_icon_position_grn mobile_icon_replys_grn"></span>
                              {elseif $mail.action eq '2'}{* 全員に返信 *}
                                <span class="mobile_mail_icon_position_grn mobile_icon_replyalls_grn"></span>
                              {elseif $mail.action eq '3'}{* 転送 *}
                                <span class="mobile_mail_icon_position_grn mobile_icon_forwards_grn"></span>
                              {/if}
                            {/if}
                            {if $mail.subject eq ''}{cb_msg module='grn.mail' key='no_title'}{else}{$mail.subject|escape}{/if}
                          </span>
                          {if $mail.attach_file}
                            <span class="mobile_list_icon_attachmentssub_grn mobile_list_iconposition_grn"></span>
                          {/if}
                        </li>
                      </ul>
                    </div>
                  </div>
                  <span class="mobile_list_icon_arraylist_grn"></span>
                </a>
              </li>
            {/strip}
          {/foreach}
        </ul>
      </form>
    {else}
      <div class="mobile_balloon_grn">{cb_msg module='grn.mail' key='GRN_MAIL-450' replace='true'}</div>
      <div class="mobile_balloon_down_grn">
        <div class="mobile_triangle_grn"></div>
      </div>
      <div class="mobile_balloon_icon_grn">
        <div class="mobile_app_mail_b_grn"></div>
      </div>
    {/if}
    {include file='grn/mobile_page_navigation.tpl'}
  {/if}
</div>

<div id="mail_list_checkboxon" data-role="footer" data-position="fixed" data-tap-toggle="false" data-theme="{$data_theme}" style="display:none;">
  <div class="mobile_list_navbar_grn">
    <ul>
      {strip}
        <li id="delete_multi" class="mobile_list_navbar_left_grn"><a href="javascript:void(0);">{cb_msg module='grn.mail' key='GRN_MAIL-437' replace='true'}</a></li>
        <li class="mobile_list_navbar_center_grn" onclick="javascript:grn.page.mail.mobile.mail_list.unread();"><a href="javascript:void(0);">{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-2' replace='true'}</a></li>
        <li class="mobile_list_navbar_rightlink_grn" onclick="javascript:grn.page.mail.mobile.mail_list.clearCheck();"><a href="javascript:void(0);">{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-4' replace='true'}</a></li>
        <li class="mobile_list_navbar_right_grn" onclick="javascript:grn.page.mail.mobile.mail_list.read();"><a href="javascript:void(0);">{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-3' replace='true'}</a></li>
      {/strip}
    </ul>
  </div>
</div>
