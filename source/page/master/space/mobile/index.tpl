{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{if $space_collection->getCountNoLimit() == 0}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
  {include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
  <div class="mobile-bodyText-grn">
    <span>{cb_msg module='grn.space' key='space_mobile-2' replace='true'}</span>
  </div>
{else}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
  {include file='grn/mobile_breadcrumb.tpl'}
  <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile-ul-bottom-grn" id="my_space_list">
    {include file='space/mobile/my_space_list.tpl'}
  </ul>
  {include file='grn/mobile_list_more_view.tpl' request_page='space/mobile/ajax/my_space_list' list_id='my_space_list'}
{/if}
</div><!-- end of content-->