<form name="mail/mobile/delete_multi" id="mail_mobile_delete_multi" method="post" action="{grn_pageurl page='mail/mobile/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{capture name="message"}
{if $category.type neq '4'}
  {if $use_garbagebox}
    {cb_msg module='grn.mail' key='GRN_MAIL-211' replace='true'}
  {else}
    {cb_msg module='grn.mail' key='GRN_MAIL-212' replace='true'}
  {/if}
{else}
  {cb_msg module='grn.mail' key='GRN_MAIL-213' replace='true'}
{/if}
{/capture}
{capture name="title"}
  {cb_msg module='grn.mail' key='GRN_MAIL-214' replace='true'}
{/capture}
{capture name="titlecontent"}
  {$folder_name|grn_noescape}
{/capture}
{capture name="count_text"}
  {cb_msg module='grn.mail' key='GRN_MAIL-215' replace='true'}
{/capture}
{include file='grn/mobile_delete_popup.tpl'}
<input type="hidden" name="aid" value="{$aid}">
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" id="use_ajax" name="use_ajax" value="1">
</form>