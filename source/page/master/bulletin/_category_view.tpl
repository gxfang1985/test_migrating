
 <!--menubar_end-->
 <!--view-->
 <table class="view_table mTop10" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-510' replace='true'}</th>
   <td>
{if $category.parent}
 {if $category.parent.privileges}
  {if $category.parent.privileges.operation}
{grn_bulletin_category_title page=$page_prefix|cat:'/category_view' image='category20.gif' caption=$category.parent.name cid=$category.parent.cid sp=0 child=$category.parent.child_count}
  {else}
{grn_bulletin_category_title page=$page_prefix|cat:'/category_view' image='category20.gif' caption=$category.parent.name cid=$category.parent.cid sp=0 child=$category.parent.child_count disabled=1}
  {/if}
 {else}
{grn_bulletin_category_title page=$page_prefix|cat:'/category_view' image='category20.gif' caption=$category.parent.name cid=$category.parent.cid sp=0 child=$category.parent.child_count}
 {/if}
{else}
<br>
{/if}
  </td>
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-511' replace='true'}</th>
   <td id="bulletin_category_title">{$category.name|escape:"html"}<br></td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-512' replace='true'}</th>
   <td>{$category.foreign_key|escape:"html"}<br></td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-513' replace='true'}</th>
   <td id="bulletin_category_memo">{grn_format body=$category.memo}</td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-514' replace='true'}</th>
   <td>
{foreach from=$category.children item=child}
{grn_bulletin_category_title page=$page_prefix|cat:'/category_view' image='category20.gif' caption=$child.name child=$child.child_count cid=$child.cid sp=0} 
{/foreach}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-515' replace='true'}</th>
   <td>{grn_user_name uid=$category.creator_uid name=$category.creator_name}&nbsp;{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$category.ctime}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.bulletin' key='GRN_BLLT-516' replace='true'}</th>
   <td>{grn_user_name uid=$category.modifier_uid name=$category.modifier_name}&nbsp;{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$category.mtime}</td>
  </tr>
 </table>

