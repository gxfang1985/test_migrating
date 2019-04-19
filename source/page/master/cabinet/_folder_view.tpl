
 <p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-185' replace='true'}</th>
   <td>
{if $folder.parent}
 {if ! $folder.parent.privileges || $folder.parent.privileges.operation}
{grn_link image='folder20.gif' page=$page_prefix|cat:'/folder_view' caption=$folder.parent.name hid=$folder.parent.hid sp=0}{if $folder.parent.child_count}({$folder.parent.child_count}){/if}
 {else}
{grn_link image='folder20.gif' page=$page_prefix|cat:'/folder_view' caption=$folder.parent.name hid=$folder.parent.hid sp=0 disabled=1}{if $folder.parent.child_count}({$folder.parent.child_count}){/if}
 {/if}
{else}
<br>
{/if}
   </td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-186' replace='true'}</th>
   <td>{$folder.name|escape:"html"}<br></td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-187' replace='true'}</th>
   <td>{$folder.foreign_key|escape:"html"}<br></td>
  </tr>
  <tr valign="top">
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-188' replace='true'}</th>
   <td>{grn_format body=$folder.memo}</td>
  </tr>
  <tr valign="top">
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-189' replace='true'}</th>
   <td>
{foreach from=$folder.children item=child}
{grn_link image='folder20.gif' page=$page_prefix|cat:'/folder_view' caption=$child.name hid=$child.hid sp=0}{if $child.child_count}({$child.child_count}){/if} 
{/foreach}
   </td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-190' replace='true'}</th>
   <td>{grn_user_name uid=$folder.creator_uid name=$folder.creator_name}&nbsp;{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$folder.ctime}</td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.cabinet' key='GRN_CAB-191' replace='true'}</th>
   <td>{grn_user_name uid=$folder.modifier_uid name=$folder.modifier_name}&nbsp;{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$folder.mtime}</td>
  </tr>
 </table>
