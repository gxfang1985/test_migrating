{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$portlet_group.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_458'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-458' replace='true'}{/capture}{grn_link page='portal/system/portlet_group_modify' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_458 image='modify20.gif' plgid=$portlet_group.plgid}</span>
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_459'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-459' replace='true'}{/capture}{grn_link page='portal/system/portlet_group_delete' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_459 image='delete20.gif' plgid=$portlet_group.plgid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-460' replace='true'}
  </th>
  <td>
     {$portlet_group.title|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-461' replace='true'}
  </th>
  <td>
      {foreach from=$portlet_group.portlet item=portlet}{$portlet.title|escape}<br>{/foreach}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-462' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet_group.creator_uid name=$portlet_group.creator_name}
       {grn_date_format date=$portlet_group.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-463' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet_group.modify_uid name=$portlet_group.modify_name}
       {grn_date_format date=$portlet_group.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}
