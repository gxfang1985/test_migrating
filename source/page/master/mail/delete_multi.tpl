<form name="mail/delete_multi" method="post" action="{grn_pageurl page='mail/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
{if $category.type neq '4'}
 {if $use_garbagebox eq '1'}
   {cb_msg module='grn.mail' key='GRN_MAIL-211' replace='true'}<br>
 {else}
   {cb_msg module='grn.mail' key='GRN_MAIL-212' replace='true'}<br>
 {/if}
{else}
  {cb_msg module='grn.mail' key='GRN_MAIL-213' replace='true'}<br>
{/if}
<br>
{if ! $search}
  {cb_msg module='grn.mail' key='GRN_MAIL-214' replace='true'}<span class="bold">{grn_mail_get_folder_name folder_id=$category.cid}</span><br>
{/if}
  {cb_msg module='grn.mail' key='GRN_MAIL-215' replace='true'}<span class="bold delete_count"></span><br>
 </p>

{if $category.type neq "4"}
<input type="hidden" name="cmd" value="move">
{else}
<input type="hidden" name="cmd" value="delete">
{/if}
<input type="hidden" name="aid" value="{$category.aid}">
<input type="hidden" name="cid" value="{$category.cid}">
</form>