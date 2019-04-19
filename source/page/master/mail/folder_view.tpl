{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
<div class="mainarea-mail">
    <!--menubar-->
    <div id="main_menu_part">
        <span class="float_left nowrap-grn">
            <span class="menu_item">{capture name='grn_mail_GRN_MAIL_218'}{cb_msg module='grn.mail' key='GRN_MAIL-218' replace='true'}{/capture}{grn_link page='mail/folder_modify' caption=$smarty.capture.grn_mail_GRN_MAIL_218 image='write20.gif' aid=$category.aid cid=$category.cid alt=''}</span>
            {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
            {if $category.type eq '5'}
                <span class="menu_item">{capture name='grn_mail_GRN_MAIL_219'}{cb_msg module='grn.mail' key='GRN_MAIL-219' replace='true'}{/capture}{grn_link page='mail/folder_delete' caption=$smarty.capture.grn_mail_GRN_MAIL_219 image='delete20.gif' script='javascript:void(0);' id="lnk_delete" alt=''}</span>
            {else}
                <span class="menu_item">{capture name='grn_mail_GRN_MAIL_220'}{cb_msg module='grn.mail' key='GRN_MAIL-220' replace='true'}{/capture}{grn_link page='mail/folder_delete' caption=$smarty.capture.grn_mail_GRN_MAIL_220 image='delete20.gif' script='javascript:void(0);' id="lnk_delete" disabled='1' alt=''}</span>
            {/if}
        </span>
        <span class="float_right nowrap-grn mBottom2">
            {if ! $account_deleted}
                <div class="moveButtonBlock-grn">
                    <span class="button_base_grn">
                        <form id="subscribe" name="subscribe" method="post" style="display: inline;" action="{grn_pageurl page='mail/command_folder_view'}">
                            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                            <input type="hidden" name="aid" value="{$category.aid|escape}">
                            <input type="hidden" name="cid" value="{$category.cid|escape}">
                            {if $category.subscribed == '1'}
                                <input type="hidden" name="subs" value="0">
                                <input type="hidden" name="cmd" value="unsubscribe">
                                <span class="aButtonStandard-grn"><a onclick="jQuery('#wait_image').show();jQuery('#subscribe').submit();" href="javascript:void(0);" role="button"><span>{cb_msg module='grn.mail' key='GRN_MAIL-216' replace='true'}</span></a></span>
                            {else}
                                <input type="hidden" name="subs" value="1">
                                <input type="hidden" name="cmd" value="subscribe">
                                <span class="aButtonStandard-grn"><a onclick="jQuery('#wait_image').show();jQuery('#subscribe').submit();" href="javascript:void(0);" role="button"><span>{cb_msg module='grn.mail' key='GRN_MAIL-217' replace='true'}</span></a></span>
                            {/if}
                            <span id="wait_image" class="spinner_s_button_post_grn" style="display: none;"></span>
                        </form>
                    </span>
                </div>
            {/if}
        </span>
        <div class="clear_both_0px"></div>
    </div>
    <!--menubar_end-->
    {grn_title title=$category.title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-221' replace='true'}</th>
   <td>{$account.title|escape}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-222' replace='true'}</th>
   <td>{grn_mail_show_folder_position folder_id=$category.cid}</td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-223' replace='true'}</th>
   <td>{grn_format body=$category.memo}</td>
  </tr>
{if ! $account_deleted}
  <tr>
   <th>{cb_msg module='grn.mail' key='GRN_MAIL-224' replace='true'}</th>
   <td>{if $category.subscribed}<font color="green">{cb_msg module='grn.mail' key='GRN_MAIL-225' replace='true'}</font>{else}{cb_msg module='grn.mail' key='GRN_MAIL-226' replace='true'}{/if}</td>
  </tr>
{/if}
 </table>
</div>
{include file="grn/footer.tpl"}
