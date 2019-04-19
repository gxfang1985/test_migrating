{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{if ! $file_dpage}{assign var='file_dpage' value='mail/file_download'}{/if}
{grn_load_javascript file="grn/html/page/mail/mobile/preview.js"}
{assign var="form_name" value=$smarty.template|basename}

<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
  {include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
  <form id="mail_send_confirm" name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='mail/mobile/ajax/command_preview'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="baid" value="{$baid}">
    <input type="hidden" name="bcid" value="{$bcid}">
    <input type="hidden" name="mid" value="{$mid}">
    <input type="hidden" name="tmpid" value="{$mail.mid}">
    <input type="hidden" name="signid" value="{$signid}">
    <input type="hidden" name="draft_id" value="{$draft_id}">
    <input type="hidden" name="sign_position" value="{$sign_position}">
    <input type="hidden" name="from_index" value="{$from_index}">
    <input type="hidden" name="data" value="{$mail.data}">
    <input type="hidden" name="data_plain_text" value="{$mail.data_plain_text}">
    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="cmd">
    <input type="hidden" name="use_ajax" value="1">
    <div class="mobile_buttonarea_top_grn">
      <div class="mobile-buttonArea-grn">
        <div class="mobile-buttonMain-grn mobile-button-left-grn">
          <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.mail' key='GRN_MAIL-255' replace='true'}" onclick="grn.page.mail.mobile.preview.ajaxSubmit('send', 'mail_send_confirm', '{$form_name|escape}');"/>
        </div>
        <div class="mobile-buttonNormal-grn mobile-button-right-grn">
          <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.mail' key='GRN_MAIL-256' replace='true'}" onclick="grn.page.mail.mobile.preview.ajaxSubmit('modify', 'mail_send_confirm', '{$form_name|escape}');"/>
        </div>
      </div>
    </div>
    <div class="mobile-cmt-operate-grn">
      {include file='mail/mobile/_preview.tpl'}
      <div class="mobile-buttonArea-grn">
        <div class="mobile-buttonMain-grn mobile-button-left-grn">
          <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.mail' key='GRN_MAIL-255' replace='true'}" onclick="grn.page.mail.mobile.preview.ajaxSubmit('send', 'mail_send_confirm', '{$form_name|escape}');"/>
        </div>
        <div class="mobile-buttonNormal-grn mobile-button-right-grn">
          <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.mail' key='GRN_MAIL-256' replace='true'}" onclick="grn.page.mail.mobile.preview.ajaxSubmit('modify', 'mail_send_confirm', '{$form_name|escape}');"/>
        </div>
      </div>
    </div>
  </form>
</div>