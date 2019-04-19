{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='todo_prefix' value='space/mobile/application/todo'}
{grn_load_javascript file="grn/html/page/space/mobile/todo/detail.js"}
{grn_load_javascript file="grn/html/component/i18n.js"}
{grn_load_javascript_resource}
{include file='favour/mobile/_favour_common.tpl'}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){{/literal}
    var D = grn.page.space.mobile.todo.detail;
    D.spinnerImage = '{$app_path}/grn/image/cybozu/image-mobile/spinner.gif?{$build_date}';
    D.complete_url = '{grn_pageurl page="space/mobile/application/todo/ajax/command_complete"}';

    var GS = grn.component.mobile_common;
    GS.comment_add_url = '{grn_pageurl page=$todo_prefix|cat:"/comment_add"}';
    GS.add_comment_args = {ldelim}'spid' : '{$space_id}',
                                  'tdid' : '{$todo->getId()}'{rdelim};

    document.title = document.title+' - '+'{$todo->getTitle()|escape:javascript}';
    var G = grn.component.define_cybozu_browser;
    G.addToolBarItem(
            "my_space", "{cb_msg module='grn.kunai' key='GRN_KUNAI-1' replace='true'}",
            '{grn_pageurl page="space/mobile/index"}'
    );
    {if $isOperator}
    G.addToolBarItem(
            "todo_edit", "{cb_msg module='grn.kunai' key='GRN_KUNAI-4' replace='true'}",
            '{grn_pageurl page=$todo_prefix|cat:"/modify" spid=$space_id tdid=$todo->getId()}'
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

<div data-role="content" data-theme="{$data_theme}"  class="mobile-content-padding-grn">
  {include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
  {grn_space_show_expiration_date_warning space=$space is_mobile=true}
  <div class="mobile-check-todoDetail-grn mobile-detailTitle-grn">
    {strip}
    {if $isTodoUser}
    <a href="javascript:void(0);" onclick="grn.page.space.mobile.todo.detail.complete('{$space_id}','{$todo->getId()}','{$csrf_ticket}',grn.page.space.mobile.todo.detail.updateCompleteUser)" data-id="checkbox_{$todo->getId()}" class="mobile-checkbox{if !$loginUserComplete}Off{/if}-todo-grn"></a>
    {/if}
    <span>{$todo->getTitle()|escape}</span>
    {/strip}
  </div>
  <div class="mobile-list-login-grn mobile-cmt-operate-grn mobile-todoBodyText-grn">
    <div class="mobile-separation-grn"></div>
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-28' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn">
        {if $start_date}
          {grn_date_format date=$start_date format="DateLong_YMDW"}
          {cb_msg module='grn.space.todo' key='GRN_SP_TOD-33' replace='true'}
        {/if}
        {if $end_date}
          {grn_date_format date=$end_date format="DateLong_YMDW"}
        {else}
          {cb_msg module='grn.space.todo' key='GRN_SP_TOD-42' replace='true'}
        {/if}
      </div>
    </div>
    <div data-id="users_{$todo->getId()}">
      {include file=$todo_prefix|cat:'/todo_users.tpl'}
    </div>
    {if $todo->getContent()}
    <div class="mobile-separation-grn"></div>
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-5' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn">{grn_mobile_format body=$todo->getContent()}</div>
    </div>
    {/if}
    {if count($attachedFiles)>0}
    <div class="mobile-separation-grn"></div>
    <div class="mobile-attachmentButton-grn">
      {foreach from=$attachedFiles item=file}
        {grn_mobile_attach_file_link name=$file.name dpage="space/mobile/file_download" spid=$space_id tid=$thread->getId() fid=$file.id}
      {/foreach}
    </div>
    {/if}
    <div class="mobile-separation-grn"></div>
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-75' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn">
        <a href="{grn_pageurl page='space/mobile/application/discussion/detail' spid=$space_id tid=$thread->getId()}" ><span class="mobile-icon-commentLink-todo-grn"></span>{$thread->getTitle()|escape}</a>
      </div>
    </div>
    <div class="mobile-separation-grn"></div>
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-63' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{$creator->getDisplayName()|escape} <span class="mobile-date-list-grn"> {$todo->getCreateDisplayDatetime()|escape}</span></div>
    </div>
    <div class="mobile-separation-grn"></div>
    {if $is_favour_active}
      <div class="mobile-list-todoDetail-grn">
        {include file="favour/mobile/_favour.tpl"}
      </div>
      <div class="mobile-separation-grn"></div>
    {/if}
  </div><!--mobile-todoBodyText-grn-->
  <div id="comment_top" class="mobile-comment-grn mobile-todoAddComment-grn">
      <input type="text" name="title" value="{cb_msg module='grn.space' key='space_mobile-3' replace='true'}" readonly="readonly" onclick="javascript:grn.component.mobile_common.toAddComment()"/>
  </div>
  {if $todo_comments|@count>0}
    <div class="mobile_comment_list_grn">
      <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-bottom-grn mobile-padding-leftright-grn" id="comment_list">
        {include file=$todo_prefix|cat:'/comment_list.tpl'}
      </ul>
    </div>
    {if $offset != -1}
      {include file='grn/mobile_list_more_view.tpl' request_page='space/mobile/application/todo/ajax/comment_list' list_id='comment_list' trigger_create=true}
    {/if}
  {/if}
</div>
