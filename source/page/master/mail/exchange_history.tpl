{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
<div class="mainarea-mail">
 <!--menubar-->
 <div id="menu_part">
{if ! $account_deleted and ! $account_disabled and ! $disable_mail}
 <span class="menu_item">{capture name='grn_mail_GRN_MAIL_90'}{cb_msg module='grn.mail' key='GRN_MAIL-90' replace='true'}{/capture}{grn_link page='mail/send' caption=$smarty.capture.grn_mail_GRN_MAIL_90 image='mail20.gif' aid=$set.aid cid=$set.cid to=$set.email_for_send disabled=$size_over}</span>
{/if}
 </div>
 <!--menubar_end-->
{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count}{/capture}
{include file="grn/smart_word_navi_mail.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right flag_history=true}

 <table class="list_column">
  <colgroup>
   <col width="1%">
   <col width="3%">
   <col width="17%">
   <col width="20%">
   <col width="11%">
{if $use_confirm}
   <col width="15%">
{/if}
{if $use_status}
   <col width="13%">
{/if}
   <col width="20%">
  </colgroup>
  <tr>
   <th nowrap>&nbsp;</th>
   <th nowrap>&nbsp;</th>
   <th nowrap>
    {capture name='grn_mail_GRN_MAIL_95'}{cb_msg module='grn.mail' key='GRN_MAIL-95' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_GRN_MAIL_95 page=$page_info.all sort=$sort.ctime.id reverse=$sort.ctime.reverse aid=$set.aid cid=$set.cid mid=$set.mid sid=$status_id email=$set.email disable=$sort.ctime.disable}
   </th>
   <th nowrap>{capture name='grn_mail_GRN_MAIL_96'}{cb_msg module='grn.mail' key='GRN_MAIL-96' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_GRN_MAIL_96 page=$page_info.all sort=$sort.subject.id reverse=$sort.subject.reverse aid=$set.aid cid=$set.cid mid=$set.mid sid=$status_id email=$set.email disable=$sort.subject.disable}</th>
   <th nowrap>{capture name='grn_mail_GRN_MAIL_97'}{cb_msg module='grn.mail' key='GRN_MAIL-97' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_GRN_MAIL_97 page=$page_info.all sort=$sort.size.id reverse=$sort.size.reverse aid=$set.aid cid=$set.cid mid=$set.mid sid=$status_id email=$set.email disable=$sort.size.disable}</th>
{if $use_confirm}
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-98' replace='true'}</th>
{/if}
{if $use_status}
   <th nowrap>{include file='mail/_selection_status.tpl' stid='stid' options=$status_infos}</th>
{/if}
   <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-100' replace='true'}</th>
  </tr>
{foreach from=$mails item=mail}
 {if ! $mail.disabled}
  {if $set.mid eq $mail.mid}
   {assign var='on_mail' value='mine'}
  {else}
   {assign var='on_mail' value=''}
  {/if}
 {else}
  {assign var='on_mail' value='gray'}
 {/if}
  <tr {if $mail.unread}class="unread_color"{/if}>
  <td class="{$on_mail}" nowrap><a id="toggle_link_{$mail.mid}" status="off" href="javascript:__thisPage.ToggleSummary('{$mail.mid}');">{grn_image image='plus.gif' id="toggle_image_`$mail.mid`"}</a></td>
   <td class="{$on_mail}" nowrap>{if $mail.type}{capture name='grn_mail_GRN_MAIL_101'}{cb_msg module='grn.mail' key='GRN_MAIL-101' replace='true'}{/capture}{grn_image image='sentArrow16.png' alt=$smarty.capture.grn_mail_GRN_MAIL_101}{else}{capture name='grn_mail_GRN_MAIL_102'}{cb_msg module='grn.mail' key='GRN_MAIL-102' replace='true'}{/capture}{grn_image image='receiveArrow16.png' alt=$smarty.capture.grn_mail_GRN_MAIL_102}{/if}</td>
   <td class="{$on_mail}" nowrap>{grn_date_format date=$mail.ctime format='DateTimeMiddle_YMDW_HM'}</td>
   <td class="{$on_mail}" nowrap>
 {if $mail.type eq '0' || $mail.type eq '1'} {* 受信メッセージ/送信メッセージ *}
  {if $mail.attach_file}
   {if $mail.unread}
    {grn_link page='mail/view' caption=$mail.subject image='mail_clip30x20.gif' truncated_caption=$characters.subject unread=1 mid=$mail.mid disabled=$mail.disabled mail_unread_id="mail_unread_`$mail.mid`"}
   {else}
    {grn_link page='mail/view' caption=$mail.subject image='mail_clip30x20.gif' truncated_caption=$characters.subject mid=$mail.mid disabled=$mail.disabled mail_unread_id="mail_unread_`$mail.mid`" }
   {/if}
  {else}
   {if $mail.unread}
     {grn_link page='mail/view' caption=$mail.subject image='mail20.gif' truncated_caption=$characters.subject unread=1 mid=$mail.mid disabled=$mail.disabled mail_unread_id="mail_unread_`$mail.mid`" }
   {else}
     {grn_link page='mail/view' caption=$mail.subject image='mail20.gif' truncated_caption=$characters.subject mid=$mail.mid disabled=$mail.disabled }
   {/if}
  {/if}
 {/if}
   </td>
   <td class="{$on_mail}">{if ! $mail.disabled}{grn_format_filesize size=$mail.size unit='KB'}{else}&nbsp;{/if}</td>
{if $use_confirm}
   <td class="{$on_mail}">
 {if $mail.type eq '0'}{* 受信メッセージ *}
  {if $mail.open eq '4'}{* 開封通知 *}
    {cb_msg module='grn.mail' key='GRN_MAIL-103' replace='true'}
  {elseif $mail.open eq '2'}{* 開封通知メール送信済み *}
    {*開封確認済*}
  {/if}
 {else}{* 送信メッセージ *}
  {if $mail.open eq '3'}{* 開封確認要求メール *}
    {*開封確認要求*}
  {elseif $mail.open eq '4'}{* 開封確認メール *}
    {cb_msg module='grn.mail' key='GRN_MAIL-104' replace='true'}
  {/if}
 {/if}
 {if 0}
  {if $mail.open eq '2'}{* 開封確認メール送信済み *}
    {cb_msg module='grn.mail' key='GRN_MAIL-105' replace='true'}
  {elseif $mail.open eq '3'}{* 開封確認メール受け取り済み *}
    {cb_msg module='grn.mail' key='GRN_MAIL-106' replace='true'}
  {else}
    &nbsp;
  {/if}
 {/if}
   </td>
 {/if}
{if $use_status}
   <td class="{$on_mail}">{if $mail.status_name}<div style="color: #{$mail.status_color};">{$mail.status_name|escape}{else}&nbsp;</div>{/if}</td>
{/if}
   <td class="{$on_mail}">{if $mail.account neq ''}<span>{grn_image image='mailaccount20.gif'}{$mail.account|escape}</span>{else}&nbsp;{/if}</td>
  </tr>
  {*Summary row*}
    <tr id="summary_row_{$mail.mid}" style="display:none;"> 
        <td colspan="{if $use_star && $category.type neq '4'}3{else}2{/if}" class="summaryCell"></td>
        <td colspan="6" class="summaryCell">
        <div class="summary{if $mail.unread} unread_color{/if}" style="display:block">
            <div id="iframe_summary_item_{$mail.mid}" class="summary_content_grn" style="height: 20px;display:none;"></div>
            <div id="summary_item_{$mail.mid}" has_data="false">{grn_image image='spinner.gif'}</div>
        </div>
        </td>
    </tr>
    
{/foreach}
 </table>
{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count}{/capture}
{include file="grn/smart_word_navi_mail.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right flag_history=true bottom=1}
 </div>
</div>
{grn_load_javascript file="grn/html/page/mail/mail.js"}
{grn_load_javascript file="grn/html/component/mail/DropDown.js"}
{grn_load_javascript file="grn/html/page/mail/exchange_history.js"}
<script language="javascript">
    var __thisPage = grn.page.mail.mail;
</script>
<script language="javascript">
   __thisPage.IMG_PATH = '{$app_path}/grn/image/cybozu/';
   __thisPage.ajax_mail_preview_url = '{grn_pageurl page="mail/ajax_mail_preview"}';
   __thisPage.csrf_ticket = '{$csrf_ticket}';
{literal}
function show_another_tab_icon(elm)
{
    elm.attr("class", "new_tab_icon_show");
}

function hide_another_tab_icon(elm)
{
    elm.attr("class", "new_tab_icon_hide");
}

function show_popup_delete(data,mid,aid,cid,folder_type,use_garbagebox)
{
    var tmp_div = jQuery("<div id='tmpdiv'></div>");
    var tmp_div_text = tmp_div.text(data);
    var escape_html =  tmp_div_text.html();
    if (folder_type == '4' || use_garbagebox == '0'){
    {/literal}
        data = "<p>" + "{cb_msg module='grn.mail' key='GRN_MAIL-212' replace='true'}" + "</br><span class='bold'> <span class='mail20'>" + escape_html + "</span></span>" + "</p>";
    {literal}
    }else{
    {/literal}
        data = "<p>" + "{cb_msg module='grn.mail' key='GRN_MAIL-211' replace='true'}" + "<br><span class='bold' ><span class='mail20'>" + escape_html + "</span></span>" + "</p>";
    {literal}
    }
    GRN_MsgBox.show(data, 
                    {/literal}'{cb_msg module="grn.mail" key="GRN_MAIL-421" replace="true"}'{literal},                    GRN_MsgBoxButtons.yesno,
                                { ui       : {},
                                  caption : {yes: {/literal}"{cb_msg module='grn.common' key='yes'}",
                                             no: "{cb_msg module='grn.common' key='no'}"{literal}},
                                  callback : function(result, form){
                                      if(result == GRN_MsgBoxResult.yes){
                                        delete_mail();
                                      }
                                  }
                                }
  );

  function delete_mail()
  {
      document.body.style.cursor = "progress";
      jQuery('input[name="aid"]').val(aid);
      jQuery('input[name="mid"]').val(mid);
      jQuery('input[name="cid"]').val(cid);
      document.forms['mail/delete'].submit();
  }
}

{/literal}
</script>
{*** END PREVIEW EMAIL ***}

<form name="mail/delete" method="post" action="{grn_pageurl page='mail/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="aid" id="aid" value="{$mail.aid}">
<input type="hidden" name="cid" id="cid" value="{$mail.cid}">
<input type="hidden" name="mid" id="mid" value="{$mail.mid}">
</form>
{include file="grn/footer.tpl"}
