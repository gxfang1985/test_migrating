{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class='cabinet'}


<div id="main_menu_part">
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_2'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-2' replace='true'}{/capture}{grn_link page='cabinet/operation/folder_modify' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_2 image='modify20.gif' hid=$folder_id}</span>
{if $folder.movable}
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_3'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-3' replace='true'}{/capture}{grn_link page='cabinet/operation/folder_move' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_3 image='move20.gif' hid=$folder_id}</span>
{else}
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_4'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-4' replace='true'}{/capture}{grn_link page='cabinet/operation/folder_move' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_4 image='move20.gif' hid=$folder_id disabled=1}</span>
{/if}
{if $folder.child_count > 1}
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_5'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-5' replace='true'}{/capture}{grn_link page='cabinet/operation/folder_order' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_5 image='order20.gif' hid=$folder_id}</span>
{else}
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_6'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-6' replace='true'}{/capture}{grn_link page='cabinet/operation/folder_order' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_6 image='order20.gif' hid=$folder_id disabled=1}</span>
{/if}
{if $folder.parent}
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_7'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-7' replace='true'}{/capture}{grn_link page='cabinet/operation/folder_delete' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_7 image='delete20.gif' hid=$folder_id}</span>
{else}
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_8'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-8' replace='true'}{/capture}{grn_link page='cabinet/operation/folder_delete' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_8 image='delete20.gif' hid=$folder_id disabled=1}</span>
{/if}
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_9'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-9' replace='true'}{/capture}{grn_link page='cabinet/operation/folder_disk_size' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_9 image='filesize_list20.gif' hid=$folder_id}</span>
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_10'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-10' replace='true'}{/capture}{grn_link page='cabinet/operation/access_list' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_10 image='access20.gif' nid=$folder_id reset=1}</span>
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_13'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-13' replace='true'}{/capture}{grn_link page='cabinet/operation/privilege_list' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_13 image='manager20.png' nid=$folder_id reset=1}</span>
<span class="menu_item">{capture name='grn_cabinet_operation_GRN_CAB_OP_11'}{cb_msg module='grn.cabinet.operation' key='GRN_CAB_OP-11' replace='true'}{/capture}{grn_link page='cabinet/operation/notify_list' caption=$smarty.capture.grn_cabinet_operation_GRN_CAB_OP_11 image='subscribe20.png' nid=$folder_id}</span>
</div>
<!--menubar_end-->

{include file='cabinet/_folder_view.tpl' page_prefix='cabinet/operation'}

{include file="grn/footer.tpl"}
