{strip}
{foreach from=$params key=app_id item=notify}
 {capture name=appname}{grn_cellular_appname app_id=$app_id no_icon=1 no_escape=1}{/capture}
 {if $notify.count > 0}
  {if $notify.page_info.caption_module && $notify.page_info.caption_key}
   {capture name=wnc}{cb_msg module=$notify.page_info.caption_module key=$notify.page_info.caption_key count=$notify.count appname=$smarty.capture.appname}{/capture}
  {else}
   {capture name=wnc}{$notify.count}{cb_msg module='grn.notification.cellular' key='GRN_NTFC_CE-1' replace='true'}{$smarty.capture.appname|escape}{/capture}
  {/if}
  <a href="{grn_cellular_pageurl page='notification/cellular/list' app_id=$app_id}">
  {if $notify.page_info.icon}
      {grn_cellular_pictogram key=$notify.page_info.icon}
  {/if}
  {$smarty.capture.wnc|grn_noescape}
  </a><br>
 {/if}
{/foreach}
{/strip}
