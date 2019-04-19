{include file="cellular/header.tpl"}
{strip}

{capture name=validate_empty}{cb_msg module='grn.todo.cellular' key="validate_message_empty"}<BR>{/capture}
{capture name=validate_emoji}{cb_msg module='grn.cellular.common' key="validate_message_emoji"}<BR>{/capture}
{capture name=validate_length}{cb_msg module='grn.cellular.common' key="validate_message_length"}<BR>{/capture}

{grn_cellular_appname app_id='todo'}<br>
{cb_msg module='grn.todo.cellular' key="todo_regist_title"}<br>
<hr>
{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.validate_empty}
{validate form=$form_name field="title" criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_emoji}
{validate form=$form_name field="memo"  criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_emoji}
{validate form=$form_name field="yy"  criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_emoji}
{validate form=$form_name field="mm"  criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_emoji}
{validate form=$form_name field="dd"  criteria="grn_cellular_notEmoji" message=$smarty.capture.validate_emoji}
{validate form=$form_name field="memo" criteria="grn_cellular_isLength" min=0 max=1024 message=$smarty.capture.validate_length}
{if !$valid_date}{cb_msg module='grn.todo.cellular' key="validate_date"}<BR>{/if}

{grn_cellular_form name=$form_name method=post page="$pagepath/command_add" sp=$sp}

{grn_cellular_pictogram key="clip"}
{cb_msg module='grn.todo.cellular' key="todo_category"}<br>

<select name=category>
<option value="">--</option>
{foreach from=$cat_data item=one}
    <option value="{$one.cat_id}" {if $one.cat_id == $category}selected{/if}>{$one.cat_name|escape}</option>
{/foreach}
</select>
<br>

{grn_cellular_pictogram key="loupe"}
{cb_msg module='grn.todo.cellular' key="todo_name"}
{cb_msg module='grn.todo.cellular' key="todo_essential"}<br>

<input type="text" name="title" value="{$title|escape}" istyle="1" mode="hiragana"><br>

{grn_cellular_pictogram key="end"}
{cb_msg module='grn.todo.cellular' key="todo_deadline"}<br>

{cb_msg module='grn.todo.cellular' key="todo_no_deadline"}
<input type="checkbox" name="dl" value="no_deadline" {if $no_deadline_checked}checked{/if}><br>

{cb_msg module='grn.todo.cellular' key="todo_deadline"}
<input type="text" name="yy" maxlength=4 size=4 value="{$yy}" istyle="4" mode="numeric">
<input type="text" name="mm" maxlength=2 size=2 value="{$mm}" istyle="4" mode="numeric">
<input type="text" name="dd" maxlength=2 size=2 value="{$dd}" istyle="4" mode="numeric"><br>

{grn_cellular_pictogram key="importance"}
{cb_msg module='grn.todo.cellular' key="todo_important"}<br>

<select name=priority>
<option value=2 {if $priority==2}selected{/if}>{cb_msg module='grn.todo.cellular' key="todo_importance_star3"}</option>
<option value=1 {if $priority==1}selected{/if}>{cb_msg module='grn.todo.cellular' key="todo_importance_star2"}</option>
<option value=0 {if $priority==0}selected{/if}>{cb_msg module='grn.todo.cellular' key="todo_importance_star1"}</option>
</select>
<br>

{grn_cellular_pictogram key="memo"}
{cb_msg module='grn.todo.cellular' key="todo_memo"}<br>

<TEXTAREA name=memo>{$memo|escape}</TEXTAREA><br>

<input type="hidden" name="retry" value="true">
{grn_cellular_submit accesskey=1 caption_module='grn.todo.cellular' caption_key="todo_list_regist"}
</form>

<hr>

{grn_cellular_link page="$pagepath/list" accesskey="2" caption_module='grn.todo.cellular' caption_key="todo_list_title"}<br>

{/strip}
{include file="cellular/footer.tpl"}

