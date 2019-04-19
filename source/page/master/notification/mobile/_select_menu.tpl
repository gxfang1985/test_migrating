<a id="selectMenuNotifyUI" href="#selectMenuNotify" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
    <span class="mobile_event_menu_content_grn">----------</span>
    <span class="mobile_select_icon_grn"></span>
</a>
<input type="hidden" value="" id="selectMenuNotifyValue" class="js_selected_application">
{capture name='grn_notification_GRN_NTFC_24'}{cb_msg module='grn.notification' key='GRN_NTFC-24' replace='true'}{/capture}
{include file="grn/mobile_select_menu.tpl"
selectMenuTitle=$smarty.capture.grn_notification_GRN_NTFC_24
select_items=$apps_list
selectMenuUI='selectMenuNotifyUI'
selectMenuValue='selectMenuNotifyValue'
popupMenu='selectMenuNotify'
name_title='label'
selected_value=$selected_app_info.value
}