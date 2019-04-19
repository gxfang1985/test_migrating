<div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn">
  {include file="grn/mobile_breadcrumb.tpl"}
  {strip}
    <div class="mobile_breadcrumb_margin_grn"></div>
    {if $no_setting neq '0'}
      {include file='mail/_no_setting.tpl' for_send=1}
    {else}
      <div id="show_validation_errors"></div>

      {* user_account *}
      <div class="mobile-div-title-grn">
        <span class="mobile-label-grn">{cb_msg module='grn.mail' key='GRN_MAIL-44' replace='true'}</span>
        <div><span class="mobile_mail_text_grn">{$user.label|escape}</span></div>
      </div>

      {* to *}
      <div id="div_to" class="mobile_mail_grn mobile_mailto_grn mobile-div-title-grn">
        <span class="mobile-label-grn">{cb_msg module='grn.mail' key='GRN_MAIL-357' replace='true'}</span>
        <span class="mobile_mailtotext_grn">
          {if ! $mail.cc && ! $mail.bcc}<a id="openccbcc" href="javascript:void(0);">{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-13' replace='true'}</a>{/if}
        </span>
        <select id="selectTo" name="selectTo" class="hidden" data-role="none"></select>
        <textarea name="to" id="to" class="mail-textareaTo-grn hidden" maxlength="65535" data-role="none">{$mail.to|escape}</textarea>
      </div>

      {* cc *}
      <div id="div_cc" class="mobile-div-title-grn" {if ! $mail.cc && ! $mail.bcc}style="display: none"{/if}>
        <span class="mobile-label-grn">{cb_msg module='grn.mail' key='GRN_MAIL-423' replace='true'}</span>
        <select id="selectCC" name="selectCC" class="hidden" data-role="none"></select>
        <textarea name="cc" id="cc" class="mail-textareaTo-grn hidden" maxlength="65535" data-role="none">{$mail.cc|escape}</textarea>
      </div>

      {* bcc *}
      <div id="div_bcc" class="mobile-div-title-grn" {if ! $mail.cc && ! $mail.bcc}style="display: none"{/if}>
        <span class="mobile-label-grn">{cb_msg module='grn.mail' key='GRN_MAIL-424' replace='true'}</span>
        <select id="selectBCC" name="selectBCC" class="hidden" data-role="none"></select>
        <textarea name="bcc" id="bcc" class="mail-textareaTo-grn hidden" maxlength="65535" data-role="none">{$mail.bcc|escape}</textarea>
      </div>

      {* title *}
      <div class="mobile-div-title-grn">
        <span class="mobile-label-grn">{cb_msg module='grn.mail' key='GRN_MAIL-361' replace='true'}</span>
        {grn_text name="subject" id="subject_mail" size="104" maxlength="255" value=$mail.subject disable_return_key=true}
      </div>

      {* attach files *}
        <div class="mobile-div-title-grn">
          <span class="mobile-label-grn">{cb_msg module='grn.mail' key='GRN_MAIL-338' replace='true'}</span>
          {include file="grn/mobile_attach_file.tpl" attached_files=$mail.attached_files}
        </div>

      {* body *}
      <div class="mobile-div-title-grn">
        <span class="mobile-label-grn">{cb_msg module='grn.mail' key='GRN_MAIL-370' replace='true'}</span>
        {grn_textarea name="data" id="data_editor_id" class="mobile-textarea-grn mobile_textarea_control_main_grn" value=$mail.data}
      </div>

      {* sign *}
      {if $user_sign}
        <div class="mobile-div-title-grn">
          <span class="mobile-label-grn">{cb_msg module='grn.mail' key='GRN_MAIL-364' replace='true'}</span>
          <a id="sign_menu" href="#popup_sign_menu" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn mobile_label_next_grn">
            <span class="mobile_event_menu_content_grn">{$mail.sign.name|escape}</span>
            <span class="mobile_select_icon_grn"></span>
          </a>
          <input type="hidden" name="sign" value="{$mail.sign.sign_id|escape}" id="sign_id" onchange="G.changeSign();">
          <input type="hidden" name="position" value="{$mail.sign.position|escape}" id="position_id">
          {capture name='grn_mail_mobile_GRN_MAIL_MOBILE_17'}{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-17' replace='true'}{/capture}
          {include file="grn/mobile_select_menu.tpl"
          selectMenuTitle=$smarty.capture.grn_mail_mobile_GRN_MAIL_MOBILE_17
          select_items=$user_sign
          selectMenuUI='sign_menu'
          selectMenuValue='sign_id'
          popupMenu='popup_sign_menu'
          name_value='sign_id'
          name_title='name'
          selected_value=$mail.sign.sign_id
          }
          {grn_textarea name="sign_value" id="sign_value_id" class="mobile-textarea-grn mobile_textarea_control_sub_grn mobile_textarea_sub_grn" value=$mail.sign.data}
        </div>
      {/if}

      {* send_set *}
      {if $send_set}
        <div class="mobile-div-title-grn mobile_mail_checkbox_grn">
          <span class="mobile-label-grn">{cb_msg module='grn.mail' key='GRN_MAIL-365' replace='true'}</span>
            <div>
              {assign var='checkbox_id' value=$form_name|cat:'_'|cat:'date'}
              <label for="{$checkbox_id}">
                <a id="give_open_checkbox" href="javascript:void(0);" class="mobile-checkboxOff-todo-grn"></a>
                <span class="mobile_checkbox_grn">
                  <input name="give_open_check" id="{$checkbox_id}" type="checkbox" data-role="none" class="mobile-input-grn"/>
                </span>
              </label>
              <span class="mobile_btn_checkboxtext_grn">{cb_msg module='grn.mail' key='GRN_MAIL-366' replace='true'}</span>
            </div>
        </div>
      {/if}

      <div class="mobile-buttonArea-grn">
        {include file="$button_file"}
      </div>
    {/if}
  {/strip}
</div>