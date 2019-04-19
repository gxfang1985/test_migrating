<div class="mobile-buttonArea-grn">
  <div class="mobile_btn_with_sub_grn">
    <div class="mobile_ok_grn mobile_show_overlay_js">
      {if $preview}
        <input id="submitBtn" type="button" data-inline="true" data-theme="{$data_theme}" onclick="G.do_mobile_submit(event, 'preview');" value="{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-16' replace='true'}"/>
      {else}
        <input id="submitBtn" type="button" data-inline="true" data-theme="{$data_theme}" onclick="G.do_mobile_submit(event, 'send');" value="{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-16' replace='true'}"/>
      {/if}
    </div>
    <div class="mobile_ok_sub_grn mobile_show_overlay_js">
      <input type="button" data-inline="true" data-theme="{$data_theme}" onclick="G.do_mobile_submit(event, 'draft');" value="{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-14' replace='true'}"/>
    </div>
  </div>
  <div class="mobile_cancel_grn mobile_show_overlay_js">
    <input type="button" data-inline="true" data-theme="{$data_theme}" onclick="location.href='{grn_pageurl page="mail/mobile/view" mid=$mid}';" value="{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-15' replace='true'}"/>
  </div>
</div>

