{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn">
  {include file='grn/mobile_breadcrumb.tpl'}
  {include file='grn/_mobile_delete_confirm.tpl'}
  <div data-theme="{$data_theme}" class="mobile_button_area_grn mobile_button_delete_grn">
    <div class="mobile_ok_grn">
      <input type="button" value="{cb_msg module='grn.common' key='yes' replace='true'}" data-inline="true" data-theme="{$data_theme}" onclick="grn.component.mobile_ajax_submit.ajaxSubmit('{$form_id}', {if $beforeSendFn}{$beforeSendFn}{else}''{/if}, {if $afterSendFn}{$afterSendFn}{else}''{/if});"/>
    </div>
    <div class="mobile_cancel_grn mobile_show_overlay_js">
      <input type="button" value="{cb_msg module='grn.common' key='no' replace='true'}" data-inline="true" data-theme="{$data_theme}" onclick="javascript:history.back();"/>
    </div>
  </div>
</div>