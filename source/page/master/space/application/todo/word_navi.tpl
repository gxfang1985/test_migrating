{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}

{assign var=params value=$navi.params}

{if $navi.previous_page_start_position != -1}
 <a href={if $ajax_flag}"javascript:void(0);" onclick="__thisPage.getCommentListPage( 0 )"
         {else}"{grn_pageurl page=$page sp=0 params=$params fragment=$navi.fragment}" {/if}>{cb_msg module='grn.grn' key='GRN_GRN-1282' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-1283' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href={if $ajax_flag}"javascript:void(0);" onclick="__thisPage.getCommentListPage( {$navi.previous_page_start_position} )"
         {else}"{grn_pageurl page=$page sp=$navi.previous_page_start_position params=$params fragment=$navi.fragment}" {/if}>
         &lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-1284' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1285' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-1286' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1287' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href={if $ajax_flag}"javascript:void(0);" onclick="__thisPage.getCommentListPage( {$navi.next_page_start_position} )"
         {else}"{grn_pageurl page=$page sp=$navi.next_page_start_position params=$params fragment=$navi.fragment}" {/if}>
         {cb_msg module='grn.grn' key='GRN_GRN-1288' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1289' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-1290' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1291' replace='true'}&gt;&gt;</span>
{/if}

