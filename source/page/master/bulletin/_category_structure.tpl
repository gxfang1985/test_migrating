{if ! $category_page}{assign var='category_page' value=$page_info.all}{/if}
{if $show_extra}
<div class="tree_item">
{if $page_info.all == 'bulletin/wait_list'}
<span class="hilight"><span class="bold">
 {capture name='grn_bulletin_GRN_BLLT_266'}{cb_msg module='grn.bulletin' key='GRN_BLLT-266' replace='true'}{/capture}{grn_link page='bulletin/wait_list' caption=$smarty.capture.grn_bulletin_GRN_BLLT_266 image='unsentbox20.gif'}
</span></span>
{else}
 {capture name='grn_bulletin_GRN_BLLT_267'}{cb_msg module='grn.bulletin' key='GRN_BLLT-267' replace='true'}{/capture}{grn_link page='bulletin/wait_list' caption=$smarty.capture.grn_bulletin_GRN_BLLT_267 image='unsentbox20.gif'}
{/if}
</div>
<div class="tree_item">
{if $page_info.all == 'bulletin/draft_list'}
<span class="hilight"><span class="bold">
 {capture name='grn_bulletin_GRN_BLLT_268'}{cb_msg module='grn.bulletin' key='GRN_BLLT-268' replace='true'}{/capture}{grn_link page='bulletin/draft_list' caption=$smarty.capture.grn_bulletin_GRN_BLLT_268 image='theme20.gif'}
</span></span>
{else}
 {capture name='grn_bulletin_GRN_BLLT_269'}{cb_msg module='grn.bulletin' key='GRN_BLLT-269' replace='true'}{/capture}{grn_link page='bulletin/draft_list' caption=$smarty.capture.grn_bulletin_GRN_BLLT_269 image='theme20.gif'}
{/if}
</div>
<div class="border-partition-common-grn"></div>
{/if}
{if $category.parent}
<div class="tree_item">
{capture name='grn_bulletin_GRN_BLLT_270'}{cb_msg module='grn.bulletin' key='GRN_BLLT-270' replace='true'}{/capture}{capture name='grn_bulletin_GRN_BLLT_271'}{cb_msg module='grn.bulletin' key='GRN_BLLT-271' replace='true'}{/capture}{grn_link image='category20.gif' page=$category_page cid=$category.parent.cid caption=$smarty.capture.grn_bulletin_GRN_BLLT_270|cat:$category.parent.name|cat:$smarty.capture.grn_bulletin_GRN_BLLT_271}
</div>
<div class="border-partition-common-grn"></div>
{/if}
<div class="sub_title">{if $category.cid > 1}{cb_msg module='grn.bulletin' key='GRN_BLLT-272' replace='true'}{/if}{cb_msg module='grn.bulletin' key='GRN_BLLT-273' replace='true'}</div>
{if $category.cid == 1 && ( $page_info.all == 'bulletin/wait_list' || $page_info.all == 'bulletin/draft_list' )}
<div class="tree_item">
{grn_bulletin_category_title page=$category_page cid=$category.cid caption=$category.name child=$category.child_count subscribed=$category.subscribed notified=$category.notified image='category20.gif'}
</div>
{else}
{foreach from=$category.children key=key item=item}
<div class="tree_item">
{grn_bulletin_category_title page=$category_page cid=$item.cid caption=$item.name child=$item.child_count subscribed=$item.subscribed notified=$item.notified image='category20.gif'}
</div>
{/foreach}
{/if}
