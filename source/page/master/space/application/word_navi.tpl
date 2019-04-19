{if $navi.previous_page_start_position != -1}
 <a href={if $ajax_flag}"javascript:void(0);" onclick="__thisPage.getCommentListPage( 0 )"
         {else}"#{$navi.fragment|cat:'&sp=0'}" {/if}>{cb_msg module='grn.grn' key='GRN_GRN-1282' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-1283' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href={if $ajax_flag}"javascript:void(0);" onclick="__thisPage.getCommentListPage( {$navi.previous_page_start_position} )"
         {else}"#{$navi.fragment|cat:'&sp='|cat:$navi.previous_page_start_position}" {/if}>
 &lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-1284' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1285' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-1286' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1287' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href={if $ajax_flag}"javascript:void(0);" onclick="__thisPage.getCommentListPage( {$navi.next_page_start_position} )"
         {else}"#{$navi.fragment|cat:'&sp='|cat:$navi.next_page_start_position}" {/if}>
 {cb_msg module='grn.grn' key='GRN_GRN-1288' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1289' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-1290' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1291' replace='true'}&gt;&gt;</span>
{/if}