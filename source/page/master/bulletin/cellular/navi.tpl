{strip}

{if $navi.navi.page}
 {assign var=page value=$navi.navi.page}
{else}
 {assign var=page value=$page_info.all}
{/if}

{**
{if $navi.navi.previous_page_start_position != -1}
 {capture name='grn_bulletin_cellular_GRN_BLLT_CELL_1'}{cb_msg module='grn.bulletin.cellular' key='GRN_BLLT_CELL-1' replace='true'}{/capture}{grn_cellular_link page=$page sp=0 params=$navi.navi.params caption=$smarty.capture.grn_bulletin_cellular_GRN_BLLT_CELL_1}
{else}
 {cb_msg module='grn.bulletin.cellular' key='GRN_BLLT_CELL-2' replace='true'} 
{/if}
 &nbsp;|&nbsp;
**}

{capture name='grn_bulletin_cellular_GRN_BLLT_CELL_3'}{cb_msg module='grn.bulletin.cellular' key='GRN_BLLT_CELL-3' replace='true'}{/capture}{assign var="prev_caption" value=$smarty.capture.grn_bulletin_cellular_GRN_BLLT_CELL_3}
{capture name='grn_bulletin_cellular_GRN_BLLT_CELL_4'}{cb_msg module='grn.bulletin.cellular' key='GRN_BLLT_CELL-4' replace='true'}{/capture}{assign var="next_caption" value=$smarty.capture.grn_bulletin_cellular_GRN_BLLT_CELL_4}

{if $navi.navi.previous_page_start_position != -1 || $navi.navi.next_page_start_position != -1}
 <br>
 {if $navi.navi.previous_page_start_position != -1}
  {grn_cellular_link page=$page sp=$navi.navi.previous_page_start_position params=$navi.navi.params caption=$prev_caption}
  &nbsp;
 {else}
{*
  {if $navi.navi.next_page_start_position != -1}
   {$prev_caption|escape}
   &nbsp;
  {/if}
*}
 {/if}
 
 {if $navi.navi.next_page_start_position != -1}
  {grn_cellular_link page=$page sp=$navi.navi.next_page_start_position params=$navi.navi.params caption=$next_caption}
 {else}
{*
  {if $navi.navi.previous_page_start_position != -1}
   {$next_caption|escape}
  {/if}
*}
 {/if}
 <br>
{/if}

{/strip}
