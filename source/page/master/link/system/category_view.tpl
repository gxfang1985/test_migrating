{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$category.title class=$page_info.parts[0]}

<div id="main_menu_part">
    {if $is_root}{assign var='root_disabled' value=1}{/if}
    <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_127'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-127' replace='true'}{/capture}{grn_link page='link/system/category_modify' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_127 image='modify20.gif' cid=$category.cid disabled=$root_disabled}</span>
    <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_128'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-128' replace='true'}{/capture}{grn_link page='link/system/category_move' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_128 image='move20.gif' cid=$category.cid s_cid=$category.parent_category.cid disabled=$root_disabled}</span>
    <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_129'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-129' replace='true'}{/capture}{grn_link page='link/system/category_delete' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_129 image='delete20.gif' cid=$category.cid disabled=$root_disabled}</span>
    <div id="rare_menu_part_under">
        {if $category.num_children <= 1}{assign var='category_order_disabled' value=1}{/if}
        <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_130'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-130' replace='true'}{/capture}{grn_link page='link/system/category_order' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_130 image='order20.gif' pcid=$category.cid disabled=$category_order_disabled}</span>
        {if $category.num_link <= 1}{assign var='order_disabled' value=1}{/if}
        <span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_131'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-131' replace='true'}{/capture}{grn_link page='link/system/order' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_131 image='order20.gif' cid=$category.cid disabled=$order_disabled}</span>
    </div>
</div>

 <p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-133' replace='true'}</th>
   <td>{$category.title|escape}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-134' replace='true'}</th>
{if $is_root}
   <td>--</td>
{else}
   <td>{grn_image image='category20.gif'}{$category.parent_category.title|escape}</td>
{/if}
  </tr>
  <tr>
   <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-135' replace='true'}</th>
   <td>{$category.foreign_key|escape:"html"}<br></td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-136' replace='true'}</th>
   <td>
{if 1 > $category.memo|count_characters:true}
    <br>
{else}
    {grn_format body=$category.memo}
{/if}
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-137' replace='true'}</div>
   <td>
{foreach from=$category.child_categories item=child_categories}
    {grn_image image='category20.gif'}{$child_categories.title|escape:"html"}
{/foreach}
   </td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.link.system' key='GRN_LNK_SY-138' replace='true'}</th>
   <td>
       {grn_user_name uid=$category.creator_uid name=$category.creator_name}
       {grn_date_format format='DateTimeFull_YMDW_HM' date=$category.ctime}
   </td>
  </tr>
  <tr>
   <th nowrap>
      {cb_msg module='grn.link.system' key='GRN_LNK_SY-139' replace='true'}
   </th>
   <td>
       {grn_user_name uid=$category.modify_uid name=$category.modify_name}
       {grn_date_format format='DateTimeFull_YMDW_HM' date=$category.mtime}
   </td>
  </tr>
 </table>

{include file="grn/system_footer.tpl"}
