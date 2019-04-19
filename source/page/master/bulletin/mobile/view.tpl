{grn_load_javascript file="grn/html/component/i18n.js"}
{grn_load_javascript_resource}
{include file='favour/mobile/_favour_common.tpl'}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='bulletin_prefix' value='bulletin/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='bulletin/mobile/file_download'}{/if}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){{/literal}
    {if $article.can_follow && $article.auth.follow}
        var GS = grn.component.mobile_common;
        GS.comment_add_url = '{grn_pageurl page=$bulletin_prefix|cat:"/comment_add"}';
        GS.add_comment_args = {ldelim}'cid' : '{$article.cid}',
                                      'aid' : '{$article.aid}'{rdelim};

        var G = grn.component.define_cybozu_browser;
        G.addToolBarItem(
                "add_comment", "{cb_msg module='grn.kunai' key='GRN_KUNAI-7' replace='true'}",
                '{grn_pageurl page=$bulletin_prefix|cat:"/comment_add" cid=$article.cid aid=$article.aid}'
         );
    {/if}
{literal}
})()
</script>
{/literal}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
  {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
  <ul data-role="none" class="mobile-ul-withStar-grn mobile-textspace-withStar-grn mobile-detailTitle-grn">
    <li>
      {strip}
        {if $use_star}
            {include file="grn/mobile_star_init.tpl"}
            {grn_mobile_star_icon module="grn.bulletin" star_infos=$star_infos unique_id=$article.aid aid=$article.aid cid=$article.cid}
        {/if}
        <span>{$article.title}</span>
      {/strip}
    </li>
  </ul>
  <div class="mobile-list-login-grn mobile-cmt-operate-grn mobile-todoBodyText-grn">
    {if $article.modified}
      <div class="mobile-separation-grn"></div>
      <div class="mobile-textspace-unread-grn">
    {elseif $article.data || $article.attach_files}
      <div class="mobile-separation-grn"></div>
      <div class="mobile-textspace-div-grn">
    {/if}
    {if $article.data}
      <span class="mobile-font-normal-grn">{grn_mobile_format body=$article.data}</span>
    {/if}
    {if $article.attach_files}
      <div class="mobile-attachmentButton-grn">
        {foreach from=$article.attach_files item=file}
          {grn_mobile_attach_file_link name=$file.name dpage=$file_dpage cid=$article.cid aid=$article.aid fid=$file.id}
        {/foreach}
      </div>
    {/if}
    {if $article.modified || $article.data || $article.attach_files}
      </div>
    {/if}
        {if $is_favour_active}
          <div class="mobile-list-todoDetail-grn">
            {include file="favour/mobile/_favour.tpl"}
          </div>
        {/if}
    <div class="mobile-separation-grn"></div>
    {if $article.manually_enter_sender}
        <div class="mobile-list-todoDetail-grn">
          <div class="mobile-label-small-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-140' replace='true'}</div>
          <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{$article.manually_enter_sender|escape}</div>
        </div>
        <div class="mobile-list-todoDetail-grn">
          <div class="mobile-label-small-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-648' replace='true'}</div>
          <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{grn_date_format date=$article.ctime format="DateTimeMiddle_YMDW_HM"}</div>
        </div>
        <div class="mobile-list-todoDetail-grn">
          <div class="mobile-label-small-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-650' replace='true'}</div>
          <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{grn_date_format date=$article.mtime format="DateTimeMiddle_YMDW_HM"}</div>
        </div>
    {else}
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-140' replace='true'}</div>
        <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{if $article.group_name}{$article.group_name|escape} ({/if}{grn_user_name uid=$article.creator_uid name=$article.creator_name users_info=$users_info only_text=true}{if $article.group_name}){/if}<span class="mobile-date-list-grn">{grn_date_format date=$article.ctime format="DateTimeMiddle_YMDW_HM"}</span></div>
      </div>
      <div class="mobile-list-todoDetail-grn">
        <div class="mobile-label-small-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-142' replace='true'}</div>
        <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{grn_user_name uid=$article.modifier_uid name=$article.modifier_name users_info=$users_info only_text=true}<span class="mobile-date-list-grn">{grn_date_format date=$article.mtime format="DateTimeMiddle_YMDW_HM"}</span></div>
      </div>
    {/if}
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-144' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">
        {if $article.start_is_datetime && $article.end_is_datetime}
          {grn_show_period start=$article.stime end=$article.etime start_format='DateTimeFull_YMDW_HM' end_format='DateTimeFull_YMDW_HM'}
        {elseif !$article.start_is_datetime && $article.end_is_datetime}
          {grn_show_period start=$article.stime end=$article.etime start_format='DateFull_YMDW' end_format='DateTimeFull_YMDW_HM'}
        {elseif $article.start_is_datetime && !$article.end_is_datetime}
          {grn_show_period start=$article.stime end=$article.etime start_format='DateTimeFull_YMDW_HM' end_format='DateFull_YMDW'}
        {else}
          {grn_show_period start=$article.stime end=$article.etime start_format='DateFull_YMDW' end_format='DateFull_YMDW'}
        {/if}
        {if $article.expired}
          <span class="mobile-date-list-grn" style="color: red">{cb_msg module='grn.bulletin' key='GRN_BLLT-146' replace='true'}</span>
        {/if}
      </div>
    </div>
  </div>
  {if $article.can_follow && $article.auth.follow}
    <div class="mobile-separation-grn"></div>
    <div class="mobile-comment-grn mobile-todoAddComment-grn" id="comment_top">
      <input type="text" name="title" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-596' replace='true'}" readonly="readonly" onclick="javascript:grn.component.mobile_common.toAddComment();"/>
    </div>
  {else}
    <div class="mobile-addCommentDisable-grn" id="comment_top"></div>
  {/if}
  {if $article.follows|@count>0}
    <div class="mobile_comment_list_grn">
      <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-bottom-grn mobile-padding-leftright-grn" id="comment_list">
        {include file=$bulletin_prefix|cat:'/comment_list.tpl'}
      </ul>
    </div>
    {include file='grn/mobile_list_more_view.tpl' request_page=$bulletin_prefix|cat:'/ajax/comment_list' list_id='comment_list' trigger_create=true}
  {/if}
</div><!--content-->
