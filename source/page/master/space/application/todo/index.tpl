{grn_load_javascript file="grn/html/page/space/todo/index.js"}
{grn_load_javascript file="grn/html/page/space/todo/todo.js"}
{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="grn/html/page/space/application/join_leave.js"}
{include file='grn/window_simple_dialog.tpl'}
{assign var='todo_prefix' value='space/application/todo'}
{assign var='discussion_prefix' value='space/application/discussion'}
{assign var='is_completed' value='1'}
{assign var='id_searchbox' value='todo_search'}

{literal}
<script language="JavaScript" text="text/javascript">
var __thisPage = grn.page.space.todo.index;
__thisPage.spid = {/literal}"{$space_id}"{literal};
__thisPage.tid = {/literal}"{$thread_id}"{literal};
__thisPage.uid = {/literal}"{$user_id}"{literal};
__thisPage.search_text = {/literal}"{$search_text}"{literal};
__thisPage.search_bits = {/literal}"{$search_bits}"{literal};
__thisPage.spinner = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};
__thisPage.remainingMemberUrl = {/literal}'{grn_pageurl page=$todo_prefix|cat:"/ajax/get_left_remaining_member"}'{literal};

var __grn_todo = grn.page.space.todo.todo;
__grn_todo.spinnerImage = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};
__grn_todo.form = 'todo_add';
__grn_todo.spaceId = {/literal}{$space_id}{literal};
__grn_todo.pageurl = {/literal}'{grn_pageurl page=$todo_prefix|cat:"/ajax/todo_search_user"}'{literal};
</script>
{/literal}

<!-- todo area -->
<table class="space-todo-grn">
 <tr valign="top">
  <!-- todo left -->
  <td class="space-todoLeft-grn">
    <div class="space-todoLeft-inner-grn">
        <div class="space-discussion-search-grn cb-user-picker">
            <form id="id_todo_search_form" class="clearFix-cybozu" name="form_search" method="get" action="{grn_pageurl page=space/search}">
                <input id="type_search" type="hidden" name="type_search" value="todo_fts">
                <input type="hidden" name="searchRange" value="SPACE" />
                <input type="hidden" name="spid" value="{$space_id}" />
                <input type="hidden" name="todo" value="1" />
                <input type="hidden" name="from_todo" value="1" />
                {if $fts}
                    <div class="search_navi">
                        <span id="search_target_button_grn" class="search_target_button_grn tAlignCenter-grn">
                            {capture name="todo_search_name"}{cb_msg module='grn.space.todo' key='todo_search_name' replace='true'}{/capture}
                            <a id="id_pulldown_selection" href="javascript:void(0);" title="{$smarty.capture.todo_search_name}" aria-label="{$smarty.capture.todo_search_name}">
                                {cb_msg module='grn.space.todo' key='todo_search_fts' replace='true'}<span class="mLeft3 pulldownbutton_arrow_down_grn"></span>
                            </a>
                            <div id="id_pulldown_selection_view" class="pulldown_menu_grn pulldown_menu_2way_grn" style="display:block; display:none;">
                                <ul>
                                    <li>
                                        <a id="id_pulldown_candidate" href="javascript:void(0);">
                                            {cb_msg module='grn.space.todo' key='todo_search_user' replace='true'}
                                        </a>
                                    </li>
                               </ul>
                            </div>
                        </span>
                        <div class="searchboxChangeTarget-grn">
                            <div class="searchbox-grn">
                                <div id="searchbox-cybozu-{$id_searchbox}" class="input-text-outer-cybozu searchbox-keyword-area searchbox_keyword_grn">
                                    <input id="keyword_{$id_searchbox}" class="input-text-cybozu" name="text" autocomplete="off" value="{$search_text}" type="text" maxlength="100">
                                    {capture name="todo_search_icon_name"}{cb_msg module='grn.space.todo' key='todo_search_icon_name' replace='true'}{/capture}
                                    <button id="searchbox-submit-{$id_searchbox}" class="searchbox-submit-cybozu" type="button" title="{$smarty.capture.todo_search_icon_name}" aria-label="{$smarty.capture.todo_search_icon_name}"></button>
                                </div>
                                <div class="clear_both_0px"></div>
                            </div>
                        </div>
                    </div>
                {else}
                    {capture name="placeholder"}{cb_msg module='grn.space.todo' key='todo_search_placeholder' replace='true'}{/capture}
                    {include file="grn/_search_box.tpl" id_searchbox=$id_searchbox name_searchbox="text" search_text=$search_text placeholder=$smarty.capture.placeholder width="width:186px;" maxlength="100"}
                {/if}
            </form>
        </div>

{grn_load_javascript file="grn/html/component/pulldown_menu/pulldown_menu.js"}
{grn_load_css file="grn/html/component/pulldown_menu/pulldown_menu.css"}

{grn_load_javascript file="grn/html/component/pubsub.js"}
{grn_load_javascript file="grn/html/component/user_suggest_list.js"}

{grn_load_javascript file="grn/html/page/space/todo/todo_incremental_search.js"}

<script language="JavaScript" type="text/javascript">
    <!--
    new grn.page.space.todo.todo_incremental_search(
            {ldelim}
                searchBoxTextId: "keyword_{$id_searchbox}",
                searchBoxIconId: "searchbox-submit-{$id_searchbox}",
                searchSelection: "{$search_selection}",
                enabledFts: "{$fts}",
                searchBits: "{$search_bits}",
                urlParams: {ldelim}
                    spid: "{$space_id}",
                    tid: "{$thread_id}",
                    search_text:"{$search_text}"
                    {rdelim}
            {rdelim}
    );
    //-->
</script>

      {if $todo_write_auth}
      <div class="space-todoLeft-operation-grn">
        <div class="space-button-grn">
          <a href="javascript:void(0);" onClick="__grn_todo.openTodoAddDialog(2);"><span class="icon-addButton-grn">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-10' replace='true'}</span></a>
        </div>
      </div>
      <div class="space-todoleft-border-grn"></div>
      {/if}
      <div class="space-todoLeft-status-grn">
        <div class="space-todoLeft-status-Incomplete-grn {if $user_id == null && $todo_status != $is_completed}hilight{/if}">
          {capture name='grn_space_GRN_SP_TOD_30'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-30' replace='true'}{/capture}
          {grn_link page=$todo_prefix|cat:'/index' caption=$smarty.capture.grn_space_GRN_SP_TOD_30 spid=$space_id tid=$thread_id s=2}<span class="space-todoLeft-number-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-45' replace='true'}{$count_every_status_todo.count}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-60' replace='true'}</span>
        </div>
        <div class="space-todoLeft-status-Complete-grn {if $user_id == null && $todo_status == $is_completed}hilight{/if}">
          {capture name='grn_space_GRN_SP_TOD_29'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-29' replace='true'}{/capture}
          {grn_link page=$todo_prefix|cat:'/index' caption=$smarty.capture.grn_space_GRN_SP_TOD_29 spid=$space_id tid=$thread_id s=1}
        </div>
        <div class="clear_left"></div>
        <div class="space-todoLeft-status-detail-grn">
          <table>
            <tr>
              <td>
                <div class="icon-space-todoStatusLate-grn">
                  {cb_msg module='grn.space.todo' key='GRN_SP_TOD-39' replace='true'}<span class="space-todoLeft-number-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-45' replace='true'}{$count_every_status_todo.late}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-60' replace='true'}</span>
                </div>
              </td>
              <td>
                <div class="icon-space-todoStatusToday-grn">
                  {cb_msg module='grn.space.todo' key='GRN_SP_TOD-40' replace='true'}<span class="space-todoLeft-number-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-45' replace='true'}{$count_every_status_todo.today}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-60' replace='true'}</span>
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <div class="icon-space-todoStatusInTerm-grn">
                  {cb_msg module='grn.space.todo' key='GRN_SP_TOD-41' replace='true'}<span class="space-todoLeft-number-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-45' replace='true'}{$count_every_status_todo.inTerm}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-60' replace='true'}</span>
                </div>
              </td>
              <td>
                <div class="icon-space-todoStatusNoTerm-grn">
                  {cb_msg module='grn.space.todo' key='GRN_SP_TOD-42' replace='true'}<span class="space-todoLeft-number-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-45' replace='true'}{$count_every_status_todo.noTerm}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-60' replace='true'}</span>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div class="space-todoleft-border-grn"></div>
      <div class="space-todoLeft-member-grn">
        <div class="space-todoLeft-label-grn inline_block_grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-4' replace='true'}</div>
        {if $search_bits == 1 || $search_bits == 2}
            <span class="textSub-grn mLeft10" >
                <a href="{grn_pageurl page=$todo_prefix|cat:'/index' spid=$space_id tid=$thread_id search_bits=4 action='reset'}">
                    {cb_msg module='grn.space.todo' key='todo_search_user_reset' replace='true'}
                </a>
            </span>
        {/if}
        {if count($space_user_list)>0}
            <ul id="left_member_list">
              {include file='space/application/todo/left_member_list.tpl'}
            </ul>
        {else}
            <div class="text_color_sub2_grn bold_grn mTop7 mBottom10">
                {cb_msg module='grn.space.todo' key='todo_search_no_results' replace='true'}
            </div>
        {/if}
        {if $has_left_remaining_member}
          <span class="nowrap-grn" id="remain_span"><a class="icon-toggle-show-grn" href="javascript:void(0);" onclick="__thisPage.getLeftRemainingMember();">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-44' replace='true'}</a></span>
        {/if}
        {if $exists_out_of_members}
          {grn_space_todo_out_of_members space_id = $space_id}
        {/if}
      </div>
    </div>
  </td>
  <!-- end of todo left -->

  <!-- todo right -->
  <td class="space-todoList-grn">
    <div class="space-todo-inner-grn">
      <div class="space-todoMain-grn">
        <div class="space-todoMain-inner-grn">
          <div class="space-todoList-menu-grn">
            <span class="space-todoList-threadName-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-36' replace='true'}</span>
            <select onchange="{literal}v=this.options[this.selectedIndex].value;if(v){location.href=v;}{/literal}">
              <option value="{grn_pageurl page=$todo_prefix|cat:'/index' spid=$space_id uid=$user_id s=$todo_status}">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-38' replace='true'}</option>
                {if !$has_folder_view}
                  {foreach from=$thread_collection item=thread}
                    <option value="{grn_pageurl page=$todo_prefix|cat:'/index' spid=$space_id tid=$thread->getId() uid=$user_id s=$todo_status}" {if $thread_id == $thread->getId()}selected{/if}>{$thread->getTitle()|escape}</option>
                  {/foreach}
                {else}
                  {foreach from=$thread_collection_for_view key=folder_key item=folder_value}
                    <optgroup label="{$folder_value.folder_name|escape}">
                    {foreach from=$folder_value.threads item=thread}
                      <option value="{grn_pageurl page=$todo_prefix|cat:'/index' spid=$space_id tid=$thread->getId() uid=$user_id s=$todo_status}" {if $thread_id == $thread->getId()}selected{/if}>{$thread->getTitle()|escape}</option>
                    {/foreach}
                  {/foreach}
                {/if}
            </select>
          </div>
          {include file='space/application/todo/_todo_list.tpl'}
        </div>
      </div>
    </div>
  </td>
  <!-- end of todo right -->
 </tr>
</table>
<!-- end of todo area -->
{include file="space/application/todo/todo_add.tpl"}
