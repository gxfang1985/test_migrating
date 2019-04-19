{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$portlet_group.title class=$page_info.parts[0]}
{grn_delete title=$delete_info.title page=$delete_info.page handler=$delete_info.handler data=$delete_info.data}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_personal_GRN_POT_PE_145'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-145' replace='true'}{/capture}{grn_link page='portal/personal/portlet_group_modify' caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_145 image='modify20.gif' plgid=$portlet_group.plgid}</span>
<span class="menu_item">{capture name='grn_portal_personal_GRN_POT_PE_146'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-146' replace='true'}{/capture}{grn_link page='portal/personal/portlet_group_delete' caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_146 image='delete20.gif' plgid=$portlet_group.plgid id='lnk_delete' script='javascript:void(0);'}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-147' replace='true'}
  </th>
  <td>
      {$portlet_group.title|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-148' replace='true'}
  </th>
  <td>
      {foreach from=$portlet_group.portlet item=portlet}{$portlet.title|escape}<br>{/foreach}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-150' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet_group.creator_uid name=$portlet_group.creator_name}
       {grn_date_format date=$portlet_group.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-151' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet_group.modify_uid name=$portlet_group.modify_name}
       {grn_date_format date=$portlet_group.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file='grn/personal_footer.tpl'}
