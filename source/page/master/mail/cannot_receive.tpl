{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
<div class="mainarea-mail">
<div id="menu_part">
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <!--view--->
 <div id="view">
  <!----->

   {cb_msg module='grn.mail' key='GRN_MAIL-262' app_name=$app_name}{if $set.file_size}{cb_msg module='grn.mail' key='GRN_MAIL-263' replace='true'}&nbsp;<span class="bold">{$set.file_size}</span>({$set.file_unit}){cb_msg module='grn.mail' key='GRN_MAIL-264' replace='true'}&nbsp;{cb_msg module='grn.mail' key='GRN_MAIL-265' replace='true'}{/if}{cb_msg module='grn.mail' key='GRN_MAIL-266' app_name=$app_name}<br>
{cb_msg module='grn.mail' key='GRN_MAIL-268' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-269' replace='true'}
   <ul>
    <li>{cb_msg module='grn.mail' key='GRN_MAIL-270' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-271' replace='true'}
   </ul>
   <div class="list_menu"><nobr>
<span class="list_menu_item">{include file="grn/checkall.tpl" elem_name="uids[]"}</span>
{capture name='grn_mail_GRN_MAIL_272'}{cb_msg module='grn.mail' key='GRN_MAIL-272' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_mail_GRN_MAIL_272 id="btn_delete_multi" onclick="return false;"}
</nobr></div>
   <table class="list_column">
    <colgroup>
     <col width="1%">
     <col width="26%">
     <col width="28%">
     <col width="32%">
     <col width="14%">
    </colgroup>
    <tr>
     <th nowrap>&nbsp;</th>
     <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-273' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-274' replace='true'}</th>
     <th nowrap>{capture name='grn_mail_GRN_MAIL_275'}{cb_msg module='grn.mail' key='GRN_MAIL-275' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_GRN_MAIL_275 page=$page_info.all aid=$category.aid cid=$category.cid reverse=$reverse disable=0}</th>
     <th nowrap>{cb_msg module='grn.mail' key='GRN_MAIL-276' replace='true'}(KB)</th>
    </tr>
{foreach from=$mails item=mail key=uid}
    <tr class="{cycle values='linetwo,lineone'}">
     <td nowrap><input type="checkbox" name="uids[]" value="{$mail.uid|escape}"></td>
     <td nowrap>
 {if $mail.subject}
      {grn_link page='mail/view' caption=$mail.subject image='mail20.gif' truncated_caption=$characters.subject unread=1 mid=$mail.mid disabled=TRUE}
 {else}
      {grn_image image="mail20.gif"}<span class="textNoneMiddle-grn"></span>
 {/if}
     </td>
     <td nowrap>{if $mail.from}{grn_mail_name type=$name_type name=$mail.from email=$mail.email iid=$mail.iid aid=$category.aid cid=$category.cid}{else}<span class="textNoneMiddle-grn"></span>{/if}</td>
     <td nowrap>{grn_date_format date=$mail.ctime format='DateTimeMiddle_YMDW_HM'}</td>
     <td nowrap>{grn_format_filesize size=$mail.size unit="KB"}</td>
    </tr>
{/foreach}
   </table>
   <div class="navi">&nbsp;</div>
  <!----->
 <input type="hidden" name="cmd">
 <input type="hidden" name="aid" value="{$category.aid}">
 <input type="hidden" name="cid" value="{$category.cid}">
</form>
</div>
</div>
{include file="grn/footer.tpl"}
