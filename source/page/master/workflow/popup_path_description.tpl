{include file="grn/help_head.tpl"}
{include file="grn/popup_head.tpl"}
{include file="grn/popup_header.tpl"}
<table width="100%" id="help_table">
 <tr valign="top">
  <td width="100%" id="help_view_part">
   <div class="help_text">
    <h3>{$path.col_name|escape}</h3>
{if $path.col_richeditor}
     {$path.col_description|grn_noescape}
{else}
     {grn_format body=$path.col_description}
{/if}
   </div>
  </td>
 </tr>
</table>
<div class="clear_both_1px">&nbsp;</div>
{include file="grn/popup_footer.tpl"}
