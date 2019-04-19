{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}

<div id="main_menu_part">
<span class="nowrap-grn">
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_67'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-67' replace='true'}{/capture}{grn_link page='bulletin/system/category_modify' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_67 image='write20.gif' cid=$category_id}</span>
{if $category.parent}
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_68'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-68' replace='true'}{/capture}{grn_link page='bulletin/system/category_move' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_68 image='move20.gif' cid=$category_id}</span>
{else}
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_69'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-69' replace='true'}{/capture}{grn_link page='bulletin/system/category_move' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_69 image='move20.gif' cid=$category_id disabled=1}</span>
{/if}
{if $category.deletable}
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_70'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-70' replace='true'}{/capture}{grn_link page='bulletin/system/category_delete' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_70 image='delete20.gif' cid=$category_id}</span>
{else}
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_71'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-71' replace='true'}{/capture}{grn_link page='bulletin/system/category_delete' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_71 image='delete20.gif' cid=$category_id disabled=1}</span>
{/if}
</span>
</div>

<div class="bulletin_title_grn">
    {grn_title title=$category.name class=$page_info.parts[0]}
</div>
{include file='bulletin/_category_view.tpl' page_prefix='bulletin/system'}

{include file="grn/system_footer.tpl"}
