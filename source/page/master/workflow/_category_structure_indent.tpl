{if ! $category_page}{assign var='category_page' value=$page_info.all}{/if}
{if $category.parent}

<div class="tree_item" style="padding-left:20px">
{if $mid}
  {capture name='grn_workflow_up_one_level'}{cb_msg module='grn.workflow' key='up_one_level' replace='true'}{/capture}{grn_link image='category20.gif' page=$category_page cid=$category.parent mid=$mid caption=$smarty.capture.grn_workflow_up_one_level}
{elseif $folder_id && $folder_id == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
  {capture name='grn_workflow_up_one_level'}{cb_msg module='grn.workflow' key='up_one_level' replace='true'}{/capture}{grn_link image='category20.gif' page=$category_page cid=$category.parent fid=$folder_id caption=$smarty.capture.grn_workflow_up_one_level}
{else}
  {capture name='grn_workflow_up_one_level'}{cb_msg module='grn.workflow' key='up_one_level' replace='true'}{/capture}{grn_link image='category20.gif' page=$category_page cid=$category.parent caption=$smarty.capture.grn_workflow_up_one_level}
{/if}
</div>
{/if}
{if $category_id != GRN_WORKFLOW_CATEGORY_NONPARTY_ID}
<div class="sub_title" style="padding-left:20px">{cb_msg module='grn.workflow' key='sub_category' replace='true'}</div>
 {foreach name=category from=$category.children key=key item=item}
<div class="tree_item" style="padding-left:20px">
{if $mid}
  {grn_link image='category20.gif' page=$category_page cid=$item.cid caption=$item.name mid=$mid}{if $item.count > 0}({$item.count}){/if}
{elseif $folder_id && $folder_id == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
  {grn_link image='category20.gif' page=$category_page cid=$item.cid caption=$item.name fid=$folder_id }{if $item.count > 0}({$item.count}){/if}
{else}
  {grn_link image='category20.gif' page=$category_page cid=$item.cid caption=$item.name}{if $item.count > 0}({$item.count}){/if}
{/if}
</div>
 {/foreach}
{/if}

{if $is_show_no_children && 0 == $smarty.foreach.category.total}
<div  style="padding-left:20px"><nobr>{cb_msg module='grn.workflow' key='no_sub_category' replace='true'}</nobr></div>
{/if}

{if ! $is_show_no_nonparty}
<div class="border-partition-common-grn"></div>
{if $category_id == GRN_WORKFLOW_CATEGORY_NONPARTY_ID}
 {grn_image image='category_trush20.gif'}{cb_msg module='grn.workflow' key='nonparty' replace='true'}
{else}
{if $mid}
 {capture name='grn_workflow_nonparty'}{cb_msg module='grn.workflow' key='nonparty' replace='true'}{/capture}{grn_link image='category_trush20.gif' page=$category_page cid=-1 mid=$mid caption=$smarty.capture.grn_workflow_nonparty}
{elseif $folder_id && $folder_id == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID}
 {capture name='grn_workflow_nonparty'}{cb_msg module='grn.workflow' key='nonparty' replace='true'}{/capture}{grn_link image='category_trush20.gif' page=$category_page cid=-1 fid=$folder_id caption=$smarty.capture.grn_workflow_nonparty}
{else}
 {capture name='grn_workflow_nonparty'}{cb_msg module='grn.workflow' key='nonparty' replace='true'}{/capture}{grn_link image='category_trush20.gif' page=$category_page cid=-1 caption=$smarty.capture.grn_workflow_nonparty}
{/if}
{/if}
{/if}
