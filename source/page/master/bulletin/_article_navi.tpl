{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}
{if $sp}
 {math assign="sp" equation="x - 1" x=$sp}
{/if}

{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page fsp=$sp sp=0 params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.bulletin' key='GRN_BLLT-405' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.bulletin' key='GRN_BLLT-406' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page fsp=$sp sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">&lt;&lt;{cb_msg module='grn.bulletin' key='GRN_BLLT-407' replace='true'} {$navi.number_on_page} {cb_msg module='grn.bulletin' key='GRN_BLLT-408' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.bulletin' key='GRN_BLLT-409' replace='true'} {$navi.number_on_page} {cb_msg module='grn.bulletin' key='GRN_BLLT-410' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href="{grn_pageurl page=$page fsp=$sp sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.bulletin' key='GRN_BLLT-411' replace='true'} {$navi.number_on_page} {cb_msg module='grn.bulletin' key='GRN_BLLT-412' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.bulletin' key='GRN_BLLT-413' replace='true'} {$navi.number_on_page} {cb_msg module='grn.bulletin' key='GRN_BLLT-414' replace='true'}&gt;&gt;</span>
{/if}
