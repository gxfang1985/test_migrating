{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="grn/html/page/space/todo/todo_edit.js"}
{grn_load_javascript file="grn/html/page/space/todo/todo.js"}
{literal}
<script language="JavaScript" text="text/javascript">
(function()
{
    var G = grn.page.space.todo.todo_edit;
    var T = grn.page.space.todo.todo;
    G.ERRMSG_TITLE_IS_REQUIRED = '{/literal}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-2' replace='true'}{literal}';
    G.ERRMSG_INVALID_START_DATE = '{/literal}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-21' replace='true'}{literal}';
    T.spinnerImage = "{/literal}{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}{literal}";
    T.form = "{/literal}{$form_name}{literal}";
    T.spaceId = "{/literal}{$space_id}{literal}";
    T.todoId = "{/literal}{$todo_id}{literal}";
    T.pageurl = "{/literal}{grn_pageurl page='space/application/todo/ajax/todo_search_user'}{literal}";
})();
</script>
{/literal}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='space/application/todo/command_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
 <div class="explanation">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-9' replace='true'}</div>
</p>
<input type='hidden' name='spid' value="{$space_id}">
<input type='hidden' name='tdid' value="{$todo_id}">
<input type='hidden' name='from' value="{$from}">
<input type='hidden' name='tid' value="{$thread_id}" id="tid_todo">
{include file="grn/show_validation_errors.tpl"}
<div id="FieldToShowErrorMessage"></div>
{include file='grn/indispensable.tpl'}
 <table class="std_form space-todo-table-grn">
  <tr>
   <th width="15%">{capture name='grn_space_GRN_SP_TOD_1'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-1' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_GRN_SP_TOD_1 necessary=TRUE}</th>
   <td>{capture name='grn_space_GRN_SP_TOD_2'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-2' replace='true'}{/capture}{grn_text name='title' value=$title size='50' disable_return_key=true}</td>
  </tr>
  <tr>
   <th width="15%">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-3' replace='true'}</th>
   <td>
   {include file="space/application/todo/_todo_date.tpl" form_name=$form_name start_date=$start_date end_date=$end_date}
   </td>
  </tr>
  <tr valign="top">
    <th width="15%">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-4' replace='true'}</th>
    <td>
     {grn_member_add name                   = 'todo_assignees'
                     form_name              = $form_name
                     app_id                 = 'space'
                     search_box_options     = $todo_search_box_options
                     pulldown_parts_options = $todo_pulldown_parts_options
                     order_parts_options    = $todo_order_parts_options
                     sUID                   = 'todo_sUID'
                     CID                    = 'todo_CID'
                     selected_users         = $selected_users_info
                     candidate_users        = $users_info
     }
    </td>
  </tr>
  <tr valign="top">
   <th width="15%">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-5' replace='true'}</th>
   <td>{grn_textarea name='memo' value=$memo rows='5' style= 'width:100%;'}</td>
  </tr>
  <tr>
   <th width="15%">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-6' replace='true'}</th>
   <td>
      {include file="grn/attach_file.tpl" attached_files=$attach_files}
   </td>
  </tr>
  <tr>
    <td></td>
    <td>
      <div class="mTop7">
        {capture name='grn_space_todo_GRN_SP_TOD_80'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-80' replace='true'}{/capture}
        {grn_checkbox name='status_initialize' id='status_initialize' value='1' caption=$smarty.capture.grn_space_todo_GRN_SP_TOD_80 span_cover="1"}
      </div>
    </td>
  </tr>
  <tr>
   <td></td>
   <td>
       <div class="mTop10">
           {strip}
               {capture name="grn_space_todo_GRN_SP_TOD_11"}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-11' replace='true'}{/capture}
               {grn_button id='buttonSubmit' auto_disable=true ui='main' caption=$smarty.capture.grn_space_todo_GRN_SP_TOD_11 spacing='normal'}
               {grn_button action='cancel' page=$cancel_page page_param_spid=$space_id page_param_tdid=$todo_id page_param_from=$from }
           {/strip}
       </div>
   </td>
  </tr>
 </table>
</form>
<script>
    grn.page.space.todo.todo_edit.init('buttonSubmit', '{$form_name}')
</script>
