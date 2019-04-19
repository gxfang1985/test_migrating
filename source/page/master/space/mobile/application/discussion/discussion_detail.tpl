{grn_load_javascript file="grn/html/component/i18n.js"}
{grn_load_javascript_resource}
{include file='favour/mobile/_favour_common.tpl'}
{include file='grn/ajax/mobile_member_list_dialog.tpl'}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='discussion_prefix' value='space/mobile/application/discussion'}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){{/literal}
    var GS = grn.component.mobile_common;
    GS.comment_add_url = '{grn_pageurl page=$discussion_prefix|cat:"/comment_add"}';
    GS.add_comment_args = {ldelim}'spid' : '{$space_id}',
                                  'tid' : '{$discussion->getId()}'{rdelim};

    document.title = document.title+' - '+'{$discussion->getTitle()|escape:javascript}';
    var G = grn.component.define_cybozu_browser;
    G.addToolBarItem(
            "my_space", "{cb_msg module='grn.kunai' key='GRN_KUNAI-1' replace='true'}",
            '{grn_pageurl page="space/mobile/index"}'
    );
    {if $todo_add_auth}
    G.addToolBarItem(
            "todo_add", "{cb_msg module='grn.kunai' key='GRN_KUNAI-3' replace='true'}",
            '{grn_pageurl page="space/mobile/application/todo/add" spid=$space_id tid=$discussion->getId() from=4}'
    );
    {/if}
    G.addToolBarItem(
            "member_view", "{cb_msg module='grn.kunai' key='GRN_KUNAI-6' replace='true'}",
            '{grn_pageurl page="space/mobile/member_list" spid=$space_id}'
    );
{literal}
})()
</script>
{/literal}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
{include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
{grn_space_show_expiration_date_warning space=$space is_mobile=true}
  <ul data-role="none" class="mobile-ul-withStar-grn mobile-textspace-withStar-grn mobile-detailTitle-grn">
    <li>
      {strip}
      {if $use_star}
        {include file="grn/mobile_star_init.tpl"}
        {grn_mobile_star_icon module=$module star_infos=$star_infos submdl=$sub_module unique_id=$discussion->getId() spid=$space_id tid=$discussion->getId()}
      {/if}
      <span>{$discussion->getTitle()|escape}</span>
      {/strip}
    </li>
  </ul>
  {if $discussion->getContent() || $has_attached_file}
  <div class="mobile-cmt-operate-grn">
    <div class="mobile-bodyTextSummary-grn">
      <ul data-role="listview" data-theme="{$data_theme}" class="mobile-padding-leftright-grn mobile-ul-top-grn mobile-ul-bottom-grn">
        <div class="mobile-separation-grn"></div>
        <li data-icon="false" {if $discussion->isUnread()}class="mobile-comment-unread-grn"{/if}>
          <a href="{grn_pageurl page=$discussion_prefix|cat:'/body' spid=$space_id tid=$discussion->getId()}" class="mobile-a-with2icons-grn ">
            <span>{$discussion->getContent()|escape}</span>&nbsp;
            {if $has_attached_file}<span class="mobile-icon-attachment-list-grn"></span>{/if}
            <span class="mobile-array-list-grn"></span>
          </a>
        </li>
      </ul>
    </div>
  </div>
  {/if}
  <div id="comment_top" class="mobile-commentAndMsg-grn mobile-padding-leftright-grn mobile-threadAddComment-grn">
    <input type="text" name="title" value="{cb_msg module='grn.space' key='space_mobile-3' replace='true'}" readonly="readonly" onclick="javascript:grn.component.mobile_common.toAddComment()"/>
  </div>
  {if $comments|@count>0}
    <div class="mobile_comment_list_grn">
      <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-bottom-grn mobile-padding-leftright-grn" id="discussion_comment_list">
        {include file=$discussion_prefix|cat:'/comment_list.tpl' discussion_id=$discussion->getId()}
      </ul>
    </div>
    {include file='grn/mobile_list_more_view.tpl' request_page=$discussion_prefix|cat:'/ajax/comment_list' list_id='discussion_comment_list' trigger_create=true}
  {/if}
</div><!-- end of content-->
{literal}
<script>
    (function () {
        var settings = {
            {/literal}
            accessPluginEncoded: "{$mention_access_plugin_encoded}",
            {literal}
        };
        var dialog = new grn.js.component.common.ui.dialog.MobileMemberListDialog(settings);
        dialog.render();
        dialog.bindDialogToMembersContainer("#discussion_comment_list");
    })();
</script>
{/literal}


