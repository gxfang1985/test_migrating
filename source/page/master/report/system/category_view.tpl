{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$category.name class=$page_info.parts[0]}

<div id="main_menu_part">
    {if $is_root}{assign var='disabled_flag' value=1}{/if}
    {if $is_nonparty}{assign var='disabled_flag' value=1}{/if}
    <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_408'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-408' replace='true'}{/capture}{grn_link page='report/system/category_modify' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_408 image='modify20.gif' cid=$category.cid disabled=$disabled_flag}</span>
    <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_409'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-409' replace='true'}{/capture}{grn_link page='report/system/category_move' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_409 image='move20.gif' cid=$category.cid s_cid=$parent_category.cid disabled=$disabled_flag}</span>
    <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_410'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-410' replace='true'}{/capture}{grn_link page='report/system/category_delete' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_410 image='delete20.gif' cid=$category.cid disabled=$disabled_flag}</span>
    <div id="rare_menu_part_under">
    {if $num_children <= 1}{assign var='category_order_disabled' value=1}{/if}
    {if $num_form <= 1}{assign var='form_order_disabled' value=1}{/if}
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_411'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-411' replace='true'}{/capture}{grn_link page='report/system/category_order' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_411 image='order20.gif' pcid=$category.cid disabled=$category_order_disabled}</span>
        <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_412'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-412' replace='true'}{/capture}{grn_link page='report/system/form_order' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_412 image='order20.gif' cid=$category.cid disabled=$form_order_disabled}</span>
    </div>
</div>
 <p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-413' replace='true'}</th>
   <td>{$category.name|escape:"html"}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-414' replace='true'}</th>
{if $is_root}
   <td>--</td>
{elseif $is_nonparty}
   <td>--</td>
{else}
   <td>{grn_image image='category20.gif'}{$parent_category.name|escape:"html"}</td>
{/if}
  </tr>
  <tr>
   <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-415' replace='true'}</th>
{if $is_nonparty}
   <td></td>
{else}
   <td>{$category.foreign_key|escape:"html"}<br></td>
{/if}
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-416' replace='true'}</th>
   <td>
{if 1 > $category.memo|count_characters:true}
    <br>
{else}
    {grn_format body=$category.memo}
{/if}
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-417' replace='true'}</div>
   <td>
{foreach from=$child_categories item=child_category}
    {grn_image image='category20.gif'}{$child_category.name|escape:"html"}
{/foreach}
   </td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-418' replace='true'}</th>
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
      {cb_msg module='grn.report.system' key='GRN_RPRT_SY-419' replace='true'}
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

{include file="grn/system_footer.tpl"}
