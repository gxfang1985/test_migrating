{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_load_javascript file="grn/html/folder_select.js"}

<div class="mainarea-mail">
    <!--menubar-->
    <div id="menu_part">
        <span class="float_left nowrap-grn">
            {if ! $account_deleted and ! $disable_mail}
                <span class="menu_item">{capture name='grn_mail_GRN_MAIL_367'}{cb_msg module='grn.mail' key='GRN_MAIL-367' replace='true'}{/capture}{grn_link page='mail/draft_modify' caption=$smarty.capture.grn_mail_GRN_MAIL_367 image='modify20.gif' mid=$mail.mid disabled=$size_over alt=''}</span>
            {/if}
            {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
            <span class="menu_item">{capture name='grn_mail_GRN_MAIL_368'}{cb_msg module='grn.mail' key='GRN_MAIL-368' replace='true'}{/capture}{grn_link page='mail/draft_delete' caption=$smarty.capture.grn_mail_GRN_MAIL_368 image='delete20.gif' script='javascript:void(0);' id="lnk_delete" alt=''}</span>

            <form name="top_move" method="post" action="{grn_pageurl page='mail/command_view'}" class="inline_block_grn">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                {capture name='grn_message_GRN_MAIL_406'}{cb_msg module='grn.mail' key='GRN_MAIL-406' replace='true'}{/capture}
                {include file='mail/_change_folder.tpl' no_account=1 selected_folder_id=$folder.cid hide_root_folder=1 hide_garbage_folder=1 show_another_account=1 c_name='dcid' c_id='dcid' exception_value="-1" exception_item=$smarty.capture.grn_message_GRN_MAIL_406 default_selected='true' detail_mail="true"}
                <input type='hidden' name='cmd' value="move">
                <input type='hidden' name='aid' value="{$mail.aid}">
                <input type='hidden' name='cid' value="{$mail.cid}">
                <input type='hidden' name='mid' value="{$mail.mid}">
            </form>
        </span>
        <span class="float_right nowrap-grn mBottom2">
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
    {if $use_star}
        {include file="star/star_init.tpl" list_id="mail_list"}
        <div id="mail_list">
            {grn_star_icon module='grn.mail' star_infos=$star_infos unique_id=$mail.mid mid=$mail.mid no_style=1}
    {/if}
    {if $mail.subject eq ''}
        {grn_title caption_module='grn.mail' caption_key='no_title' class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {else}
        {grn_title title=$mail.subject class=$page_info.parts[0]|cat:' inline_block_grn' no_style=1}
    {/if}
    {if $use_star}
        </div>{*end mail_list*}
    {/if}
<!--menubar_end-->
<div class="clear_both_1px">&nbsp;</div>

 <table class="mail_preview">
  <colgroup>
   <col width="10%">
   <col width="80%">
  </colgroup>
  <tr valign="top">
   <th nowrap class="bg_color">To:</th>
   <td>{$mail.to|escape}</td>
  </tr>
  <tr valign="top">
   <th nowrap class="bg_color">Cc:</th>
   <td>{$mail.cc|escape}</td>
  </tr>
  <tr valign="top">
   <th nowrap class="bg_color">Bcc:</th>
   <td>{$mail.bcc|escape}</td>
  </tr>
{if $mail.attach_files}
  <tr valign="top">
   <th nowrap class="bg_color">{cb_msg module='grn.mail' key='GRN_MAIL-372' replace='true'}</th>
   <td>
 {foreach from=$mail.attach_files item=attach_file key=file_key}
      {grn_mail_attach_file_link name=$attach_file.name dpage="mail/file_download" mid=$mail.mid fid=$file_key sent=$mail.sent mime=$attach_file.mime inline=$inline sent=$mail.sent hash=$attach_file.hash}<br>
 {/foreach}
   </td>
  </tr>
{/if}
  <tr valign="top">
   <th nowrap class="bg_color">{cb_msg module='grn.mail' key='GRN_MAIL-370' replace='true'}</th>
   <td>
{if $mail.html_data}
{capture name='grn_mail_GRN_MAIL_371'}{cb_msg module='grn.mail' key='GRN_MAIL-371' replace='true'}{/capture}{grn_link image='view20.gif' caption=$smarty.capture.grn_mail_GRN_MAIL_371 page='mail/html_contents' mid=$mail.mid fid=$attach_file.fid text=1}
    <iframe id="mail_content" frameborder="0" scrolling="no" style="overflow:hidden;height:20px;width:100%;border: 0 none;display:none"></iframe>
    <div id="sanbox" style="display:none">{$mail.data|grn_noescape}</div>
{else}
    {grn_format body=$mail.data}
{/if}
   </td>
  </tr>
{if $send_set}
 {if $mail.give_open_check}
  <tr valign="top">
   <th nowrap class="bg_color">{cb_msg module='grn.mail' key='GRN_MAIL-373' replace='true'}</th>
   <td>{grn_image image='check16.gif'}{cb_msg module='grn.mail' key='GRN_MAIL-374' replace='true'}</td>
  </tr>
 {/if}
{/if}
 </table>

<div class="clear_both_1px">&nbsp;</div>
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
{if $mail.html_data}
<script type="text/javascript">
{literal}
jQuery(function() {
    var f = jQuery("#mail_content");
    var sanbox = jQuery("#sanbox");
    var fdocument = setIFrameContent(f.get(0), sanbox.html(), "{/literal}{grn_get_url_prefix}{literal}");
    f.show();
    var frame_height_buffer = 0;
    if (grn.browser.msie) {
        f.css( "width", f.get(0).parentNode.clientWidth + "px");
        frame_height_buffer = 15;
    }
    f.css( "height", (fdocument.body.scrollHeight + frame_height_buffer) + "px" );
    sanbox.html("");
});
{/literal}
</script>
{/if}
{include file="grn/footer.tpl"}
