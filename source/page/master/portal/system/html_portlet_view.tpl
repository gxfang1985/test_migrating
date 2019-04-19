{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$portlet.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_506'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-506' replace='true'}{/capture}{grn_link page='portal/system/html_portlet_modify' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_506 image='modify20.gif' plid=$portlet.plid}</span>
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_507'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-507' replace='true'}{/capture}{grn_link page='portal/system/html_portlet_delete' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_507 image='delete20.gif' plid=$portlet.plid}</span>
<span class="menu_item">{capture name='grn_portal_system_GRN_POT_SY_508'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-508' replace='true'}{/capture}{grn_link page='portal/system/html_portlet_preview' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_508 image='view20.gif' plid=$portlet.plid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-509' replace='true'}
  </th>
  <td>
      {$portlet.title|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-510' replace='true'}
  </th>
  <td>
      {$portlet.group|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-511' replace='true'}
  </th>
  <td>
      {if $portlet.my_portal}{cb_msg module='grn.portal.system' key='GRN_POT_SY-512' replace='true'}{else}{cb_msg module='grn.portal.system' key='GRN_POT_SY-513' replace='true'}{/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-514' replace='true'}
  </th>
  <td>
   {if $portlet.editor==0}{grn_format body=$portlet.data nolink=true}{else}{$portlet.data|escape}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-515' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet.creator_uid name=$portlet.creator_name}
       {grn_date_format date=$portlet.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-516' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet.modify_uid name=$portlet.modify_name}
       {grn_date_format date=$portlet.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}
