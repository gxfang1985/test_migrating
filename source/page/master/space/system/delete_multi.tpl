{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{if count($deletingSpaceList) == 0}
 <p>
{cb_msg module='grn.space.system' key='delete_multi-1' replace='true'}
</p>
{else}
    <p>{cb_msg module='grn.space.system' key='delete_multi-2' replace='true'}<br>
    {cb_msg module='grn.space.system' key='delete_multi-3' replace='true'}<span class="bold">{grn_sentence image='folder20.gif' caption=$category->getCategoryName()|escape}</span><br>
    {cb_msg module='grn.space.system' key='delete_multi-4' replace='true'}<span class="bold delete_count">{$deletingSpaceList|@count}</span>
    </p>        
  
 {foreach from=$deletingSpaceList item=spaceId}
<input type="hidden" name="spid[]" value="{$spaceId}">
 {/foreach}
<input type="hidden" name="cid" value="{$category->getId()|escape}">
{/if}

 <p>
  {capture name='tmp'}{cb_msg module="fw.ui" key="yes"}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.tmp}
  {capture name='tmp'}{cb_msg module="fw.ui" key="no"}{/capture}{grn_button_cancel caption=$smarty.capture.tmp}
 </p>
 
</form>
{include file="grn/system_footer.tpl"}
