{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}
{if $sp}
 {math assign="sp" equation="x - 1" x=$sp}
{/if}

{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$sp fsp=0 params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.bulletin' key='GRN_BLLT-219' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.bulletin' key='GRN_BLLT-220' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$sp fsp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">&lt;&lt;{cb_msg module='grn.bulletin' key='GRN_BLLT-221' replace='true'} {$navi.number_on_page} {cb_msg module='grn.bulletin' key='GRN_BLLT-222' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.bulletin' key='GRN_BLLT-223' replace='true'} {$navi.number_on_page} {cb_msg module='grn.bulletin' key='GRN_BLLT-224' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$sp fsp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.bulletin' key='GRN_BLLT-225' replace='true'} {$navi.number_on_page} {cb_msg module='grn.bulletin' key='GRN_BLLT-226' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.bulletin' key='GRN_BLLT-227' replace='true'} {$navi.number_on_page} {cb_msg module='grn.bulletin' key='GRN_BLLT-228' replace='true'}&gt;&gt;</span>
{/if}
