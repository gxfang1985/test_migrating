{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/page/space/mobile/todo/index.js"}
{grn_load_javascript file="grn/html/page/space/mobile/todo/detail.js"}
<script language="JavaScript" text="text/javascript">
(function(){literal}{{/literal}
    var D = grn.page.space.mobile.todo.detail;
    D.spinnerImage = '{$app_path}/grn/image/cybozu/image-mobile/spinner.gif?{$build_date}';
    D.complete_url = '{grn_pageurl page="space/mobile/application/todo/ajax/command_complete"}';

    var G = grn.component.define_cybozu_browser;
    G.addToolBarItem(
            "my_space", "{cb_msg module='grn.kunai' key='GRN_KUNAI-1' replace='true'}",
            '{grn_pageurl page="space/mobile/index"}'
    );
    {if $todo_write_auth}
    G.addToolBarItem(
            "todo_add", "{cb_msg module='grn.kunai' key='GRN_KUNAI-3' replace='true'}",
            '{grn_pageurl page="space/mobile/application/todo/add" spid=$space_id tid=$thread_id}'
    );
    {/if}
    G.addToolBarItem(
            "member_view", "{cb_msg module='grn.kunai' key='GRN_KUNAI-6' replace='true'}",
            '{grn_pageurl page="space/mobile/member_list" spid=$space_id}'
    );
{literal}}{/literal})();
</script>
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn mobile-content-hidden-grn">
  {include file='grn/mobile_breadcrumb.tpl' not_need_withList=false is_space=true}
  {grn_space_show_expiration_date_warning space=$space is_mobile=true}
  <div class="mobile-tab-grn">
    {strip}
    <div class="mobile_left_grn mobile_unselected_grn">
      <a data-ajax="false" href="{grn_pageurl page='space/mobile/application/discussion/index' spid=$space_id}">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-45' replace='true'}</a>
    </div>
      <div class="mobile_right_grn mobile_selected_grn"><span>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-72' replace='true'}</span></div>
    {/strip}
  </div>
  <div class="mobile_separation_line_grn"></div>
  <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile-ul-withBtn-grn">
    <li>
      <div class="mobile-todoFilter-grn" id="mobile_todoFilter_div">
        <a href="{grn_pageurl page='space/mobile/application/todo/filter' spid=$space_id tid=$thread_id}" data-role="button" data-theme="{$data_theme}" class="mobile-btn-left-grn">
          <span class="mobile-icon-filter-grn"></span>
        </a>
        <span class="mobile-label-small-grn mobile-discussion-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-79' replace='true'}</span>
        <span class="mobile-label-discussion-grn">{if $selected_discussion}{$selected_discussion->getTitle()|escape}{else}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-38' replace='true'}{/if}</span>
      </div>
    </li>
  </ul>
  <div class="mobile-padding-leftright-grn">
    <ul data-role="listview" data-theme="{$data_theme}" id="todo_list" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile-todo-list-grn">
      {include file='space/mobile/application/todo/todo_list.tpl'}
    </ul>
    {include file='grn/mobile_list_more_view.tpl' request_page='space/mobile/application/todo/ajax/todo_list' list_id='todo_list' trigger_create=true}
  </div>
</div>