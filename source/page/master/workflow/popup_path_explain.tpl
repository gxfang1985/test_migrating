{include file="grn/help_head.tpl"}
<div class="popup_title_grn">
 <div class="float_left">
 </div>
 <a href="#" onclick="window.close();" role="button">
  <div title="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" aria-label="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" class="subWindowClose-grn"></div>
 </a>
 <div class="clear_both_0px"></div>
</div>
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
</div><!--body_end-->
