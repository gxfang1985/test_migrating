{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{if $no_setting eq '0'}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="fw/jquery/jquery-3.2.1.min.js"}
{grn_load_javascript file="grn/html/page/mail/mail_3pane.js"}
{grn_load_javascript file="grn/html/page/mail/mail_list.js"}
{grn_load_javascript file="grn/html/page/mail/splitter.js"}
{grn_load_javascript file="grn/html/component/mail/MailPartsUpdater.js"}
{grn_load_javascript file="grn/html/star.js"}
{grn_load_javascript file="grn/html/component/mail/confirm_show_html.js"}
<script language="JavaScript" type="text/javascript">
    jQuery.noConflict();
    var G = grn.page.mail.mail_3pane;
    G.left_db = '{$pane_info.left}';
    G.center_db = '{$pane_info.middle}';

    G.send_popup = '{grn_pageurl page="mail/send_popup"}';
    G.reply_popup = '{grn_pageurl page="mail/reply_popup"}';
    G.reply_all_popup = '{grn_pageurl page="mail/reply_all_popup"}';
    G.forward_popup = '{grn_pageurl page="mail/forward_popup"}';
    G.resend_popup = '{grn_pageurl page="mail/resend_popup"}';
    G.draft_modify_popup = '{grn_pageurl page="mail/draft_modify_popup"}';

    G.command_index_url = '{grn_pageurl page="mail/ajax/command_index"}';
    G.csrf_ticket = '{$csrf_ticket}';
    G.yes_message = '{cb_msg module="grn.common" key="yes" replace="true"}';
    G.no_message = '{cb_msg module="grn.common" key="no" replace="true"}';

    G.open_message = '{cb_msg module="grn.mail" key="GRN_MAIL-460" replace="true"}';
    G.close_message = '{cb_msg module="grn.mail" key="GRN_MAIL-461" replace="true"}';

    G.aid = '{$category.aid}';
    G.cid = '{$category.cid}';
    G.mid = '{$mail_id}';
    G.draft_folder_id = '{$draft_folder_id}';
    G.trash_folder_id = '{$trash_folder_id}';
    G.sent_folder_id = '{$sent_folder_id}';
    G.use_fts = '{$use_fts}';

    G.is_draft = {if $category.type eq '3'}true{else}false{/if};
    G.is_account_disabled = {if $account_deleted || $disable_mail || $cannot_send || $size_over}true{else}false{/if};

    G.enable_menu_list = {ldelim}menu_item_compose_mail : '<a href="javascript:void(0);" class="menu_item_grn" onclick="G.popupSendMail(G.send_popup);"><span class="icon_add_grn">{cb_msg module="grn.mail" key="GRN_MAIL-433" replace="true"}</span></a>',
                                 menu_item_reply : '<a href="javascript:void(0);" class="menu_item_grn" onclick="G.popupSendMail(G.reply_popup);"><span class="icon_reply_grn">{cb_msg module="grn.mail" key="GRN_MAIL-434" replace="true"}</span></a>',
                                 menu_item_reply_all : '<a href="javascript:void(0);" class="menu_item_grn" onclick="G.popupSendMail(G.reply_all_popup);"><span class="icon_reply_all_grn">{cb_msg module="grn.mail" key="GRN_MAIL-435" replace="true"}</span></a>',
                                 menu_item_forward : '<a href="javascript:void(0);" class="menu_item_grn" onclick="G.popupSendMail(G.forward_popup);"><span class="icon_forward_grn">{cb_msg module="grn.mail" key="GRN_MAIL-436" replace="true"}</span></a>',
                                 menu_item_resend : '<a href="javascript:void(0);" class="menu_item_grn" onclick="G.popupSendMail(G.resend_popup);"><span class="icon_reuse_grn">{cb_msg module="grn.mail" key="GRN_MAIL-462" replace="true"}</span></a>',
                                 menu_item_draft_modify : '<a href="javascript:void(0);" class="menu_item_grn" onclick="G.popupSendMail(G.draft_modify_popup);"><span class="icon_edit_grn">{cb_msg module="grn.mail" key="GRN_MAIL-452" replace="true"}</span></a>',
                                 menu_item_delete_multi : '<a href="javascript:void(0);" class="menu_item_grn" onclick="G.deleteMulti();"><span class="icon_delete_grn">{cb_msg module="grn.mail" key="GRN_MAIL-437" replace="true"}</span></a>',
                                 menu_item_change_status : '<a href="javascript:void(0);" class="menu_item_grn" id="menu_dropdown_status_change"><span class="icon_label_grn">{cb_msg module="grn.mail" key="GRN_MAIL-440" replace="true"}</span><span class="arrow_down_small_icon_grn"></span></a>',
                                 menu_item_folder_move : '<a href="javascript:void(0);" class="menu_item_grn" id="menu_dropdown_folder_move"><span class="icon_move_grn">{cb_msg module="grn.mail" key="GRN_MAIL-439" replace="true"}</span><span class="arrow_down_small_icon_grn"></span></a>'{rdelim};

    G.disable_menu_list = {ldelim}menu_item_compose_mail : '<span class="menu_item_disable_grn"><span class="icon_add_grn">{cb_msg module="grn.mail" key="GRN_MAIL-433" replace="true"}</span></span>',
                                  menu_item_reply : '<span class="menu_item_disable_grn"><span class="icon_reply_grn">{cb_msg module="grn.mail" key="GRN_MAIL-434" replace="true"}</span></span>',
                                  menu_item_reply_all : '<span class="menu_item_disable_grn"><span class="icon_reply_all_grn">{cb_msg module="grn.mail" key="GRN_MAIL-435" replace="true"}</span></span>',
                                  menu_item_forward : '<span class="menu_item_disable_grn"><span class="icon_forward_grn">{cb_msg module="grn.mail" key="GRN_MAIL-436" replace="true"}</span></span>',
                                  menu_item_resend : '<span class="menu_item_disable_grn"><span class="icon_reuse_grn">{cb_msg module="grn.mail" key="GRN_MAIL-462" replace="true"}</span></span>',
                                  menu_item_draft_modify : '<span class="menu_item_disable_grn"><span class="icon_edit_grn">{cb_msg module="grn.mail" key="GRN_MAIL-452" replace="true"}</span></span>',
                                  menu_item_delete_multi : '<span class="menu_item_disable_grn"><span class="icon_delete_grn">{cb_msg module="grn.mail" key="GRN_MAIL-437" replace="true"}</span></span>',
                                  menu_item_change_status : '<span class="menu_item_disable_grn"><span class="icon_label_grn">{cb_msg module="grn.mail" key="GRN_MAIL-440" replace="true"}</span><span class="arrow_down_small_icon_grn"></span></span>',
                                  menu_item_folder_move : '<span class="menu_item_disable_grn"><span class="icon_move_grn">{cb_msg module="grn.mail" key="GRN_MAIL-439" replace="true"}</span><span class="arrow_down_small_icon_grn"></span></span>'{rdelim};

    var __thisPage = grn.page.mail.mail_list;
    __thisPage.filter = '';
    __thisPage.spinnerImage = '{$app_path}/grn/image/cybozu/image-mobile/spinner.gif?{$build_date}';
    __thisPage.multiCheckedMessage = '{cb_msg module="grn.mail" key="GRN_MAIL-459" replace="true"}';
    __thisPage.noCheckedMessage = '{cb_msg module="grn.mail" key="GRN_MAIL-451" replace="true"}';
    __thisPage.loadingMessage = '{cb_msg module="grn.mail" key="GRN_MAIL-463" replace="true"}';
    __thisPage.requireUrl = '{grn_pageurl page="mail/ajax/mail_list"}';
    __thisPage.requireSplitterPositionUrl = '{grn_pageurl page="mail/ajax/command_splitter_save"}';
    __thisPage.options = {ldelim}aid : '{$category.aid}',
                                 cid : '{$category.cid}'{rdelim};
    __thisPage.mailView = 'mail/view';

    __thisPage.menu_list = {ldelim} 2 : '<span class="menu_item_disable_grn"><span class="icon_reply_grn"><span>{cb_msg module="grn.mail" key="GRN_MAIL-434" replace="true"}</span></span></span>',
                                    3 : '<span class="menu_item_disable_grn"><span class="icon_reply_all_grn"><span>{cb_msg module="grn.mail" key="GRN_MAIL-435" replace="true"}</span></span></span>',
                                    4 : '<span class="menu_item_disable_grn"><span class="icon_forward_grn"><span>{cb_msg module="grn.mail" key="GRN_MAIL-436" replace="true"}</span></span></span>',
                                   11 : '<span class="menu_item_disable_grn"><span class="icon_edit_grn"><span>{cb_msg module="grn.mail" key="GRN_MAIL-452" replace="true"}</span></span></span>' {rdelim};
{literal}
jQuery(document).ready(function () {
    {/literal}{if !$is_open_status}location.replace('#cid={$category.cid}');{/if}{literal}
    {/literal}{if $is_open_status}grn.page.mail.mail_list.toggleMenu(1);{/if}{literal}

    G.iFrame = document.getElementById("history_iframe");
    G.search_box = jQuery('#smart_rare_menu_part');
{/literal}
    {if ($category.cid == $draft_folder_id || $category.cid == $trash_folder_id)}
        jQuery('#smart_rare_menu_part').remove();
    {/if}
{literal}

    GRN_Mail_Hash_Util.historyCallback();
    jQuery("#footer").css("display", "none");
});
{/literal}
</script>
{include file="grn/error_handler.tpl"}
{/if}
{include file='mail/_title_3pane.tpl'}
<div class="mainarea_full_grn">
  <div class="mainarea-mail">
  {if $no_setting neq '0'}
    <div class="no_set_info_grn">
      {grn_title title=$app_name class=$page_info.parts[0]}
      {include file='mail/_no_setting.tpl'}
    </div>
  {else}
    <!--menubar-->
    <div id="menu_part">
      {include file='mail/notes_3pane.tpl'}
      <table class="table_plain_grn w_full_grn">
        <tr>
          <td>
            {strip}
            <div id="smart_main_menu_part" class="menu_style1_grn">
              {if $account_deleted || $disable_mail || $cannot_send || $size_over}
                <span class="menu_item" id="menu_item_compose_mail"><span class="menu_item_disable_grn"><span class="icon_add_grn">{cb_msg module='grn.mail' key='GRN_MAIL-433' replace='true'}</span></span></span>
              {else}
                <span class="menu_item" id="menu_item_compose_mail"><a href="javascript:void(0);" class="menu_item_grn" onclick="G.popupSendMail(G.send_popup);"><span class="icon_add_grn">{cb_msg module="grn.mail" key="GRN_MAIL-433" replace="true"}</span></a></span>
              {/if}
              <span class="menu_item" id="menu_item_reply" {if $category.type eq '3' || $category.type eq '2'}style="display: none;"{/if}><span class="menu_item_disable_grn"><span class="icon_reply_grn">{cb_msg module='grn.mail' key='GRN_MAIL-434' replace='true'}</span></span></span>
              <span class="menu_item" id="menu_item_reply_all" {if $category.type eq '3' || $category.type eq '2'}style="display: none;"{/if}><span class="menu_item_disable_grn"><span class="icon_reply_all_grn">{cb_msg module='grn.mail' key='GRN_MAIL-435' replace='true'}</span></span></span>
              <span class="menu_item" id="menu_item_forward" {if $category.type eq '3' || $category.type eq '2'}style="display: none;"{/if}><span class="menu_item_disable_grn"><span class="icon_forward_grn">{cb_msg module='grn.mail' key='GRN_MAIL-436' replace='true'}</span></span></span>
              <span class="menu_item" id="menu_item_resend" {if $category.type eq '3' || $category.type eq '1'}style="display: none;"{/if}><span class="menu_item_disable_grn"><span class="icon_reuse_grn">{cb_msg module='grn.mail' key='GRN_MAIL-462' replace='true'}</span></span></span>
              <span class="menu_item" id="menu_item_draft_modify" {if $category.type eq '2' || $category.type eq '1'}style="display: none;"{/if}><span class="menu_item_disable_grn"><span class="icon_edit_grn">{cb_msg module='grn.mail' key='GRN_MAIL-452' replace='true'}</span></span></span>
              <span class="menu_item" id="menu_item_delete_multi"><span class="menu_item_disable_grn"><span class="icon_delete_grn">{cb_msg module="grn.mail" key="GRN_MAIL-437" replace='true'}</span></span></span>
              <span class="menu_item menu_item_dropdown_grn" id="menu_item_folder_move">{include file='mail/_change_folder_3pane.tpl' show_another_account=$show_another_account folder_list=$folder_list}</span>
              {include file='mail/_change_status_3pane.tpl' status_infos=$change_status_infos}
              {include file='mail/_menu_option_3pane.tpl'}
            </div>
            {/strip}
          </td>

          <td class="tAlignRight-grn">
            <div id="smart_rare_menu_part">
                {include file='mail/_search_box.tpl'}
            </div>
          </td>
        </tr>
      </table>

      <div class="clear_both_0px"></div>
    </div>
    <!--menubar_end-->

    <!--maincontents_list-->
    <table class="maincontents_list">
      <tbody>
        <tr>
          <td class="maincontents_list_td">
            <table class="listtable_scroll_base_grn">
              <tbody>
                <tr valign="top">
                  <td id="tree_part">
                    <iframe id="history_iframe" src="" style="display:none;"></iframe>
                    {include file="mail/_receive_button.tpl"}
                    {include file='mail/folder_tree_3pane.tpl'}
                    <div id="splitter1" class="trigger_area_grn"></div>
                  </td>

                  <td id="list_center" class="list_part_grn" {if $is_open_status}style="display: none;"{/if}>
                    <div class="bg_shadow_grn">
                      {strip}
                      <table id="list_container" class="list_container_grn">
                        <tr>
                          <td class="list_item_button_left_grn notext_button_grn">
                            {include file="mail/checkall_3pane.tpl" elem_name="ids[]" form_name=$form_name enable_shift_click=true}
                          </td>
                          <td class>
                              <span id="command_index_spinner" style="visibility:hidden">
                                  {grn_image image="spinner.gif"}
                              </span>
                          </td>
                          <td class="list_item_text_grn nowrap-grn" id="sort_filter_td">
                            {include file='mail/_sort_3pane.tpl'}
                              <span class="list_action_separator_grn"></span>
                              {include file='mail/_selection_list_3pane.tpl' stid='menu_dropdown_filter_status' options=$status_infos}
                          </td>
                        </tr>
                      </table>
                      {/strip}
                      <!--list_area-->
                      <div id="moving_box" style="display:none;">
                        <span class="attentionMessage-grn nowrap-grn" id="moving_notice"></span>
                        <a href="javascript:void(0);" onclick="GRN_ListView_Util.UndoDrapDrop('mail_list');" class="nowrap-grn">{cb_msg module='grn.mail' key='GRN_MAIL-411' replace='true'}</a>
                      </div>
                      <form name="{$form_name}">
                        <div id="list_area_scroll" class="list_area_scroll_grn" tabindex="0">
                          {if $is_open_status}
                            {$mail_list_component->fetch()}
                          {/if}
                        </div>
                      </form>
                      <!--list_area_end-->
                      {strip}
                      <div class="list_paging_grn">
                        <span id="top_page_on" class="mRight3" style="display:none;">
                          <a href="javascript:void(0);" title="{cb_msg module='grn.grn' key='GRN_GRN-1282' replace='true'}" class="action_grn" onclick="javascript:__thisPage.pageNavigation()">
                            <span class="arrow_first_button_grn"></span>
                          </a>
                        </span>
                        <span id="top_page_off" class="action_disable_grn mRight3"><span class="arrow_first_button_grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1282' replace='true'}"></span></span>
                        <span id="prev_page_on" class="mRight3" style="display:none;">
                          <a href="javascript:void(0);" title="{cb_msg module='grn.mail' key='GRN_MAIL-445' replace='true'} {$navi_num} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}" class="action_grn" onclick="javascript:__thisPage.pageNavigation('prev')">
                            <span class="arrow_left_button_grn"></span>
                          </a>
                        </span>
                        <span id="prev_page_off" class="action_disable_grn mRight3"><span class="arrow_left_button_grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-445' replace='true'} {$navi_num} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}"></span></span>
                        <span id="next_page_on" class="mRight3" style="display:none;">
                            <a href="javascript:void(0);" title="{cb_msg module='grn.mail' key='GRN_MAIL-446' replace='true'} {$navi_num} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}" class="action_grn" onclick="javascript:__thisPage.pageNavigation('next')">
                              <span class="arrow_right_button_grn"></span>
                            </a>
                        </span>
                        <span id="next_page_off" class="action_disable_grn mRight3"><span class="arrow_right_button_grn" title="{cb_msg module='grn.mail' key='GRN_MAIL-446' replace='true'} {$navi_num} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}"></span></span>
                        <span class="sub_title numberList vAlignMiddle-grn mLeft5">
                          <span id="start_num">0</span>-<span id="end_num">0</span>
                        </span>
                      </div>
                      {/strip}
                    </div>
                    <div id="splitter2" class="trigger_area_grn"></div>
                  </td>

                  <td id="view_part" class="bg_shadow_grn">
                  <table style="width: 100%; height: 100%;" class="table_plain_grn">
                    <tbody>
                      <tr>
                        <td class="vAlignTop-grn" style="padding: 0px;">
                          <div id="mail_view">
                          {if $is_open_status}
                          {$mail_view_component->fetch()}
                          {else}
                          <div class="content_message_grn"><span><span class="mail_message_middle_icon_grn mRight7"></span></span><span>{cb_msg module='grn.mail' key='GRN_MAIL-451' replace='true'}</span></div>
                          {/if}
                          </div>
                        </td>
                      </tr>
                      <tr id="mail_credit" style="display:none;">
                        <td class="vAlignBottom-grn pBottom7">
                          <div class="credit"><!-- " --><small>{$product_term}</small><!-- " --><small style="margin: 0px 5px;">&nbsp;{$copyright}</small></div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
      </tbody>
    </table>
    <!--end of maincontents_list-->
{*** DRAG N' DROP ***}
    {include file='mail/dragdrop_list2tree_3pane.tpl'}
{*** END: DRAG N' DROP ***}
  {/if}
  </div>

{include file="grn/footer.tpl"}