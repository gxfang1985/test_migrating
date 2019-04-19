{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div id="attendane_confirm_html" style="display:none;">
  <div class="mobile_titlebar_grn">
    <div class="mobile_breadcrumbtitle_left_grn"><span class="mobile_icon_breadcrumb_grn mobile_app_{$application_id}_s_b_grn"></span>{cb_msg module='grn.schedule' key='GRN_SCH-1002' replace='true'}</div>
  </div>
  <div data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile_ul_grn">
    <div class="mobile_schedule_grn mobile_overlay_wrap_grn mobile_schedule_overlay_grn">
      <div class="mobile-div-title-grn mobile_update_title_text_grn">
          <span><span class="mobile-label-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1000' replace='true'}</span><span id="attendance_check_confirm_title" class="mobile_attendance_check_confirm_title"></span></span>
      </div>
      <div class="mobile-div-title-grn">
      {strip}
        <label for="need_refresh">
          <a id="attendance_check" href="javascript:void(0);" class="mobile-checkboxOff-todo-grn"></a>
          <span class="mobile_checkbox_grn">
            <input name="need_refresh" id="need_refresh" type="checkbox" data-role="none" class="mobile-input-grn"/>
          </span>
        </label>
        <span class="mobile_btn_checkboxtext_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1001' replace='true'}</span>
      {/strip}
      </div>
    </div>
    <div class="mobile_changeBtnMargin_grn"></div>
    <div data-theme="{$data_theme}" class="mobile_button_area_grn">
      <div class="mobile_ok_grn">
        <input id="confirm_dialog_btn_yes" type="button" value="{cb_msg module='grn.schedule.mobile' key='GRN_SCH_MOBILE-36' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
      </div>
      <div class="mobile_cancel_grn">
        <input id="confirm_dialog_btn_no" type="button" value="{cb_msg module='grn.common' key='cancel' replace='true'}" data-inline="true" data-theme="{$data_theme}"/>
      </div>
    </div>
  </div>
</div>