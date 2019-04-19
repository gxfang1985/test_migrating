{strip}
<div class="list_menu {$menu_css}" style="display: none;">
    {include file='grn/checkall.tpl' elem_name='notification[]' notification_flag=true enable_shift_click=true}
    <span class="aButtonStandard-grn button_disable_filter_grn js_button_mark_as_read">
        <a href="javascript:void(0);" role="button" aria-disabled="true"><span>{cb_msg module='grn.notification' key='GRN_NTFC-71' replace='true'}</span></a>
    </span>
</div>{/strip}
