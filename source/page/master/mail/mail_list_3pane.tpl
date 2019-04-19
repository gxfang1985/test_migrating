<script language="JavaScript" type="text/javascript">
(function(){literal}
{{/literal}
    var __thisPage = grn.page.mail.mail_list;
    __thisPage.requireMailViewUrl = '{grn_pageurl page="mail/ajax/mail_view"}';
    grn.page.mail.mail_3pane.has_sibling_folders = '{$has_sibling_folders}';

    {literal}
    jQuery(document).ready(function () {
        //DRAG N' DROP
        var GRN_DDList2Tree_Mail = function(){
            GRN_DDList2Tree_Mail.superclass.constructor.apply(this, arguments);
        }
        YAHOO.extend(GRN_DDList2Tree_Mail, GRN_DDList2Tree);

        var options = { list_id:'mail_list',
                        item_name:'ids[]',
                        move_item:'li',//'tr','li'
                        drag_handle:'mail_list-row_',//'draghandle_','mail_list-row_'
                        high_light:'list_select_grn',//'row_highlight','list_select_grn'
                        unread_color:'unread_grn',//'unread_color','unread_grn'
                        delete_function : grn.page.mail.mail_3pane.deleteMulti,
                        csrf_ticket:'{/literal}{$csrf_ticket}',
                        async_url: '{grn_pageurl page="mail/ajax/command_index"}',
                        source:{ldelim}name:'cid',value:{$category.cid}{rdelim},
                        target_oid_key: 'dcid',
                        drag_msg: {ldelim}singular: '{cb_msg module="grn.mail" key="GRN_MAIL-408" replace="true"}', plural: '{cb_msg module="grn.mail" key="GRN_MAIL-409" replace="true"}'{rdelim},
                        moving_notice:'{cb_msg module="grn.mail" key="GRN_MAIL-410" replace="true"}'{literal},
                        trash_id : grn.page.mail.mail_3pane.trash_folder_id
                      };
        GRN_ListView_Util.InitDragDrop(GRN_DDList2Tree_Mail, options);
        GRN_MoveEmail_Util.init({moving_notice_content:'{/literal}{cb_msg module="grn.mail" key="GRN_MAIL-410" replace="true"}{literal}'});
        //END: DRAG N' DROP

        __thisPage.enableMultiSelect();
        __thisPage.enableShortcutKeySelect();

        if (grn.page.mail.mail_3pane.mid)
        {
            jQuery('#mail_list-row_' + grn.page.mail.mail_3pane.mid).addClass('list_select_grn');
        }
        __thisPage.changeNavigationStatus();
        grn.page.mail.mail_3pane.resetHeight();
        grn.page.mail.mail_3pane.resetTextWidth();

        // apply shift click
        applyShiftClick();
    });
})();
{/literal}
</script>
{if $use_star && $category.type neq '4'}
    {include file="star/star_init.tpl" list_id="mail_list" on_update="grn_mail_on_update_star"}
{/if}
{if $count > 0}
<div id="mail_list" class="title_list_area_grn" style='padding: 0px;'>
  <ul id="select_target" class="select_target_2line_grn">
    {include file="mail/mail_list_item_3pane.tpl" no_status=$no_status mails=$mails}
  </ul>
</div>
{else}
<script language="JavaScript" type="text/javascript">
(function(){literal}
{
    var __thisPage = grn.page.mail.mail_list;
    __thisPage.options = {prev : '-1',
                          next : '-1',
                          start : '0',
                          end   : '0'};
})();
{/literal}
</script>
<!--mail_message_area-->
<div class="list_message_grn">
  <div class="list_message_balloon_grn"><span class="bold_grn">{cb_msg module='grn.mail' key='GRN_MAIL-450' replace='true'}</span></div>
  <div class="balloon_arrow_down_grn"></div>
  <div class="mail_message_icon_grn"><span class="mail_message_middle_icon_grn"></span></div>
</div>
<!--mail_message_area_end-->
{/if}

{*** after switch category, reset these data ***}
<span id="reset_sort_span" style="display:none">{include file='mail/_sort_3pane.tpl'}</span>
<span id="delete_multi_span" style="display:none">{include file='mail/_delete_multi_3pane.tpl'}</span>
<span id="delete_multi_files_span" style="display:none">{include file='mail/_delete_multi_files_3pane.tpl'}</span>
<span id="delete_all_span" style="display:none">{include file='mail/_delete_all_3pane.tpl'}</span>
