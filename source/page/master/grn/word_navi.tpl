{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}

{if $ajax_flag}
  {assign var=bd_func value="cy_gw_bd(this, $plid);"}
{/if}

{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=0 params=$navi.params fragment=$navi.fragment}" {if $ajax_flag}onclick="{$bd_func}"{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1282' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-1283' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}" {if $ajax_flag}onclick="{$bd_func}"{/if}>&lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-1284' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1285' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-1286' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1287' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}" {if $ajax_flag}onclick="{$bd_func}"{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1288' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1289' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-1290' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1291' replace='true'}&gt;&gt;</span>
{/if}

