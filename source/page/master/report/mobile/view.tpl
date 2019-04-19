{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='report_prefix' value='report/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='report/mobile/file_download'}{/if}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){{/literal}
    {if $report.enable_follow}
        var GS = grn.component.mobile_common;
        GS.comment_add_url = '{grn_pageurl page=$report_prefix|cat:"/comment_add"}';
        GS.add_comment_args = {ldelim}'rid' : '{$report_id}'{rdelim};

        var G = grn.component.define_cybozu_browser;
        G.addToolBarItem(
                "add_comment", "{cb_msg module='grn.kunai' key='GRN_KUNAI-7' replace='true'}",
                '{grn_pageurl page=$report_prefix|cat:"/comment_add" rid=$report_id}'
        );
    {/if}
{literal}
})();
</script>
{/literal}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
{include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
  <ul data-role="none" class="mobile-ul-withStar-grn mobile-textspace-withStar-grn mobile-detailTitle-grn">
    <li>
      {if $use_star}
        {include file="grn/mobile_star_init.tpl"}
        {grn_mobile_star_icon module="grn.report" star_infos=$star_infos unique_id=$report_id rid=$report_id}
      {/if}
      <span>{$report_title}</span>
    </li>
  </ul>
  <div class="mobile-list-login-grn mobile-cmt-operate-grn mobile-todoBodyText-grn">
    {if $report.enable_member || ($report.enable_partner && $partner)}
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-bottom-listview-grn mobile-li-PersonInCharge-grn listviewFirst-grn">
      <div class="mobile-separation-grn"></div>
      {if $report.enable_member}
      <li data-icon="false">
        <a href="{grn_pageurl page=$report_prefix|cat:'/attendee_list' rid=$report_id}">
          <div class="mobile-label-small-grn">{cb_msg module='grn.report' key='GRN_RPRT-90' replace='true'}</div>
          <div class="mobile-font-warp-grn forTotalNumber-grn">{$attendee_name|escape}</div>
          <span class="totalNumber-grn">{$attendee_num}</span>
          <span class="mobile-array-todo-grn"></span>
        </a>
      </li>
      <div class="mobile-separation-grn"></div>
      {/if}
      {if $report.enable_partner && $partner}
      <li data-icon="false">
        <a href="{grn_pageurl page=$report_prefix|cat:'/outside_parties_list' rid=$report_id}">
          <div class="mobile-label-small-grn">{cb_msg module='grn.report' key='outside_parties' replace='true'}</div>
          <div class="mobile-font-warp-grn forTotalNumber-grn">{$partner->getSubject()|escape}{if strlen($partner->getCompanyName()) > 0}({$partner->getCompanyName()|escape}){/if}</div>
          <span class="totalNumber-grn">{$partners_num}</span>
          <span class="mobile-array-todo-grn"></span>
        </a>
      </li>
      <div class="mobile-separation-grn"></div>
      {/if}
    </ul>
      {if $report.enable_partner && ! $partner}
        <div class="mobile-list-todoDetail-grn">
          <div class="mobile-label-small-grn">{cb_msg module='grn.report' key='outside_parties' replace='true'}</div>
          <div class="mobile-contents-todoDetail-grn"></div>
        </div>
        <div class="mobile-separation-grn"></div>
      {/if}
    {else}
      {if $report.enable_partner}
        <div class="mobile-separation-grn"></div>
        <div class="mobile-list-todoDetail-grn">
          <div class="mobile-label-small-grn">{cb_msg module='grn.report' key='outside_parties' replace='true'}</div>
          <div class="mobile-contents-todoDetail-grn"></div>
        </div>
      {/if}
      <div class="mobile-separation-grn"></div>
    {/if}
  {foreach from=$item_data_list item=item_data_line}
    {if $item_data_line.type != 1 && $item_data_line.type != 2}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{$item_data_line.display_name|escape}</div>
      <div class="mobile-contents-todoDetail-grn">{grn_mobile_report_include_item item=$item_data_line}</div>
    </div>
    {/if}
    {if $item_data_line.type != 1}
    <div class="mobile-separation-grn"></div>
    {/if}
  {/foreach}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.report' key='GRN_RPRT-361' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn">{if $report.private}{cb_msg module='grn.report' key='GRN_RPRT-363' replace='true'}{else}{cb_msg module='grn.report' key='GRN_RPRT-364' replace='true'}{/if}</div>
    </div>
    {if $notification_user_num > 0}
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-bottom-listview-grn mobile-li-PersonInCharge-grn">
      <div class="mobile-separation-grn"></div>
      <li data-icon="false">
        <a href="{grn_pageurl page=$report_prefix|cat:'/watchers_list' rid=$report_id}">
          <div class="mobile-label-small-grn">{if $report.enable_member}{cb_msg module='grn.report' key='GRN_RPRT-86' replace='true'}{else}{cb_msg module='grn.report' key='notification' replace='true'}{/if}</div>
          <div class="mobile-font-warp-grn forTotalNumber-grn">{$notification_user_name_for_view|escape}</div>
          <span class="totalNumber-grn">{$notification_user_num}</span>
          <span class="mobile-array-todo-grn"></span>
        </a>
      </li>
      <div class="mobile-separation-grn"></div>
    </ul>
    {else}
      <div class="mobile-separation-grn"></div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{if $report.enable_member}{cb_msg module='grn.report' key='GRN_RPRT-86' replace='true'}{else}{cb_msg module='grn.report' key='notification' replace='true'}{/if}</div>
        <div class="mobile-contents-todoDetail-grn"></div>
      </div>
      <div class="mobile-separation-grn"></div>
    {/if}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.report' key='GRN_RPRT-82' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn">{grn_user_name uid=$report.creator name=$report.creator_name users_info=$users_info only_text=true}&nbsp;<span class="mobile-date-list-grn">{grn_date_format date=$report.ctime format="DateTimeMiddle_YMDW_HM"}</span></div>
    </div>
    {if $report.modifier neq ''}
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.report' key='GRN_RPRT-84' replace='true'}</div>
        <div class="mobile-contents-todoDetail-grn">{grn_user_name uid=$report.modifier name=$report.modifier_name users_info=$users_info only_text=true}&nbsp;<span class="mobile-date-list-grn">{grn_date_format date=$report.mtime format="DateTimeMiddle_YMDW_HM"}</span></div>
      </div>
    {/if}
  </div>
  {if $report.enable_follow}
    <div class="mobile-separation-grn"></div>
    <div class="mobile-comment-grn mobile-todoAddComment-grn" id="comment_top">
      <input type="text" name="title" value="{cb_msg module='grn.report' key='report_mobile-1' replace='true'}" readonly="readonly" onclick="javascript:grn.component.mobile_common.toAddComment();"/>
    </div>
  {else}
    <div class="mobile-addCommentDisable-grn"></div>
  {/if}
  {if $follow_list|@count>0}
    <div class="mobile_comment_list_grn">
      <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-bottom-grn mobile-padding-leftright-grn" id="comment_list">
        {include file=$report_prefix|cat:'/comment_list.tpl'}
      </ul>
    </div>
    {include file='grn/mobile_list_more_view.tpl' request_page=$report_prefix|cat:'/ajax/comment_list' list_id='comment_list' trigger_create=true}
  {/if}
</div><!--content-->