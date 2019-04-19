{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$category.name class=$page_info.parts[0]}

<div id="main_menu_part">
    {if $is_root || ! $is_manage}{assign var='disabled_flag' value=1}{/if}
    {if $is_nonparty}{assign var='disabled_flag' value=1}{/if}
    {if $is_root || ! $is_manage ||($is_manage && !$isMovable )|| $is_nonparty}{assign var='movable_flag' value=1}{/if}
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_335'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-335' replace='true'}{/capture}{grn_link page='report/operation/category_modify' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_335 image='modify20.gif' cid=$category.cid disabled=$disabled_flag element_id="report/operation/category_modify"}</span>
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_336'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-336' replace='true'}{/capture}{grn_link page='report/operation/category_move' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_336 image='move20.gif' cid=$category.cid s_cid=$parent_category.cid disabled=$movable_flag element_id="report/operation/category_move"}</span>
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_337'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-337' replace='true'}{/capture}{grn_link page='report/operation/category_delete' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_337 image='delete20.gif' cid=$category.cid disabled=$disabled_flag element_id="report/operation/category_delete"}</span>
    <div id="rare_menu_part_under">
        {if $num_children <= 1}{assign var='category_order_disabled' value=1}{/if}
        {if $num_form <= 1}{assign var='form_order_disabled' value=1}{/if}
        <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_338'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-338' replace='true'}{/capture}{grn_link page='report/operation/category_order' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_338 image='order20.gif' pcid=$category.cid disabled=$category_order_disabled element_id="report/operation/category_order"}</span>
        <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_339'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-339' replace='true'}{/capture}{grn_link page='report/operation/form_order' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_339 image='order20.gif' cid=$category.cid disabled=$form_order_disabled element_id="report/operation/form_order"}</span>
    </div>
</div>
 <p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-340' replace='true'}</th>
   <td>{$category.name|escape:"html"}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-341' replace='true'}</th>
{if $is_root}
   <td>--</td>
{elseif $is_nonparty}
   <td>--</td>
{else}
   <td>{grn_image image='category20.gif'}{$parent_category.name|escape:"html"}</td>
{/if}
  </tr>
  <tr>
   <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-342' replace='true'}</th>
{if $is_nonparty}
   <td></td>
{else}
   <td>{$category.foreign_key|escape:"html"}<br></td>
{/if}
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-343' replace='true'}</th>
   <td>
{if 1 > $category.memo|count_characters:true}
    <br>
{else}
    {grn_format body=$category.memo}
{/if}
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-344' replace='true'}</div>
   <td>
{foreach from=$child_categories item=child_category}
    {grn_image image='category20.gif'}{$child_category.name|escape:"html"}
{/foreach}
   </td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-345' replace='true'}</th>
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
      {cb_msg module='grn.report.operation' key='GRN_RPRT_OP-346' replace='true'}
   </th>
{if $is_nonparty}
   <td></td>
{else}
   <td>
       {grn_user_name uid=$category.modifier name=$category.modifier_name}
       {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$category.mtime}
   </td>
{/if}
  </tr>
 </table>

{include file="grn/footer.tpl"}
