{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}
{if $sp}
{math assign="sp" equation="x - 1" x=$sp}
{/if}

{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$sp fsp=0 params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cabinet' key='GRN_CAB-1' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.cabinet' key='GRN_CAB-2' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$sp fsp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">&lt;&lt;{cb_msg module='grn.cabinet' key='GRN_CAB-3' replace='true'} {$navi.number_on_page} {cb_msg module='grn.cabinet' key='GRN_CAB-4' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.cabinet' key='GRN_CAB-5' replace='true'} {$navi.number_on_page} {cb_msg module='grn.cabinet' key='GRN_CAB-6' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$sp fsp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cabinet' key='GRN_CAB-7' replace='true'} {$navi.number_on_page} {cb_msg module='grn.cabinet' key='GRN_CAB-8' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.cabinet' key='GRN_CAB-9' replace='true'} {$navi.number_on_page} {cb_msg module='grn.cabinet' key='GRN_CAB-10' replace='true'}&gt;&gt;</span>
{/if}

