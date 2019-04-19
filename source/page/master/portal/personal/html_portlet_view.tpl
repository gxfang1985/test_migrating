{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$portlet.title class=$page_info.parts[0]}
{grn_delete title=$delete_info.title page=$delete_info.page handler=$delete_info.handler data=$delete_info.data}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_personal_GRN_POT_PE_159'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-159' replace='true'}{/capture}{grn_link page='portal/personal/html_portlet_modify' caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_159 image='modify20.gif' plid=$portlet.plid}</span>
<span class="menu_item">{capture name='grn_portal_personal_GRN_POT_PE_160'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-160' replace='true'}{/capture}{grn_link page='portal/personal/html_portlet_delete' caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_160 image='delete20.gif' plid=$portlet.plid id='lnk_delete' script='javascript:void(0);'}</span>
<span class="menu_item">{capture name='grn_portal_personal_GRN_POT_PE_161'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-161' replace='true'}{/capture}{grn_link page='portal/personal/html_portlet_preview' caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_161 image='view20.gif' plid=$portlet.plid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-162' replace='true'}
  </th>
  <td>
      {$portlet.title|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-163' replace='true'}
  </th>
  <td>
      {$portlet.group|escape}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-164' replace='true'}
  </th>
  <td>
       {if $portlet.editor==0}{grn_format body=$portlet.data nolink=true}{else}{$portlet.data|escape}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-165' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet.creator_uid name=$portlet.creator_name}
       {grn_date_format date=$portlet.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-166' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet.modify_uid name=$portlet.modify_name}
       {grn_date_format date=$portlet.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file='grn/personal_footer.tpl'}
