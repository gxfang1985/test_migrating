{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}

<div id="main_menu_part">
{if $category.parent}
<span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_11'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-11' replace='true'}{/capture}{grn_link page='space/system/category_modify' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_11 image='write20.gif' cid=$category_id}</span>
  <span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_12'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-12' replace='true'}{/capture}{grn_link page='space/system/category_move' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_12 image='move20.gif' cid=$category_id}</span>
{else}
<span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_11'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-11' replace='true'}{/capture}{grn_link page='space/system/category_modify' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_11 image='write20.gif' cid=$category_id disabled=1}</span>
  <span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_13'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-13' replace='true'}{/capture}{grn_link page='space/system/category_move' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_13 image='move20.gif' cid=$category_id disabled=1}</span>
{/if}
{if $category.deletable}
<span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_14'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-14' replace='true'}{/capture}{grn_link page='space/system/category_delete' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_14 image='delete20.gif' cid=$category_id}</span>
{else}
<span class="menu_item">{capture name='grn_space_system_GRN_SPACE_SY_15'}{cb_msg module='grn.space.system' key='GRN_SPACE_SY-15' replace='true'}{/capture}{grn_link page='space/system/category_delete' caption=$smarty.capture.grn_space_system_GRN_SPACE_SY_15 image='delete20.gif' cid=$category_id disabled=1}</span>
{/if}
</div>
<p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-16' replace='true'}</th>
   <td>{if $parent_category}{grn_link page='space/system/category_view' cid=$parent_category->getId() image='category20.gif' caption=$parent_category->getCategoryName()}{/if}<br></td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-17' replace='true'}</th>
   <td>{grn_sentence caption=$category_name}<br></td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-18' replace='true'}</th>
   <td>{grn_sentence caption=$category_code}<br></td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-19' replace='true'}</th>
   <td>{grn_sentence caption=$memo}</td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-20' replace='true'}</th>
   <td>
        {foreach from=$category_child item=child}
          {grn_link page='space/system/category_view' cid=$child->getId() image='category20.gif' caption=$child->getCategoryName()}
        {/foreach}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-21' replace='true'}</th>
   <td>{grn_user_name uid=$create_user}&nbsp; {$create_time}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.space.system' key='GRN_SPACE_SY-22' replace='true'}</th>
   <td>{grn_user_name uid=$modify_user name=$modify_username}&nbsp;{$modify_time}</td>
  </tr>
 </table>
{include file="grn/system_footer.tpl"}
