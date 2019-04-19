<table border="0" cellspacing="0" style="clear:both;" width="100%"><tbody><tr class="navi"><td width="1px">
<div class="mail-pagingListBlock-grn">
{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}

{if $ajax_flag}
  {assign var=bd_func value="cy_gw_bd(this, $plid);"}
{/if}

{if $navi.previous_page_start_position != -1}
<span class="mail-pagingButton-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1282' replace='true'}"><a href="{grn_pageurl page=$page sp=0 params=$navi.params fragment=$navi.fragment}" {if $ajax_flag}onclick="{$bd_func}"{/if}><span class="mail-pagingButtonArrowFirst-grn"></span></a></span>
{else}
 <span class="mail-pagingButtonDisable-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1282' replace='true'}"><span class="mail-pagingButtonArrowFirstDisable-grn"></span></span>
{/if}
{if $navi.previous_page_start_position != -1}
 <span class="mail-pagingButton-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1284' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}"><a href="{grn_pageurl page=$page sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}" {if $ajax_flag}onclick="{$bd_func}"{/if}><span class="mail-pagingbuttonArrowLeft-grn"></span></a></span>
{else}
 <span class="mail-pagingButtonDisable-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1286' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}"><span class="mail-pagingbuttonArrowLeftDisable-grn"></span></span>
{/if}
{if $navi.next_page_start_position != -1}
 <span class="mail-pagingButton-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1288' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}"><a href="{grn_pageurl page=$page sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}" {if $ajax_flag}onclick="{$bd_func}"{/if}><span class="mail-pagingbuttonArrowRight-grn"></span></a></span>
{else}
 <span class="mail-pagingButtonDisable-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-1288' replace='true'} {$navi.number_on_page} {cb_msg module='grn.grn' key='GRN_GRN-1551' replace='true'}"><span class="mail-pagingbuttonArrowRightDisable-grn"></span></span>
{/if}
</div>
</td>
<td valgin="bottom" align="left">
<div class="sub_title numberList" align="left">{$navi_right|grn_noescape}</div>
</td>
</tr></tbody></table>
