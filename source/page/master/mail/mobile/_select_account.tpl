<a id="mail_select_account" href="#popup_menu_mail_account" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
  <span class="mobile_event_menu_content_grn">{$account_list.$account_id.title|escape}</span>
  <span class="mobile_select_icon_grn"></span>
</a>
<input type="hidden" value="" name="selected_account_value" id="selected_account_value" onchange="javascript:grn.page.mail.mobile.index.redirectToIndex();">
{capture name='grn_mail_mobile_GRN_MAIL_MOBILE_5'}{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-5' replace='true'}{/capture}
{include file="grn/mobile_select_menu.tpl"
selectMenuTitle=$smarty.capture.grn_mail_mobile_GRN_MAIL_MOBILE_5
select_items=$account_list
selectMenuUI='mail_select_account'
selectMenuValue='selected_account_value'
popupMenu='popup_menu_mail_account'
name_value='aid'
name_title='title'
selected_value=$account_id
}
