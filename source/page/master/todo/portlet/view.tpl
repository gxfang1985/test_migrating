{if $portlet.settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
    {assign var="font_size" value=''}
{elseif $portlet.settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
{/if}
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='todo/index'}">{$page_title}</a>
            </span>
        </td>
        <td align="right">
            <span>
                <a href="{grn_pageurl page='todo/add'}" class="action_base_grn">
                    <span title="{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-1' replace='true'}" class="icon_add_grn icon_only_grn">
                        <span class="courteous_element_grn">{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-1' replace='true'}</span>
                    </span>
                </a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_todo_grn">
    <form name="todo" method="post" action="{grn_pageurl page='todo/portlet/command_finish'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="pid" value="{$portlet.pid}">
        <table class="list_column" style="{$font_size}">{strip}
            <colgroup>
                <col width="1%">
                <col width="50%">
                <col width="25%">
                <col width="25%">
            </colgroup>
            <tr>
                <th nowrap></th>
                <th nowrap>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-2' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-3' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-4' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-5' replace='true'}</th>
            </tr>
            {foreach name='todo' from=$todo_list.todo item=todo}
            <tr valign="top">
                <td>{grn_checkbox name='eid[]' id='eid[]' value=$todo.tid}</td>
                {if $todo.alert > 1}
                    <td>
                        {** 期限切れ **}
                        <span class="expired_todo_grn">
                            <a href="{grn_pageurl page='todo/view' tid=$todo.tid}">
                                {$todo.title|cb_mb_truncate:$todo_list.config.subject_width|escape}
                            </a>
                        </span>
                    </td>
                {elseif $todo.alert > 0}
                    <td>
                        {** 期限当日 **}
                        <b>{grn_link page='todo/view' caption=$todo.title tid=$todo.tid truncated_caption=$todo_list.config.subject_width br=true}</b>
                    </td>
                {else}
                    <td>{grn_link page='todo/view' caption=$todo.title tid=$todo.tid truncated_caption=$todo_list.config.subject_width br=true}</td>
                {/if}
                <td>{$todo.category|cb_mb_truncate:$todo_list.config.truncate_width|escape:"html"}</td>
                <td>
                    {if $todo.ldate}
                        {grn_date_format date=$todo.ldate format=$todo.ldate_format}
                    {else}
                        {cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-6' replace='true'}
                        {/if}
                </td>
                <td>
                    {* priorityマーク取得 *}{include file='todo/_display_priority.tpl' priority=$todo.priority}
                </td>
            </tr>
            {/foreach}
            {if $smarty.foreach.todo.total}
            <tr>
                <td colspan="5">
                    <div class="mTop3 mBottom5">
                        <span class="aButtonStandard-grn">
                            <a href="javascript:void(0)" onclick="jQuery(this).parents('form').submit();return false;">
                                <span>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-12' replace='true'}</span>
                            </a>
                        </span>
                    </div>
                </td>
            </tr>
            {/if}
        </table>{/strip}
    </form>
</div> <!--end of portal_frame -->
