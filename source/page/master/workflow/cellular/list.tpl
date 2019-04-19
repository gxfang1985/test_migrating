{include file="workflow/cellular/header.tpl"}
{strip}

{grn_workflow_cellular_appname}<br>
{$pagetitle|escape}<br>
<hr>

{grn_workflow_cellular_form name="form" method="get" page="$pagepath/list"}
<select name="fid">
{foreach from=$folders item=item}
    <option value="{$item.fid|escape}"{if $item.fid === $current_fid} selected{/if}>
    {$item.name|escape}
    </option>
{/foreach}
</select><br>
{grn_workflow_cellular_submit name="GO" accesskey="1" caption_module='grn.workflow.cellular' caption_key="submit_move"}<br>
</form>
<br>

{if $lists}
    {foreach from=$lists key=pid item=item}
        {grn_workflow_cellular_pictogram key="memo"}
        {grn_workflow_cellular_link page="workflow/cellular/look" pid=$item.ptid fid=$current_fid caption=$item.form_name|grn_workflow_cellular_truncate:$width}<br>
        {grn_workflow_cellular_priority value=$item.priority}<br>
        {$item.petition_name|grn_workflow_cellular_truncate:$width|escape}<br>
        {cb_date_format format='DateTimeCompact' date=$item.ctime}&nbsp;{$item.view_name|escape}<br>
        {$item.status_name|escape}<br>
    {/foreach}
    
    {if $navi.previous_page_start_position != -1}
        <a href="{grn_workflow_cellular_pageurl page="$pagepath/list" sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.workflow.cellular' key="previous_list"}</a>&nbsp;
    {/if}
    {if $navi.next_page_start_position != -1}
        <a href="{grn_workflow_cellular_pageurl page="$pagepath/list" sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.workflow.cellular' key="next_list"}</a>
    {/if}
{/if}

<hr>
{grn_workflow_cellular_link page="$pagepath/search" accesskey=4 fid=$current_fid caption_module='grn.workflow.cellular' caption_key="search"}<br>

{/strip}
{include file="workflow/cellular/footer.tpl"}
