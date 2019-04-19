{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

<div id="main_menu_part">
<span class="nowrap-grn">
<span class="menu_item">{capture name='grn_bulletin_operation_GRN_BLLT_OP_11'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-11' replace='true'}{/capture}{grn_link page='bulletin/operation/category_modify' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_11 image='write20.gif' cid=$category_id}</span>
{if $category.movable}
<span class="menu_item">{capture name='grn_bulletin_operation_GRN_BLLT_OP_12'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-12' replace='true'}{/capture}{grn_link page='bulletin/operation/category_move' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_12 image='move20.gif' cid=$category_id}</span>
{else}
<span class="menu_item">{capture name='grn_bulletin_operation_GRN_BLLT_OP_13'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-13' replace='true'}{/capture}{grn_link page='bulletin/operation/category_move' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_13 image='move20.gif' cid=$category_id disabled=1}</span>
{/if}
{if $category.deletable}
<span class="menu_item">{capture name='grn_bulletin_operation_GRN_BLLT_OP_14'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-14' replace='true'}{/capture}{grn_link page='bulletin/operation/category_delete' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_14 image='delete20.gif' cid=$category_id}</span>
{else}
<span class="menu_item">{capture name='grn_bulletin_operation_GRN_BLLT_OP_15'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-15' replace='true'}{/capture}{grn_link page='bulletin/operation/category_delete' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_15 image='delete20.gif' cid=$category_id disabled=1}</span>
{/if}
<span class="menu_item">{capture name='grn_bulletin_operation_GRN_BLLT_OP_16'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-16' replace='true'}{/capture}{grn_link page='bulletin/operation/access_list' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_16 image='access20.gif' nid=$category_id reset=1}</span>
<span class="menu_item">{capture name='grn_bulletin_operation_GRN_BLLT_OP_35'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-35' replace='true'}{/capture}{grn_link page='bulletin/operation/privilege_list' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_35 image='manager20.png' nid=$category_id}</span>
<span class="menu_item">{capture name='grn_bulletin_operation_GRN_BLLT_OP_17'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-17' replace='true'}{/capture}{grn_link page='bulletin/operation/notify_list' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_17 image='subscribe20.png' nid=$category_id}</span>
</span>
</div>

<div class="bulletin_title_grn">
    {grn_title title=$category.name class=$page_info.parts[0]}
</div>
{include file='bulletin/_category_view.tpl' page_prefix='bulletin/operation'}

{include file="grn/footer.tpl"}
