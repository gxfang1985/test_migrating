{include file="grn/head.tpl"}
{include file='grn/header_no_siteposition.tpl'}

{include file='todo/_title_search.tpl'}
<div class="mainarea">
<!--delete-->
{grn_delete title=$delete_all_info.title page=$delete_all_info.page no_confirm=$delete_all_info.no_confirm data=$delete_all_info.data handler=$delete_all_info.handler}
{grn_delete title=$delete_multi_info.title page=$delete_multi_info.page no_confirm=$delete_multi_info.no_confirm data=$delete_multi_info.data handler=$delete_multi_info.handler multi_target=$delete_multi_info.multi_target form_target=$delete_multi_info.form_target}
<!--delete-->
{assign var="form_name" value=$smarty.template|basename}
 <!--menubar-->
 <div id="main_menu_part">
  <span class="menu_item">{capture name='grn_todo_GRN_TOD_97'}{cb_msg module='grn.todo' key='GRN_TOD-97' replace='true'}{/capture}{grn_link page='todo/add' caption=$smarty.capture.grn_todo_GRN_TOD_97 image='todo20.gif' disabled=TRUE}</span>
  <span class="menu_item">{capture name='grn_todo_GRN_TOD_98'}{cb_msg module='grn.todo' key='GRN_TOD-98' replace='true'}{/capture}{grn_link page='todo/category_set' caption=$smarty.capture.grn_todo_GRN_TOD_98 image='category20.gif' disabled=TRUE}</span>
  <span class="menu_item">{capture name='grn_todo_GRN_TOD_99'}{cb_msg module='grn.todo' key='GRN_TOD-99' replace='true'}{/capture}{grn_link page='todo/history_delete_all' caption=$smarty.capture.grn_todo_GRN_TOD_99 image='delete20.gif' id='lnk_delete_all' script='javascript:void(0);'}</span>
 </div>
 <!--menubar_end-->

 <!--tab-->
 <div class="tab_menu">
  <div class="tab">
   <span class="tab_left_on"></span>
   <span class="tab_on">
    <span class="todolist20">{cb_msg module='grn.todo' key='GRN_TOD-79' replace='true'}</span>
   </span>
   <span class="tab_right_on"></span>
  </div>
  {if $isActiveSharedTodo}
  <div class="tab">
   <span class="tab_left_off"></span>
   <span class="tab_off"><a href="{grn_pageurl page='todo/shared'}">{cb_msg module='grn.todo' key='GRN_TOD-80' replace='true'}</a></span>
   <span class="tab_right_off"></span>
  </div>
  {/if}
 </div>
 <div class="tab_menu_end">&nbsp;</div>
 <!--tab_end-->

<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">
<table style="width:100%">
 <tr valign="top">
  <td id="tree_part">
   <a href="{grn_pageurl page='todo/index'}" style="padding-left:5px;margin-right:15px;">{cb_msg module='grn.todo' key='GRN_TOD-101' replace='true'}</a>
   <span class="hilight">
     <span class="bold">
       <a href="{grn_pageurl page='todo/history'}">{cb_msg module='grn.todo' key='GRN_TOD-102' replace='true'}</a>
     </span>
   </span>
   <div class="border-partition-common-grn"></div>
   <!--tree_structure-->
   {include file="todo/_category_structure.tpl"}
   <!--tree_structure_end-->
  </td>
  <td id="view_part" width="70%">
    <form name="{$form_name}" method="post" action="{grn_pageurl page='todo/history_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
      <input type="hidden" name="cid" value="{$category.cid}">
  <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$todo_list.navi}</nobr></div>
  <div class="list_menu">
  <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>  
  <span class="list_menu_item">{capture name='grn_todo_GRN_TOD_103'}{cb_msg module='grn.todo' key='GRN_TOD-103' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_todo_GRN_TOD_103 onclick="return false;" id='btn_delete_multi1'}</span>  
  </div>
   <table class="list_column">
    <colgroup>
     <col width="1%">
     <col width="30%">
     <col width="25%">
     <col width="25%">
     <col width="15%">
    </colgroup>
    <tr>
     <th nowrap>&nbsp;</th>
     <th nowrap>{cb_msg module='grn.todo' key='GRN_TOD-104' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.todo' key='GRN_TOD-105' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.todo' key='GRN_TOD-106' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.todo' key='GRN_TOD-107' replace='true'}</th>
    </tr>
{foreach from=$todo_list.todo item=todo}
    <tr class="{cycle values='linetwo,lineone'}">
     <td nowrap><input type="checkbox" name="eid[]" value="{$todo.tid}"></td> 
     <td nowrap>{grn_link page='todo/history_view' caption=$todo.title tid=$todo.tid cid=$category.cid truncated_caption=$config.subject_width}</td>
     <td nowrap>{$todo.category|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
     <td nowrap>{grn_date_format date=$todo.fdate format=$todo.fdate_format}</td>
     <td nowrap>{* priorityマーク取得 *}{include file='todo/_display_priority.tpl' priority=$todo.priority}</td>
    </tr>
{/foreach}
   </table>
{literal}
<script language="JavaScript" text="text/javascript"><!--
function on_delete( f, ename )
{
    if( ! grn_is_checked( f, ename ) ) return false;
    return true;
}
//--></script>
{/literal}
  <div class="list_menu">
  <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>  
  <span class="list_menu_item">{capture name='grn_todo_GRN_TOD_111'}{cb_msg module='grn.todo' key='GRN_TOD-111' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_todo_GRN_TOD_111 onclick="return false;" id='btn_delete_multi2'}</span>  
  </div>
  <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$todo_list.navi}</nobr></div>
 </form>
  </td>
 </tr>
</table>
</td></tr></tbody></table><!--end of maincontents_list-->

{include file="grn/footer.tpl"}
