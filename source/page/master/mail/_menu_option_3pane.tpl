{strip}
<span class="menu_item menu_item_dropdown_grn">
  <a href="javascript:void(0);" class="menu_item_grn" id="menu_dropdown_options" title="{cb_msg module='grn.mail' key='GRN_MAIL-441' replace='true'}"><span class="icon_menu_grn"></span><span class="arrow_down_small_icon_grn"></span></a>
  <div class="mail-dropdownContents">
    <ul id="menu_option_dropdown_list">
      <li id="menu_option_print" style="display: none"><a href="javascript:void(0);" onclick="window.location='{grn_pageurl page=mail/print}mid='+G.mid"><span class="icon_print_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-14' replace='true'}</span></a></li>
      <li id="menu_option_filter" style="display: none"><a href="javascript:void(0);" onclick="window.location='{grn_pageurl page=mail/personal/filter_add}mid='+G.mid"><span class="icon_distribute_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-10' replace='true'}</span></a></li>
      <li id="menu_option_source" style="display: none"><a href="javascript:void(0);" onclick="window.location='{grn_pageurl page=mail/source postfix=source}mid='+G.mid+'&sid='+G.mail_source_id+'&.txt'"><span class="icon_document_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-11' replace='true'}</span></a></li>
      <li id="menu_option_source_disabled" class="disable_style_grn" style="display: none;"><span class="icon_document_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-11' replace='true'}</span></li>
      <li id="menu_option_export" style="display: none"><a href="javascript:void(0);" onclick="window.location='{grn_pageurl page=mail/export postfix=notitle}mid='+G.mid+'&.txt'"><span class="icon_document_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-13' replace='true'}</span></a></li>
      <li id="menu_option_charset" style="display: none"><a href="javascript:void(0);" onclick="display_on_off('display_mail_charset_header:display_mail_charset_body');"><span class="icon_document_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-40' replace='true'}</span></a></li>
      <li id="menu_option_charset_disabled" class="disable_style_grn" style="display: none;"><span class="icon_document_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-40' replace='true'}</span></li>
      <li id="menu_option_text_contents" style="display: none"><a href="javascript:void(0);" onclick="window.location='{grn_pageurl page=mail/text_contents}mid='+G.mid"><span class="icon_document_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-76' replace='true'}</span></a></li>
      {if $link_transfer_mail_to_message}
        <li id="menu_option_transfer_mail_to_message" style="display: none"><a href="javascript:void(0);" onclick="window.location='{grn_pageurl page=message/transfer_mail_to_message}mail_id='+G.mid"><span class="icon_message_b_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRMSG_MAIL_6' app_name=$message_name}</span></a></li>
      {/if}

      {if $mail_automation_available || ! $pane_info.only_one_layout}
        <li id="menu_option_border_partition" style="display: none"><div class="border_partition_pulldown_grn"></div></li>
      {/if}
      {if $mail_automation_available}
      {strip}
          <li>
              <a href="{grn_pageurl page="mail/personal/automation" accountId=$category.aid}">
                  <span class="icon_forward_grn"></span>
                <span class="vAlignMiddle-grn">
                    {cb_msg module='grn.mail' key='GRN_MAIL-469' replace='true'}
                </span>
              </a>

          </li>
      {/strip}
      {/if}
      {if ! $pane_info.only_one_layout}
        <li>
          <form name="change_pane" id="change_pane" method="post" action="{grn_pageurl page='mail/command_change_pane'}">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="pane" value="2">
            <input type="hidden" name="aid" value="{$category.aid}">
          </form>
          <a href="javascript:void(0);" onclick="javascript:jQuery('#change_pane').submit()"><span class="icon_2pane_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-430' replace='true'}</span></a>
        </li>
      {/if}

      <li id="delete_file_extra_border"><div class="border_partition_pulldown_grn"></div></li>
      <li id="menu_option_delete_file" style="display: none;"><a href="javascript:void(0);"><span class="icon_delete_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-80' replace='true'}</span></a></li>
      <li id="delete_multi_files" style="display: none"><a href="javascript:void(0);" onclick="javascript:G.deleteMultiFiles();"><span class="icon_delete_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-475' replace='true'}</span></a></li>
      <li id="delete_multi_files_disabled" class="disable_style_grn"><span class="icon_delete_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-475' replace='true'}</span></li>
      <li><div class="border_partition_pulldown_grn"></div></li>
      <li><a href="javascript:void(0);" onclick="javascript:G.deleteAll();"><span class="icon_delete_grn"></span><span class="vAlignMiddle-grn">{cb_msg module='grn.mail' key='GRN_MAIL-148' replace='true'}</span></a></li>
    </ul>
  </div>
</span>
{/strip}
