{strip}
{if $content}
 {if $content.type == 'file'}
  {include file=$content.file|cat:".tpl" params=$content.params}
 {else}
  {if $content.caption|count_characters:true}
   {capture name="lc"}{$content.caption}{/capture}
  {elseif $content.caption_module && $content.caption_key}
   {capture name="lc"}{cb_msg module=$content.caption_module key=$content.caption_key}{/capture}
  {else}
   {capture name="lc"}{grn_cellular_appname app_id=$app_id no_icon=1 no_escape=1}{/capture}
  {/if}
  {grn_cellular_link page=$content.page caption=$smarty.capture.lc icon=$content.icon params=$content.params accesskey=$accesskey}<br>
 {/if}
{/if}
{/strip}
