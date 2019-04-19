{if $portlet.settings.font_size == 'large'}
    {assign var='font_size' value='font-size:140%;'}
{elseif $portlet.settings.font_size == 'normal'}
    {assign var='font_size' value=''}
{elseif $portlet.settings.font_size == 'small'}
    {assign var='font_size' value='font-size:70%;'}
{/if}

<table class='top_title'>{strip}
    <tbody>
    <tr>
        <td>
            <span class='portlet_title_grn'>
                {if $todo_type == 'grn.space.todo.undertake' && $todo_application_status}
                    <a href='{grn_pageurl page="todo/shared"}'>{$page_title}</a>
                {else}
                    {$page_title}
                {/if}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class='portal_frame {if $todo_type == "grn.space.todo.undertake"}portal_frame_space_todo_undertake_grn{else}portal_frame_space_todo_rely_grn{/if}'>
    <table class='list_column' style='{$font_size}'>{strip}
            <colgroup>
                <col width='50%'>
                <col width='25%'>
                <col width='25%'>
            </colgroup>
            <tr>
                <th nowrap>{cb_msg module='grn.space.portlet' key='GRN_SP_TOD_PO-2' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.space.portlet' key='GRN_SP_TOD_PO-1' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.space.portlet' key='GRN_SP_TOD_PO-3' replace='true'}</th>
            </tr>
            {foreach from=$todo_list item=todo}
                <tr valign='top'>
                    <td>
                        <a href='{grn_pageurl page="space/application/todo/view" spid=$todo.spid tdid=$todo.id}'>
                        <span {if $todo.status == 'late'} class='expired_todo_grn' {elseif $todo.status == 'today'} class='bold_grn'{/if}>
                            {$todo.title|cb_mb_truncate:$width|escape}
                        </span>
                        </a>
                    </td>
                    <td>{grn_link page='space/top' caption=$todo.space_title spid= $todo.spid truncated_caption=$width}</td>
                    <td>{if $todo.deadline_date != null}{grn_date_format date=$todo.deadline_date format='DateShort_MD'}{else}{cb_msg module='grn.space.portlet' key='GRN_SP_TOD_PO-4' replace='true'}{/if}</td>
                </tr>
            {/foreach}
        {/strip}</table>
</div>