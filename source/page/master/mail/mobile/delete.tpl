<form name="mail/mobile/delete" id="mail_mobile_delete" method="post" action="{grn_pageurl page='mail/mobile/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" name="aid" value="{$aid}">
  <input type="hidden" name="cid" value="{$cid}">
  <input type="hidden" name="mid" value="{$mid}">
  <input type="hidden" name="sp" value="{$sp}">
</form>
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
  {cb_msg module='grn.mail' key='GRN_MAIL-273' replace='true'}
{/capture}
{capture name="titlecontent"}
  {$subject|grn_noescape}
{/capture}
{include file='grn/mobile_delete.tpl' form_id='mail_mobile_delete'}
