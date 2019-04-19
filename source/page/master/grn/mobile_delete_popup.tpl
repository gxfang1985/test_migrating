{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div class="mobile_titlebar_grn">
  <div class="mobile_breadcrumbtitle_left_grn"><span class="mobile_icon_breadcrumb_grn mobile_app_{$application_id}_s_b_grn"></span>{$header_title|escape}</div>
</div>
<div data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile_ul_grn">
  {include file='grn/_mobile_delete_confirm.tpl'}
  <div data-theme="{$data_theme}" class="mobile_button_area_grn mobile_button_delete_grn">
    <div class="mobile_ok_grn">
      <input id="msgbox_btn_yes" type="button" value="{cb_msg module='grn.common' key='yes' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
    </div>
    <div class="mobile_cancel_grn">
      <input id="msgbox_btn_no" type="button" value="{cb_msg module='grn.common' key='no' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
    </div>
  </div>
</div>