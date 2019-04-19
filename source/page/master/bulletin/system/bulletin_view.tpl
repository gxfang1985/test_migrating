{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}

{include file='bulletin/_article_view.tpl' page_prefix='bulletin/system' disable_unread=1}

{**
<!--menubar-->
<div id="main_menu_part">
{grn_previous_next_navi previous=$navi.prev next=$navi.next}
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_149'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-149' replace='true'}{/capture}{grn_link page='bulletin/system/bulletin_move' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_149 image='modify20.gif' cid=$article.cid aid=$article.aid}</span>
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_150'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-150' replace='true'}{/capture}{grn_link page='bulletin/system/bulletin_delete' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_150 image='delete20.gif' cid=$category_id aid=$article.aid}</span>
<span class="menu_item">{capture name='grn_bulletin_system_GRN_BLLT_SYS_151'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-151' replace='true'}{/capture}{grn_link page='bulletin/system/bulletin_accessory' caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_151 image='file20.gif' cid=$category_id aid=$article.aid}</span>
</div>
<!--menubar_end-->

{include file='bulletin/_view.tpl' show_state=1 disable_follow=1 page_prefix='bulletin/system'}
**}

{include file="grn/system_footer.tpl"}
