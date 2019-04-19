{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}

{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=`$navi.prefix`0 params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.grn' key='GRN_GRN-886' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-887' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=`$navi.prefix``$navi.previous_page_start_position` params=$navi.params fragment=$navi.fragment}">&lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-888' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-889' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-890' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-891' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=`$navi.prefix``$navi.next_page_start_position` params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.grn' key='GRN_GRN-892' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-893' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-894' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-895' replace='true'}&gt;&gt;</span>
{/if}

