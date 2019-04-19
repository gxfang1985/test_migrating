{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='todo/_title_search.tpl'}
<div class="mainarea">
    {assign var='form_name' value=$smarty.template|basename}
    <form name="{$form_name}" method="post" action="{grn_pageurl page='todo/command_'|cat:$page_info.last}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

        <!--tab-->
        <div class="tab_menu">
            <div class="tab">
                <span class="tab_left_off"></span>
                <span class="tab_off">
                    <a href="{grn_pageurl page='todo/index'}">{cb_msg module='grn.todo' key='GRN_TOD-79' replace='true'}</a></span>
                </span>
                <span class="tab_right_off"></span>
            </div>
            <div class="tab">
            <span class="tab_left_on"></span>
            <span class="tab_on">
                <span class="todo20_f">{cb_msg module='grn.todo' key='GRN_TOD-80' replace='true'}</span>
            </span>
            <span class="tab_right_on"></span>
        </div>
    </div>
    <div class="tab_menu_end">&nbsp;</div>
    <!--tab_end-->
    
    <table class="maincontents_list maincontents_list_1pane_grn">
        <tbody>
            <tr>
                <td class="maincontents_list_td">
                    <table style="width:100%">
                        <tr valign="top">
                            <td id="view_part">
                                <div class="list_menu">
                                    <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>
                                    <span class="list_menu_item">{capture name='grn_todo_GRN_TOD_81'}{cb_msg module='grn.todo' key='GRN_TOD-81' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_todo_GRN_TOD_81 onclick="if( ! grn_is_checked(this.form,'eid[]')) return false;"}</span>
                                </div>

                                <table class="list_column">
                                    <colgroup>
                                        <col width="1%">
                                        <col width="40%">
                                        <col width="40%">
                                        <col width="20%">
                                    </colgroup>
                                    <tr>
                                        <th nowrap></th>
                                        <th nowrap>{cb_msg module='grn.todo' key='GRN_TOD-82' replace='true'}</th>
                                        <th nowrap>{cb_msg module='grn.todo' key='GRN_TOD-113' replace='true'}</th>
                                        <th nowrap>{cb_msg module='grn.todo' key='GRN_TOD-114' replace='true'}</th>
                                    </tr>
                                    {foreach from=$todo_list.todo item=todo}
                                        <tr class="{cycle values='linetwo,lineone'}">
                                            <td nowrap>{grn_checkbox name='eid[]' id='eid[]' value=$todo.id}</td>
                                                {if $todo.status == 'late'}
                                                    <td><span class="nowrap-grn"><a href="{grn_pageurl page='space/application/todo/view' spid=$todo.spid tdid=$todo.id from=$from_todo_index}"><span class="expired_todo_grn">{$todo.title|cb_mb_truncate:$config.subject_width|escape}</span></a></span></td>
                                                {elseif $todo.status == 'today'}
                                                    <td><b>{grn_link page='space/application/todo/view' caption=$todo.title spid=$todo.spid tdid=$todo.id from=$from_todo_index truncated_caption=$config.subject_width}</b></td>
                                                {else}
                                                    <td>{grn_link page='space/application/todo/view' caption=$todo.title spid=$todo.spid tdid=$todo.id from=$from_todo_index truncated_caption=$config.subject_width}</td>
                                                {/if}
                                            <td nowrap>{grn_link page='space/top' caption=$todo.space_title spid= $todo.spid truncated_caption=$config.subject_width}</td>
                                            <td nowrap>{if $todo.deadline_date != null}{grn_date_format date=$todo.deadline_date format='DateShort_MD'}{else}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-42' replace='true'}{/if}</td>
                                        </tr>
                                    {/foreach}
                                </table>
                                <div class="list_menu">
                                    <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name="eid[]"}</span>
                                    <span class="list_menu_item">{capture name='grn_todo_GRN_TOD_96'}{cb_msg module='grn.todo' key='GRN_TOD-96' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_todo_GRN_TOD_96 onclick="if( ! grn_is_checked(this.form,'eid[]')) return false;"}</span>
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
