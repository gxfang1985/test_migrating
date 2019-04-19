{capture name='list_title'}
  {cb_msg module="grn.schedule" key='GRN_SCH-45' replace='true'}
  {cb_msg module="grn.schedule" key='GRN_SCH-933' replace='true'}
{/capture}
{if !$data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
  {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
  <div class="mobile-title-member-grn">
    {$smarty.capture.list_title}{$count}
  </div>
  <div class="mobile-padding-leftright-grn">
    <ul data-role="listview" data-theme="{$data_theme}" id="member_list" class="mobile-top-listview-member-grn mobile-bottom-listview-member-grn">
      {include file='schedule/mobile/_facility_info_list.tpl'}
    </ul>
    {include file='grn/mobile_list_more_view.tpl' request_page=$request_page list_id='member_list'}
  </div>
</div>
