{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='todo'}<br>
{cb_msg module='grn.todo.cellular' key="todo_list_title"}<br>
<hr>

{grn_cellular_link page="$pagepath/add" accesskey="1" caption_module='grn.todo.cellular' caption_key="todo_list_regist"}<br>
{if count($todo_list)}
    <hr>
    {foreach from=$todo_list key=todokey item=todos}
        {if $todokey != 'null'}
	{$todokey}
            {*grn_date_format date=$todokey format="DateShort_MDW"*}<br>
        {else}
            {cb_msg module='grn.todo.cellular' key="todo_no_deadline"}<br>
        {/if}
        {foreach from=$todos item=todo}
            &nbsp;&nbsp;
            {grn_cellular_link page="$pagepath/look" tid=$todo.tid caption=$todo.title truncated_caption=$width sp=$sp}
            {if $todo.priority == 2}
                {cb_msg module='grn.todo.cellular' key="todo_importance_star3"}
            {elseif $todo.priority == 1}
                {cb_msg module='grn.todo.cellular' key="todo_importance_star2"}
            {else}
                {cb_msg module='grn.todo.cellular' key="todo_importance_star1"}
            {/if}
            <br>
        {/foreach}
    {/foreach}
    {if $navi}
        <br>
        {if $navi.prev != -1}
            {grn_cellular_link page="$pagepath/list" sp=$navi.prev caption_module='grn.cellular.common' caption_key="link_back"}&nbsp;
        {/if}
        {if $navi.next != -1}
            {grn_cellular_link page="$pagepath/list" sp=$navi.next caption_module='grn.cellular.common' caption_key="link_next"}
         {/if}
    {/if}
{/if}

<hr>

{/strip}
{include file="cellular/footer.tpl"}

