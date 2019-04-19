{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$folder.name class='cabinet'}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_23'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-23' replace='true'}{/capture}{grn_link page='cabinet/system/folder_modify' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_23 image='modify20.gif' hid=$folder_id}</span>
  {if $folder.movable}
  <span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_24'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-24' replace='true'}{/capture}{grn_link page='cabinet/system/folder_move' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_24 image='move20.gif' hid=$folder_id}</span>
  {else}
  <span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_25'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-25' replace='true'}{/capture}{grn_link page='cabinet/system/folder_move' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_25 image='move20.gif' hid=$folder_id disabled=1}</span>
  {/if}
<!--
{if $folder.child_count > 1}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_26'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-26' replace='true'}{/capture}{grn_link page='cabinet/system/folder_order' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_26 image='order20.gif' hid=$folder_id}</span>
{else}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_27'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-27' replace='true'}{/capture}{grn_link page='cabinet/system/folder_order' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_27 image='order20.gif' hid=$folder_id disabled=1}</span>
{/if}
-->
{if $folder_id == 1}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_28'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-28' replace='true'}{/capture}{grn_link page='cabinet/system/folder_delete' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_28 image='delete20.gif' hid=$folder_id disabled=1}
{else}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_29'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-29' replace='true'}{/capture}{grn_link page='cabinet/system/folder_delete' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_29 image='delete20.gif' hid=$folder_id}
{/if}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_30'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-30' replace='true'}{/capture}{grn_link page='cabinet/system/folder_disk_size' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_30 image='filesize_list20.gif' hid=$folder_id}</span>
<!--
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_31'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-31' replace='true'}{/capture}{grn_link page='cabinet/system/access_list' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_31 image='access20.gif' nid=$folder_id}
<span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_32'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-32' replace='true'}{/capture}{grn_link page='cabinet/system/notify_list' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_32 image='notify20.gif' nid=$folder_id}
-->
</div>

{include file='cabinet/_folder_view.tpl' page_prefix='cabinet/system'}

{include file="grn/system_footer.tpl"}
