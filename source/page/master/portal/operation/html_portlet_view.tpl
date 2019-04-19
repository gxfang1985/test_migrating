{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$portlet.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_portal_operation_GRN_POT_OP_203'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-203' replace='true'}{/capture}{grn_link page='portal/operation/html_portlet_modify' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_203 image='modify20.gif' plid=$portlet.plid}</span>
<span class="menu_item">{capture name='grn_portal_operation_GRN_POT_OP_204'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-204' replace='true'}{/capture}{grn_link page='portal/operation/html_portlet_delete' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_204 image='delete20.gif' plid=$portlet.plid}</span>
<span class="menu_item">{capture name='grn_portal_operation_GRN_POT_OP_205'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-205' replace='true'}{/capture}{grn_link page='portal/operation/html_portlet_preview' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_205 image='view20.gif' plid=$portlet.plid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.operation' key='GRN_POT_OP-206' replace='true'}
  </th>
  <td>
      {$portlet.title|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.operation' key='GRN_POT_OP-207' replace='true'}
  </th>
  <td>
      {$portlet.group|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-167' replace='true'}{$app_name|escape}
  </th>
  <td>
      {if $portlet.my_portal}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-208' replace='true'}{else}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-209' replace='true'}{/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.portal.operation' key='GRN_POT_OP-210' replace='true'}
  </th>
  <td>
   {if $portlet.editor==0}{grn_format body=$portlet.data nolink=true}{else}{$portlet.data|escape}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.operation' key='GRN_POT_OP-211' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet.creator_uid name=$portlet.creator_name}
       {grn_date_format date=$portlet.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.operation' key='GRN_POT_OP-212' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$portlet.modify_uid name=$portlet.modify_name}
       {grn_date_format date=$portlet.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file='grn/footer.tpl'}
