{*
 * Mobile Page Navigation
 * 
 * Parameters:
 * [navi_info] => [start_count],                           REQUIRE     Start from
 *                [end_count],                             REQUIRE     End to
 *                [navi]=> [page],                                     The page name
 *                         [fragment],                                 Fragments after # 
 *                         [params],                                   Parameters
 *                         [previous_page_start_position], REQUIRE     Previous page start position
 *                         [next_page_start_position],     REQUIRE     Next page start position
 *}
{assign var='navi' value=$navi_info.navi}
{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}
{strip}
  <div class="mobile_paging_grn">
    {if $navi.previous_page_start_position != -1}
      <a href="{grn_pageurl page=$page sp=0 params=$navi.params fragment=$navi.fragment}" class="mobile_back_first_grn"></a>
    {else}
      <a href="javascript:void(0);" class="mobile_back_first_grn mobile_base_disable_grn"></a>
    {/if}
    {if $navi.previous_page_start_position != -1}
      <a href="{grn_pageurl page=$page sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}" class="mobile_back_grn"></a>
    {else}
      <a href="javascript:void(0);" class="mobile_back_grn mobile_base_disable_grn"></a>
    {/if}
    {if $navi.next_page_start_position != -1}
      <a href="{grn_pageurl page=$page sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}" class="mobile_advance_grn"></a>
    {else}
      <a href="javascript:void(0);" class="mobile_advance_grn mobile_base_disable_grn"></a>
    {/if}
    <span class="mobile_page_text_grn">{$navi_info.start_count}-{$navi_info.end_count}</span>
  </div>
{/strip}