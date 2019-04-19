{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
  {include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
  <div class="mobile-padding-leftright-grn">
    <ul data-role="listview" data-theme="{$data_theme}" id="mail_address_list" class="mobile-top-listview-member-grn mobile-bottom-listview-member-grn">
      {include file='mail/mobile/_address_item.tpl'}
    </ul>
    {include file='grn/mobile_list_more_view.tpl' request_page='mail/mobile/ajax/get_more_address_list' list_id='mail_address_list' trigger_create=true}
  </div>
</div>