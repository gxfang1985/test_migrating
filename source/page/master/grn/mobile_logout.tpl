<form id="form_logout" method="post" action="{grn_pageurl page='command_logout'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
</form>
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile_ul_grn">
    <div class="mobile_delete_confirm_grn">
        <span class="mobile_icon_attention_grn"></span>
        <span class="mobile_text_grn"><span>{cb_msg module='grn.mobile' key='logout_1' replace='true'}</span></span>
        <span class="mobile_text_grn"><span>{cb_msg module='grn.mobile' key='logout_2' replace='true'}</span></span>
    </div>
    <div data-theme="{$data_theme}" class="mobile_button_area_grn mobile_button_delete_grn">
        <div class="mobile_ok_grn">
            <input id="msgbox_btn_yes" type="button" value="{cb_msg module='grn.common' key='yes' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
        </div>
        <div class="mobile_cancel_grn">
            <input id="msgbox_btn_no" type="button" value="{cb_msg module='grn.common' key='no' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
        </div>
    </div>
</div>
