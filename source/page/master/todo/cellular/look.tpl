{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='todo'}<br>
{cb_msg module='grn.todo.cellular' key="todo_look_title"}<br>
<hr>

{grn_cellular_pictogram key="clip"}
{cb_msg module='grn.todo.cellular' key="todo_category"}<br>

{$todo_data.category|escape}<br>

{grn_cellular_pictogram key="loupe"}
{cb_msg module='grn.todo.cellular' key="todo_name"}<br>
{$todo_data.title|escape}<br>


{grn_cellular_pictogram key="end"}
{cb_msg module='grn.todo.cellular' key="todo_deadline"}<br>

{if $todo_data.ldate}
    {grn_date_format date=$todo_data.ldate format=$todo_data.ldate_format}
{else}
    {cb_msg module='grn.todo.cellular' key="todo_no_deadline"}
{/if}
<br>


{grn_cellular_pictogram key="importance"}
{cb_msg module='grn.todo.cellular' key="todo_importance"}<br>

{if $todo_data.priority=="2"}
    {cb_msg module='grn.todo.cellular' key="todo_importance_star3"}
{elseif $todo_data.priority=="1"}
    {cb_msg module='grn.todo.cellular' key="todo_importance_star2"}
{else}
    {cb_msg module='grn.todo.cellular' key="todo_importance_star1"}
{/if}
<br>




{grn_cellular_pictogram key="memo"}
{cb_msg module='grn.todo.cellular' key="todo_memo"}<br>

{grn_cellular_string_split string=$todo_data.memo page_paraname="bp"}<BR>

{grn_cellular_form method=post page="$pagepath/command_finish" tid=$todo_data.tid}
{grn_cellular_submit accesskey=1 caption_module='grn.todo.cellular' caption_key="todo_finish_button"}
</form>

<hr>

{grn_cellular_link page="$pagepath/list" accesskey="2" caption_module='grn.todo.cellular' caption_key="todo_list_title" sp=$sp}<br>

{/strip}
{include file="cellular/footer.tpl"}
