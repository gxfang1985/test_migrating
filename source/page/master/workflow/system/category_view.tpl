{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$category.name class=$page_info.parts[0]}

<div id="main_menu_part">
    {if $is_root}{assign var='disabled_flag' value=1}{/if}
    {if $is_nonparty}{assign var='disabled_flag' value=1}{/if}
    <span class="menu_item">{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link page='workflow/system/category_modify' caption=$smarty.capture.grn_workflow_system_w_do_change_y image='modify20.gif' cid=$category.cid disabled=$disabled_flag}</span>
    <span class="menu_item">{capture name='grn_workflow_system_w_move'}{cb_msg module='grn.workflow.system' key='w_move' replace='true'}{/capture}{grn_link page='workflow/system/category_move' caption=$smarty.capture.grn_workflow_system_w_move image='move20.gif' cid=$category.cid s_cid=$parent_category.cid disabled=$disabled_flag}</span>
    <span class="menu_item">{capture name='grn_workflow_system_w_do_delete'}{cb_msg module='grn.workflow.system' key='w_do_delete' replace='true'}{/capture}{grn_link page='workflow/system/category_delete' caption=$smarty.capture.grn_workflow_system_w_do_delete image='delete20.gif' cid=$category.cid disabled=$disabled_flag}</span>
    <div id="rare_menu_part_under">
        {if $num_children <= 1}{assign var='category_order_disabled' value=1}{/if}
        {if $num_form <= 1}{assign var='form_order_disabled' value=1}{/if}
        <span class="menu_item">{capture name='grn_workflow_system_w_changing_sub_category_order'}{cb_msg module='grn.workflow.system' key='w_changing_sub_category_order' replace='true'}{/capture}{grn_link page='workflow/system/category_order' caption=$smarty.capture.grn_workflow_system_w_changing_sub_category_order image='order20.gif' pcid=$category.cid disabled=$category_order_disabled}</span>
        <span class="menu_item">{capture name='grn_workflow_system_w_change_order_app_form_divider_y'}{cb_msg module='grn.workflow.system' key='w_change_order_app_form_divider_y' replace='true'}{/capture}{grn_link page='workflow/system/form_order' caption=$smarty.capture.grn_workflow_system_w_change_order_app_form_divider_y image='order20.gif' cid=$category.cid disabled=$form_order_disabled}</span>
    </div>
</div>

<p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.workflow.system' key='category_csv_name' replace='true'}</th>
   <td>{$category.name|escape:"html"}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.workflow.system' key='w_parent_category_y' replace='true'}</th>
{if $is_root}
   <td>--</td>
{elseif $is_nonparty}
   <td>--</td>
{else}
   <td>{grn_image image='category20.gif'}{$parent_category.name|escape:"html"}</td>
{/if}
  </tr>
  <tr>
   <th>{cb_msg module='grn.workflow.system' key='category_csv_code' replace='true'}</th>
{if $is_nonparty}
   <td></td>
{else}
   <td>{$category.foreign_key|escape:"html"}<br></td>
{/if}
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.workflow.system' key='w_memo' replace='true'}</th>
   <td>
{if 1 > $category.memo|count_characters:true}
    <br>
{else}
    {grn_format body=$category.memo}
{/if}
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.workflow.system' key='w_sub_category' replace='true'}</div>
   <td>
{foreach from=$child_categories item=child_category}
    {grn_image image='category20.gif'}{$child_category.name|escape:"html"}
{/foreach}
   </td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.workflow.system' key='w_registeration_info_y' replace='true'}</th>
{if $is_nonparty}
   <td></td>
{else}
   <td>
       {grn_user_name uid=$category.creator name=$category.creator_name}
       {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$category.ctime}
   </td>
{/if}
  </tr>
  <tr>
   <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_modified_info_y' replace='true'}
   </th>
{if $is_nonparty}
   <td></td>
{else}
   <td>
       {grn_user_name uid=$category.modifier name=$category.modify_name}
       {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$category.mtime}
   </td>
{/if}
  </tr>
 </table>

{include file="grn/system_footer.tpl"}
