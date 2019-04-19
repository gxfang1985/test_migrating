{if $threads|@count > 0}
<colgroup>
    <col width="1%">
    <col width="99%">
</colgroup>
<tr>
    <th class="navi" nowrap></th>
    <th nowrap>{cb_msg module='grn.space' key='move_discussion-10' replace='true'}</th>
</tr>
    {foreach from=$threads item=thread name="thread_loop"}
    <tr class="{if $smarty.foreach.thread_loop.iteration % 2 == 0}lineone{else}linetwo{/if}" id="discussion_list-row_{$thread->getId()}">
        <td nowrap>
            <input id="item_{$thread->getId()}" type="checkbox" name="ids[]" value="{$thread->getId()}" />
        </td>
        <td>
            <a href="{grn_pageurl page='space/top' spid=$spaceId}#tid={$thread->getId()}" id="thread_{$thread->getId()}" class="{$class_name}">{$thread->getTitle()|escape}</a>
        </td>
    </tr>
    {/foreach}
{/if}