{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$folder.name class=$page_info.parts[0]}
 <!--menubar-->

<div id="main_menu_part">
{if !$folder_deleted}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_8'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-8' replace='true'}{/capture}{grn_link page='cabinet/system/folder_add' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_8 image='folder20.gif' hid=$folder_id}</span>
{if $folder_id}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_9'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-9' replace='true'}{/capture}{grn_link page='cabinet/system/folder_view' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_9 image='detail20.gif' hid=$folder_id}</span>
{else}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_10'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-10' replace='true'}{/capture}{grn_link page='cabinet/system/folder_view' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_10 image='detail20.gif' hid=$folder_id disabled=1}</span>
{/if}
{if $folder.child_count > 1 || (! $folder_id && $folder.child_count > 1)}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_11'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-11' replace='true'}{/capture}{grn_link page='cabinet/system/folder_order_all' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_11 image='order20.gif' hid=$folder_id}</span>
{else}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_12'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-12' replace='true'}{/capture}{grn_link page='cabinet/system/folder_order_all' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_12 image='order20.gif' hid=$folder_id disabled=1}</span>
{/if}
{if $folder_id}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_95'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-95' replace='true'}{/capture}{grn_link page='cabinet/system/cabinet_order' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_95 image='disk20.gif' hid=$folder_id}</span>
{/if}
{else}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_96'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-96' replace='true'}{/capture}{grn_link page='cabinet/system/folder_delete_permanent' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_96 image='delete20.gif' hid=$folder_id}</span>
{if $this_folder_actually_not_delete}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_97'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-97' replace='true'}{/capture}{grn_link page='cabinet/system/folder_restore' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_97 image='image-common/restore20.png' hid=$folder_id}</span>
{/if}
{/if}
 <div class="search_navi" align="right">
  {capture name='grn_cabinet_system_GRN_CAB_SY_89'}{$app_name|grn_noescape}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-89' replace='true'}{/capture}
  {grn_simple_search caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_89 name='text' action='cabinet/system/search' page='cabinet/system/search' hid=$folder.hid s_hid=$folder.hid}
 </div>
</div>

{include file="cabinet/_file_list.tpl" page_prefix="cabinet/system" multiselect=1}

{include file="grn/system_footer.tpl"}
