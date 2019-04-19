{if !$data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
{include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
  <div class="mobile-title-member-grn">
    {cb_msg module="grn.report" key='outside_parties' replace='true'}{cb_msg module="grn.report" key='GRN_RPRT-87' replace='true'}
    {$count}{cb_msg module='grn.mobile' key='GRN_MOBILE-1' replace='true'}
  </div>
  <div class="mobile-padding-leftright-grn">
    <ul data-role="listview" data-theme="{$data_theme}" id="member_list" class="mobile-top-listview-member-grn mobile-bottom-listview-member-grn">
      {include file='report/mobile/outside_parties_list.tpl'}
    </ul>
    {include file='grn/mobile_list_more_view.tpl' request_page='report/mobile/ajax/outside_parties_list' list_id='member_list'}
  </div>
</div>