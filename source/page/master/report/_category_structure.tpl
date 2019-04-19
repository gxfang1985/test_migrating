{if ! $category_page}{assign var='category_page' value=$page_info.all}{/if}
{if $category.parent}
<div class="tree_item">
{if $mid}
  {capture name='grn_report_GRN_RPRT_101'}{cb_msg module='grn.report' key='GRN_RPRT-101' replace='true'}{/capture}{grn_link image='category20.gif' page=$category_page cid=$category.parent mid=$mid caption=$smarty.capture.grn_report_GRN_RPRT_101}
{else}
  {capture name='grn_report_GRN_RPRT_102'}{cb_msg module='grn.report' key='GRN_RPRT-102' replace='true'}{/capture}{grn_link image='category20.gif' page=$category_page cid=$category.parent caption=$smarty.capture.grn_report_GRN_RPRT_102}
{/if}
</div>
<div class="border-partition-common-grn"></div>
{/if}
{if $category_id != GRN_REPORT_CATEGORY_NONPARTY_ID}
<div class="sub_title">{if $category.cid > 1}{cb_msg module='grn.report' key='GRN_RPRT-103' replace='true'}{/if}{cb_msg module='grn.report' key='GRN_RPRT-104' replace='true'}</div>
 {foreach name=category from=$category.children key=key item=item}
<div class="tree_item">
{if $mid}
  {grn_link image='category20.gif' page=$category_page cid=$item.cid caption=$item.name mid=$mid}{if $item.count > 0}({$item.count}){/if}
{else}
  {grn_link image='category20.gif' page=$category_page cid=$item.cid caption=$item.name}{if $item.count > 0}({$item.count}){/if}
{/if}
</div>
 {/foreach}
{/if}

{if $is_show_no_children && 0 == $smarty.foreach.category.total}
<div><nobr>{cb_msg module='grn.report' key='GRN_RPRT-105' replace='true'}{if $category.cid}{cb_msg module='grn.report' key='GRN_RPRT-106' replace='true'}{/if}{cb_msg module='grn.report' key='GRN_RPRT-107' replace='true'}</nobr></div>
{/if}

{if ! $is_show_no_nonparty}
<div class="border-partition-common-grn"></div>
{if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}
 {grn_image image='category_trush20.gif'}{cb_msg module='grn.report' key='GRN_RPRT-108' replace='true'}
{else}
{if $mid}
 {capture name='grn_report_GRN_RPRT_109'}{cb_msg module='grn.report' key='GRN_RPRT-109' replace='true'}{/capture}{grn_link image='category_trush20.gif' page=$category_page cid=-1 mid=$mid caption=$smarty.capture.grn_report_GRN_RPRT_109}
{else}
 {capture name='grn_report_GRN_RPRT_110'}{cb_msg module='grn.report' key='GRN_RPRT-110' replace='true'}{/capture}{grn_link image='category_trush20.gif' page=$category_page cid=-1 caption=$smarty.capture.grn_report_GRN_RPRT_110}
{/if}
{/if}
{/if}
