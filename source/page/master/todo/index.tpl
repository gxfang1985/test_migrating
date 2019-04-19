{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='todo/_title_search.tpl'}
<div class="mainarea">
    {assign var='form_name' value=$smarty.template|basename}
    <form name="{$form_name}" method="post" action="{grn_pageurl page='todo/command_'|cat:$page_info.last}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="cid" value="{$category.cid}">

        <!--menubar-->
        <div id="main_menu_part">
            <span class="menu_item">{capture name='grn_todo_GRN_TOD_77'}{cb_msg module='grn.todo' key='GRN_TOD-77' replace='true'}{/capture}{grn_link page='todo/add' caption=$smarty.capture.grn_todo_GRN_TOD_77 image='todo20.gif' cid=$category.cid element_id="todo-add"}</span>
            <span class="menu_item">{capture name='grn_todo_GRN_TOD_78'}{cb_msg module='grn.todo' key='GRN_TOD-78' replace='true'}{/capture}{grn_link page='todo/category_set' caption=$smarty.capture.grn_todo_GRN_TOD_78 image='category20.gif' element_id='category-add'}</span>
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

        <table class="maincontents_list">
            <tbody>
                <tr>
                    <td class="maincontents_list_td">
                        <table style="width:100%">
                            <tr valign="top">
                                <td id="tree_part">
                                    <span style="padding-left:5px;margin-right:15px;" class="hilight">
                                        <span class="bold">
                                            <a href="{grn_pageurl page='todo/index'}">{cb_msg module='grn.todo' key='GRN_TOD-101' replace='true'}</a>
                                        </span>
                                    </span>
                                    <a href="{grn_pageurl page='todo/history'}">{cb_msg module='grn.todo' key='GRN_TOD-102' replace='true'}</a>
                                    <div class="border-partition-common-grn"></div>

                                    <!--tree_structure-->
                                    {include file="todo/_category_structure.tpl"}
                                    <!--structure_end-->
                                </td>
                                <td id="view_part" width="70%">
                                    <div class="list_menu">
                                        <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>  
                                        <span class="list_menu_item">{capture name='grn_todo_GRN_TOD_81'}{cb_msg module='grn.todo' key='GRN_TOD-81' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_todo_GRN_TOD_81 onclick="if(! grn_is_checked(this.form,'eid[]')) return false;"}</span>  
                                    </div>

                                    <table class="list_column">
                                        <colgroup>
                                            <col width="1%">
                                            <col width="35%">
                                            <col width="25%">
                                            <col width="25%">
                                            <col width="15%">
                                        </colgroup>
                                        <tr valign="top">
                                            <th nowrap></th>
                                            <th nowrap><div style="padding-top: 2px;">{cb_msg module='grn.todo' key='GRN_TOD-82' replace='true'}</div></th>
                                            {if $sort == 'ctu'}
                                                <th nowrap>{capture name='grn_todo_GRN_TOD_83'}{cb_msg module='grn.todo' key='GRN_TOD-83' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_todo_GRN_TOD_83 page=$page_info.all cid=$category_id sort='ctd' sp=0 reverse=1}</th>
                                            {else}
                                                {if $sort == 'ctd'}
                                                    <th nowrap>{capture name='grn_todo_GRN_TOD_84'}{cb_msg module='grn.todo' key='GRN_TOD-84' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_todo_GRN_TOD_84 page=$page_info.all cid=$category_id sort='ctu' sp=0}</th>
                                                {else}
                                                    <th nowrap>{capture name='grn_todo_GRN_TOD_85'}{cb_msg module='grn.todo' key='GRN_TOD-85' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_todo_GRN_TOD_85 page=$page_info.all cid=$category_id sort='ctd' sp=0 reverse=1 disable=1}</th>
                                                {/if}
                                            {/if}

                                            {if $sort == 'epu'}
                                                <th nowrap>{capture name='grn_todo_GRN_TOD_86'}{cb_msg module='grn.todo' key='GRN_TOD-86' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_todo_GRN_TOD_86   page=$page_info.all cid=$category_id sort='epd' sp=0 reverse=1}</th>
                                            {else}
                                                {if $sort == 'epd'}
                                                    <th nowrap>{capture name='grn_todo_GRN_TOD_87'}{cb_msg module='grn.todo' key='GRN_TOD-87' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_todo_GRN_TOD_87   page=$page_info.all cid=$category_id sort='epu' sp=0}</th>
                                                {else}
                                                    <th nowrap>{capture name='grn_todo_GRN_TOD_88'}{cb_msg module='grn.todo' key='GRN_TOD-88' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_todo_GRN_TOD_88   page=$page_info.all cid=$category_id sort='epd' sp=0 reverse=1 disable=1}</th>
                                                {/if}
                                            {/if}

                                            {if $sort == 'pru'}
                                                <th nowrap>{capture name='grn_todo_GRN_TOD_89'}{cb_msg module='grn.todo' key='GRN_TOD-89' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_todo_GRN_TOD_89   page=$page_info.all cid=$category_id sort='prd' sp=0 reverse=1}</th>
                                            {else}
                                                {if $sort == 'prd'}
                                                    <th nowrap>{capture name='grn_todo_GRN_TOD_90'}{cb_msg module='grn.todo' key='GRN_TOD-90' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_todo_GRN_TOD_90   page=$page_info.all cid=$category_id sort='pru' sp=0}</th>
                                                {else}
                                                    <th nowrap>{capture name='grn_todo_GRN_TOD_91'}{cb_msg module='grn.todo' key='GRN_TOD-91' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_todo_GRN_TOD_91   page=$page_info.all cid=$category_id sort='prd' sp=0 reverse=1 disable=1}</th>
                                                {/if}
                                            {/if}
                                        </tr>

                                        {foreach from=$todo_list.todo item=todo}
                                            <tr class="{cycle values='linetwo,lineone'}">
                                                <td nowrap>{grn_checkbox name='eid[]' id='eid[]' value=$todo.tid}</td>
                                                {if $todo.alert > 1}
                                                    <td><span class="nowrap-grn"><a href="{grn_pageurl page='todo/view' tid=$todo.tid}"><span class="expired_todo_grn">{$todo.title|cb_mb_truncate:$config.subject_width|escape}</span></a></span></td> {** 期限切れ **}
                                                {elseif $todo.alert > 0}
                                                    <td><b>{grn_link page='todo/view' caption=$todo.title tid=$todo.tid truncated_caption=$config.subject_width}</b></td> {** 期限当日 **}
                                                {else}
                                                    <td>{grn_link page='todo/view' caption=$todo.title tid=$todo.tid truncated_caption=$config.subject_width}</td>
                                                {/if}
                                                <td nowrap>{$todo.category|cb_mb_truncate:$config.truncate_width|escape:"html"}</td>
                                                <td nowrap>{if $todo.ldate}{grn_date_format date=$todo.ldate format=$todo.ldate_format}{else}{cb_msg module='grn.todo' key='GRN_TOD-92' replace='true'}{/if}</td>
                                                <td nowrap>{* priorityマーク取得 *}{include file='todo/_display_priority.tpl' priority=$todo.priority}</td>
                                            </tr>
                                        {/foreach}
                                    </table>

                                    <div class="list_menu">
                                        <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>  
                                        <span class="list_menu_item">{capture name='grn_todo_GRN_TOD_96'}{cb_msg module='grn.todo' key='GRN_TOD-96' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_todo_GRN_TOD_96 onclick="if(! grn_is_checked(this.form,'eid[]')) return false;"}</span>  
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>

<!--end of maincontents_list-->

{include file='grn/footer.tpl'}
