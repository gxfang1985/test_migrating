{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}
{if $sp}
{math assign="sp" equation="x - 1" x=$sp}
{/if}

{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page fsp=$sp sp=0 params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cabinet' key='GRN_CAB-39' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.cabinet' key='GRN_CAB-40' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page fsp=$sp sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">&lt;&lt;{cb_msg module='grn.cabinet' key='GRN_CAB-41' replace='true'} {$navi.number_on_page} {cb_msg module='grn.cabinet' key='GRN_CAB-42' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.cabinet' key='GRN_CAB-43' replace='true'} {$navi.number_on_page} {cb_msg module='grn.cabinet' key='GRN_CAB-44' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href="{grn_pageurl page=$page fsp=$sp sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cabinet' key='GRN_CAB-45' replace='true'} {$navi.number_on_page} {cb_msg module='grn.cabinet' key='GRN_CAB-46' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.cabinet' key='GRN_CAB-47' replace='true'} {$navi.number_on_page} {cb_msg module='grn.cabinet' key='GRN_CAB-48' replace='true'}&gt;&gt;</span>
{/if}

