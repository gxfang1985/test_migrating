{* show category list, the selected category is highlighted *}
<div id="tree_structure">
 <div class="items">
  <div class="parent">
{if $page_info.all == 'message/index'}
   {capture name='grn_message_GRN_MSG_280'}{cb_msg module='grn.message' key='GRN_MSG-280' replace='true'}{/capture}{grn_structure_link page='message/index' caption='[$smarty.capture.grn_message_GRN_MSG_280]' class='inbox20' focus=TURE}
{else}
   {capture name='grn_message_GRN_MSG_281'}{cb_msg module='grn.message' key='GRN_MSG-281' replace='true'}{/capture}{grn_structure_link page='message/index' caption='[$smarty.capture.grn_message_GRN_MSG_281]' class='inbox20'}
{/if}
{if $page_info.all == 'message/sent_list'}
   {capture name='grn_message_GRN_MSG_282'}{cb_msg module='grn.message' key='GRN_MSG-282' replace='true'}{/capture}{grn_structure_link page='message/sent_list' caption='[$smarty.capture.grn_message_GRN_MSG_282]' class='sentbox20' focus=TURE}
{else}
   {capture name='grn_message_GRN_MSG_283'}{cb_msg module='grn.message' key='GRN_MSG-283' replace='true'}{/capture}{grn_structure_link page='message/sent_list' caption='[$smarty.capture.grn_message_GRN_MSG_283]' class='sentbox20'}
{/if}
{if $page_info.all == 'message/draft_list'}
   {capture name='grn_message_GRN_MSG_284'}{cb_msg module='grn.message' key='GRN_MSG-284' replace='true'}{/capture}{grn_structure_link page='message/draft_list' caption='[$smarty.capture.grn_message_GRN_MSG_284]' class='unsentbox20' focus=TURE}
{else}
   {capture name='grn_message_GRN_MSG_285'}{cb_msg module='grn.message' key='GRN_MSG-285' replace='true'}{/capture}{grn_structure_link page='message/draft_list' caption='[$smarty.capture.grn_message_GRN_MSG_285]' class='unsentbox20'}
{/if}
   <div class="border-partition-common-grn"></div>
{if $category}
 {foreach from=$category item=categories}
  {if $categories.child}
    {grn_structure_link page='message/category_list' caption=$categories.title class='folder20_f' setup=$categories.setup cid=$categories.cid}
  {else}
    {grn_structure_link page='message/category_list' caption=$categories.title class='folder20' setup=$categories.setup cid=$categories.cid}
  {/if}
 {/foreach}
{/if}
   <div class="br">&nbsp;</div>
{if $page_info.all == 'message/trash_list'}
   {capture name='grn_message_GRN_MSG_286'}{cb_msg module='grn.message' key='GRN_MSG-286' replace='true'}{/capture}{grn_structure_link page='message/trash_list' caption='[$smarty.capture.grn_message_GRN_MSG_286]' class='trashbox20' focus=TURE}
{else}
   {capture name='grn_message_GRN_MSG_287'}{cb_msg module='grn.message' key='GRN_MSG-287' replace='true'}{/capture}{grn_structure_link page='message/trash_list' caption='[$smarty.capture.grn_message_GRN_MSG_287]' class='trashbox20'}
{/if}
  </div>
 </div>
 <!-----><div class="br">&nbsp;</div>
</div>
